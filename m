Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8861572D5
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 22:44:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbfFZUoO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 16:44:14 -0400
Received: from fnsib-smtp07.srv.cat ([46.16.61.68]:47646 "EHLO
        fnsib-smtp07.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUoO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:44:14 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp07.srv.cat (Postfix) with ESMTPSA id 909DC81A8;
        Wed, 26 Jun 2019 22:44:10 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Cc:     Ander Juaristi <a@juaristi.eus>
Subject: [PATCH v2 3/7] nftables: meta: time: Proper handling of DST
Date:   Wed, 26 Jun 2019 22:43:58 +0200
Message-Id: <20190626204402.5257-3-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626204402.5257-1-a@juaristi.eus>
References: <20190626204402.5257-1-a@juaristi.eus>
Reply-To: a@juaristi.eus
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 src/meta.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/meta.c b/src/meta.c
index 39e551c..bfe8aaa 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -408,6 +408,7 @@ static void date_type_print(const struct expr *expr, struct output_ctx *octx)
 static time_t parse_iso_date(const char *sym)
 {
 	time_t ts = time(NULL);
+	long int gmtoff;
 	struct tm tm, *cur_tm;
 
 	memset(&tm, 0, sizeof(struct tm));
@@ -433,7 +434,10 @@ success:
 		return ts;
 
 	/* Substract tm_gmtoff to get the current time */
-	return ts - cur_tm->tm_gmtoff;
+	gmtoff = cur_tm->tm_gmtoff;
+	if (cur_tm->tm_isdst == 1)
+		gmtoff -= 3600;
+	return ts - gmtoff;
 }
 
 static struct error_record *date_type_parse(const struct expr *sym,
-- 
2.17.1

