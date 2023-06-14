Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D93D7232F9
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Jun 2023 00:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjFEWMJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jun 2023 18:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232305AbjFEWMG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jun 2023 18:12:06 -0400
Received: from taras.nevrast.org (unknown [IPv6:2a05:d01c:431:aa03:b7e1:333d:ea2a:b14e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C1BAF
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Jun 2023 15:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=wJAKpFk1LMcb4ZYc9ERMKM3fOYv4dKt1RM0gHpmvRFA=; b=bycNJ3SrVB4ZRzrsqExknnLOeU
        Q6+8fZQLjqz9Jkj+h7lSraW/OvAi08l1qYHJrQ14ynlgybMvYLnZUP4SSStytOk1ly8Pj0B5pnXuV
        UwjRRyE6g+NCnIHb+ikPMYwKt//K1Swsi2iMZpTcRrF8GRQVnZWQq8BoWa/K8pma84YBmwmdXGa+I
        XsE7X2+Xe62unnOYz/yk2TLMPEB+7QBBEVe7j6goq4kzxDiTLzQE62AK8nJ8bPexymU2FHmj7Xo0P
        hjdmbWSvPNOcviTF/TMZHhBX5bEXgyXRGFd1wWODUpPKCF9Hf5w4MglDyOQ6msoewJV8EtiQp9DFH
        IAgE5+gA==;
Received: from [2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608] (helo=ulthar.dreamlands)
        by taras.nevrast.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1q6IQl-00H5Wa-L2
        for netfilter-devel@vger.kernel.org; Mon, 05 Jun 2023 23:12:03 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH xtables-addons v2 3/7] xt_ipp2p: add helper for matching "\r\n"
Date:   Mon,  5 Jun 2023 23:10:40 +0100
Message-Id: <20230605221044.140855-4-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230605221044.140855-1-jeremy@azazel.net>
References: <20230605221044.140855-1-jeremy@azazel.net>
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

There are repeated checks that:

  pkt[x] == 0x0d && pkt[x + 1] == 0x0a

Replace them with `iscrlf(&pkt[x])` function calls.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/xt_ipp2p.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/extensions/xt_ipp2p.c b/extensions/xt_ipp2p.c
index d2e29706998a..f61f3f7cc2ee 100644
--- a/extensions/xt_ipp2p.c
+++ b/extensions/xt_ipp2p.c
@@ -39,6 +39,11 @@ struct ipp2p_result_printer {
 	void (*print)(const union nf_inet_addr *, short, const union nf_inet_addr *, short, bool, unsigned int);
 };
 
+static bool iscrlf(const unsigned char *str)
+{
+	return *str == '\r' && *(str + 1) == '\n';
+}
+
 static void
 print_result(const struct ipp2p_result_printer *rp, bool result,
              unsigned int hlen)
@@ -518,7 +523,7 @@ search_winmx(const unsigned char *payload, const unsigned int plen)
 static unsigned int
 search_apple(const unsigned char *payload, const unsigned int plen)
 {
-	if (plen > 7 && payload[6] == 0x0d && payload[7] == 0x0a &&
+	if (plen > 7 && iscrlf(&payload[6]) &&
 	    memcmp(payload, "ajprot", 6) == 0)
 		return IPP2P_APPLE * 100;
 
@@ -574,7 +579,7 @@ search_kazaa(const unsigned char *payload, const unsigned int plen)
 {
 	if (plen < 13)
 		return 0;
-	if (payload[plen-2] == 0x0d && payload[plen-1] == 0x0a &&
+	if (iscrlf(&payload[plen - 2]) &&
 	    memcmp(payload, "GET /.hash=", 11) == 0)
 		return IPP2P_DATA_KAZAA * 100;
 
@@ -587,7 +592,7 @@ search_gnu(const unsigned char *payload, const unsigned int plen)
 {
 	if (plen < 11)
 		return 0;
-	if (payload[plen-2] == 0x0d && payload[plen-1] == 0x0a) {
+	if (iscrlf(&payload[plen - 2])) {
 		if (memcmp(payload, "GET /get/", 9) == 0)
 			return IPP2P_DATA_GNU * 100 + 1;
 		if (plen >= 15 && memcmp(payload, "GET /uri-res/", 13) == 0)
@@ -602,7 +607,7 @@ search_all_gnu(const unsigned char *payload, const unsigned int plen)
 {
 	if (plen < 11)
 		return 0;
-	if (payload[plen-2] == 0x0d && payload[plen-1] == 0x0a) {
+	if (iscrlf(&payload[plen - 2])) {
 		if (plen >= 19 && memcmp(payload, "GNUTELLA CONNECT/", 17) == 0)
 			return IPP2P_GNU * 100 + 1;
 		if (memcmp(payload, "GNUTELLA/", 9) == 0)
@@ -614,8 +619,7 @@ search_all_gnu(const unsigned char *payload, const unsigned int plen)
 			unsigned int c;
 
 			for (c = 0; c < plen - 22; ++c)
-				if (payload[c] == 0x0d &&
-				    payload[c+1] == 0x0a &&
+				if (iscrlf(&payload[c]) &&
 				    (memcmp(&payload[c+2], "X-Gnutella-", 11) == 0 ||
 				    memcmp(&payload[c+2], "X-Queue:", 8) == 0))
 					return IPP2P_GNU * 100 + 3;
@@ -635,7 +639,7 @@ search_all_kazaa(const unsigned char *payload, const unsigned int plen)
 		/* too short for anything we test for - early bailout */
 		return 0;
 
-	if (payload[plen-2] != 0x0d || payload[plen-1] != 0x0a)
+	if (!iscrlf(&payload[plen - 2]))
 		return 0;
 
 	if (memcmp(payload, "GIVE ", 5) == 0)
@@ -651,9 +655,7 @@ search_all_kazaa(const unsigned char *payload, const unsigned int plen)
 	end = plen - 18;
 	rem = plen - 5;
 	for (c = 5; c < end; ++c, --rem) {
-		if (payload[c] != 0x0d)
-			continue;
-		if (payload[c+1] != 0x0a)
+		if (!iscrlf(&payload[c]))
 			continue;
 		if (rem >= 18 &&
 		    memcmp(&payload[c+2], "X-Kazaa-Username: ", 18) == 0)
@@ -769,8 +771,8 @@ static unsigned int
 search_xdcc(const unsigned char *payload, const unsigned int plen)
 {
 	/* search in small packets only */
-	if (plen > 20 && plen < 200 && payload[plen-1] == 0x0a &&
-	    payload[plen-2] == 0x0d && memcmp(payload, "PRIVMSG ", 8) == 0)
+	if (plen > 20 && plen < 200 && iscrlf(&payload[plen - 2]) &&
+	    memcmp(payload, "PRIVMSG ", 8) == 0)
 	{
 		uint16_t x = 10;
 		const uint16_t end = plen - 13;
-- 
2.39.2

