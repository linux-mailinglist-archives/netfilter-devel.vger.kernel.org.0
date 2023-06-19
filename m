Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C484735DC4
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Jun 2023 21:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjFSTJ0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Jun 2023 15:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjFSTJZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Jun 2023 15:09:25 -0400
Received: from taras.nevrast.org (unknown [IPv6:2a05:d01c:431:aa03:b7e1:333d:ea2a:b14e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1F29C
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Jun 2023 12:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dtH/HgPU04v44sfXcmah5GZ7s6G7EaamEj5MCXfefCo=; b=VcXCnrllc46W9pApoUIInfMYUJ
        zIwelssQvR+uxx9E9ZwHrjqqcVOMUUzDju9RhitCm0W6d8r4OFKBVplIrzRMSeDbSm9VHGdheLmUm
        uKjL0utXClQuMcXfs905wBSivNJBNMStp8La9ypugRzHhvGw9OcldgiQkOp8QOWzLkbtInQtudG/V
        3w0LqptapRZ2cNisBlVtVR5cJJzFduG0Km+E6m3Y7Opb0sYLusq2/ai43q9omrA+ahjWzKvurJ4cI
        OngA1Q2AWtcL6amOcd5WzbHXuJ7te/BjaW886GA2k47FsubUiUlLxWIXk+R2hmZX+c1gEeimzM2DH
        M+tuZGjA==;
Received: from [2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608] (helo=ulthar.dreamlands)
        by taras.nevrast.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <jeremy@azazel.net>)
        id 1qBKFe-008EQy-32
        for netfilter-devel@vger.kernel.org;
        Mon, 19 Jun 2023 20:09:22 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next] lib/ts_bm: add helper to reduce indentation and improve readability
Date:   Mon, 19 Jun 2023 20:08:03 +0100
Message-Id: <20230619190803.1906012-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_FAIL,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The flow-control of `bm_find` is very deeply nested with a conditional
comparing a ternary expression against the pattern inside a for-loop
inside a while-loop inside a for-loop.

Move the inner for-loop into a helper function to reduce the amount of
indentation and make the code easier to read.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 lib/ts_bm.c | 42 +++++++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 13 deletions(-)

diff --git a/lib/ts_bm.c b/lib/ts_bm.c
index 1f2234221dd1..d74fdb87d269 100644
--- a/lib/ts_bm.c
+++ b/lib/ts_bm.c
@@ -55,6 +55,24 @@ struct ts_bm
 	unsigned int	good_shift[];
 };
 
+static bool patmtch(const u8 *pattern, const u8 *text, unsigned int patlen,
+		    bool icase)
+{
+	unsigned int i;
+
+	for (i = 0; i < patlen; i++) {
+		u8 t = *(text-i);
+
+		if (icase)
+			t = toupper(t);
+
+		if (t != *(pattern-i))
+			return false;
+	}
+
+	return true;
+}
+
 static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 {
 	struct ts_bm *bm = ts_config_priv(conf);
@@ -70,19 +88,17 @@ static unsigned int bm_find(struct ts_config *conf, struct ts_state *state)
 			break;
 
 		while (shift < text_len) {
-			DEBUGP("Searching in position %d (%c)\n", 
-				shift, text[shift]);
-			for (i = 0; i < bm->patlen; i++) 
-				if ((icase ? toupper(text[shift-i])
-				    : text[shift-i])
-					!= bm->pattern[bm->patlen-1-i])
-				     goto next;
-
-			/* London calling... */
-			DEBUGP("found!\n");
-			return consumed + (shift-(bm->patlen-1));
-
-next:			bs = bm->bad_shift[text[shift-i]];
+			DEBUGP("Searching in position %d (%c)\n",
+			       shift, text[shift]);
+
+			if (patmtch(&bm->pattern[bm->patlen-1], &text[shift],
+				    bm->patlen, icase)) {
+				/* London calling... */
+				DEBUGP("found!\n");
+				return consumed + (shift-(bm->patlen-1));
+			}
+
+			bs = bm->bad_shift[text[shift-i]];
 
 			/* Now jumping to... */
 			shift = max_t(int, shift-i+bs, shift+bm->good_shift[i]);
-- 
2.39.2

