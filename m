Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E469572D9
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 22:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfFZUoT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 16:44:19 -0400
Received: from fnsib-smtp07.srv.cat ([46.16.61.68]:46061 "EHLO
        fnsib-smtp07.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUoT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:44:19 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp07.srv.cat (Postfix) with ESMTPSA id 82E90819E;
        Wed, 26 Jun 2019 22:44:15 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Cc:     Ander Juaristi <a@juaristi.eus>
Subject: [PATCH v2 6/7] nftables: Compute result modulo 86400 in case gmtoff is negative
Date:   Wed, 26 Jun 2019 22:44:01 +0200
Message-Id: <20190626204402.5257-6-a@juaristi.eus>
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
 src/meta.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/meta.c b/src/meta.c
index 819e61d..c7ee062 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -518,7 +518,7 @@ static struct error_record *day_type_parse(const struct expr *sym,
 		return error(&sym->location, "Day name must be at least three characters long");
 	}
 
-	for (unsigned i = 0; i < numdays && daynum == -1; i++) {
+	for (int i = 0; i < numdays && daynum == -1; i++) {
 		daylen = strlen(days[i]);
 
 		if (strncasecmp(sym->identifier,
@@ -621,8 +621,8 @@ convert:
 
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

