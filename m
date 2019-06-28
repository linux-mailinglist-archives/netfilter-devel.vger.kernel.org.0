Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A975946F
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jun 2019 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfF1Gx0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jun 2019 02:53:26 -0400
Received: from fnsib-smtp05.srv.cat ([46.16.61.54]:46958 "EHLO
        fnsib-smtp05.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbfF1Gx0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:53:26 -0400
Received: from bubu.das-nano.com (242.red-83-48-67.staticip.rima-tde.net [83.48.67.242])
        by fnsib-smtp05.srv.cat (Postfix) with ESMTPSA id B9DBC1EF1A0
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Jun 2019 08:53:23 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v3 3/4] Compute result modulo 86400 in case gmtoff is negative
Date:   Fri, 28 Jun 2019 08:53:18 +0200
Message-Id: <20190628065319.15834-3-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628065319.15834-1-a@juaristi.eus>
References: <20190628065319.15834-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 src/meta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/meta.c b/src/meta.c
index 152d97d..41f5fa9 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -516,7 +516,7 @@ static struct error_record *day_type_parse(const struct expr *sym,
 		return error(&sym->location, "Day name must be at least three characters long");
 	}
 
-	for (unsigned i = 0; i < numdays && daynum == -1; i++) {
+	for (int i = 0; i < numdays && daynum == -1; i++) {
 		daylen = strlen(days[i]);
 
 		if (strncasecmp(sym->identifier,
@@ -619,8 +619,8 @@ convert:
 
 	/* Substract tm_gmtoff to get the current time */
 	if (cur_tm) {
-		if (result >= cur_tm->tm_gmtoff)
-			result -= cur_tm->tm_gmtoff;
+		if ((long int) result >= cur_tm->tm_gmtoff)
+			result = (result - cur_tm->tm_gmtoff) % 86400;
 		else
 			result = 86400 - cur_tm->tm_gmtoff + result;
 	}
-- 
2.17.1

