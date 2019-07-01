Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA05C433
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 22:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfGAUQz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 16:16:55 -0400
Received: from fnsib-smtp06.srv.cat ([46.16.61.61]:56835 "EHLO
        fnsib-smtp06.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbfGAUQz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 16:16:55 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp06.srv.cat (Postfix) with ESMTPSA id ED27AD9C55
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 22:16:51 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v4 2/4] meta: Parse 'time' type with timegm()
Date:   Mon,  1 Jul 2019 22:16:44 +0200
Message-Id: <20190701201646.7040-2-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190701201646.7040-1-a@juaristi.eus>
References: <20190701201646.7040-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use timegm() to parse the 'time' time. The timegm() function is only
available on Linux, but overwriting the TZ environment variable seems to
be a much worse solution.

The problem is that we need to convert an ISO date to a timestamp
without taking into account the time zone offset, since comparison will
be done in kernel space and there is no time zone information there.

Overwriting TZ is portable, but will cause problems when parsing a
ruleset that has 'time' and 'hour' rules. Parsing an 'hour' type must
not do time zone conversion, but that will be automatically done if TZ has
been overwritten to UTC.

We could record the initial setting of the
TZ variable on start, but there's no reliable way to do that (we'd have
to store the initial TZ in a global variable at program start and re-set
it every time we parse an 'hour' value).

Hence it's better idea to use timegm(), even though it's non-portable.
Netfilter is a Linux program after all.

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 src/meta.c | 33 +++++++++++++++++++++++++--------
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/src/meta.c b/src/meta.c
index 41405f1..6f8b842 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -390,15 +390,30 @@ const struct datatype ifname_type = {
 static void date_type_print(const struct expr *expr, struct output_ctx *octx)
 {
 	char timestr[21];
-	struct tm *tm;
+	struct tm *tm, *cur_tm;
+	long int gmtoff;
+	time_t cur_ts = time(NULL);
 	uint64_t tstamp = mpz_get_uint64(expr->value);
 
 	if (!nft_output_seconds(octx)) {
-		if ((tm = localtime((time_t *) &tstamp)) == NULL ||
-			!strftime(timestr, sizeof(timestr) - 1, "%F %T", tm))
+		/* Obtain current tm, to add tm_gmtoff to the timestamp */
+		cur_tm = localtime(&cur_ts);
+
+		/* Adjust the GMT offset */
+		if (cur_tm) {
+			gmtoff = cur_tm->tm_gmtoff;
+			if (cur_tm->tm_isdst == 1)
+				gmtoff -= 3600;
+
+			tstamp += gmtoff;
+		}
+
+		if ((tm = gmtime((time_t *) &tstamp)) != NULL &&
+			strftime(timestr, sizeof(timestr) - 1, "%F %T", tm))
+			nft_print(octx, "\"%s\"", timestr);
+		else
 			nft_print(octx, "Error converting timestamp to printed time");
 
-		nft_print(octx, "\"%s\"", timestr);
 		return;
 	}
 
@@ -426,10 +441,12 @@ static time_t parse_iso_date(const char *sym)
 	return -1;
 
 success:
-	setenv("TZ", "UTC", true);
-	tzset();
-
-	ts = mktime(&tm);
+	/*
+	 * Overwriting TZ is problematic if we're parsing hour types in this same process,
+	 * hence I'd rather use timegm() which doesn't take into account the TZ env variable,
+	 * even though it's Linux-specific.
+	 */
+	ts = timegm(&tm);
 	if (ts == (time_t) -1 || cur_tm == NULL)
 		return ts;
 
-- 
2.17.1

