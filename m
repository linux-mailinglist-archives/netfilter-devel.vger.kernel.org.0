Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC1D2255E12
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Aug 2020 17:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgH1Pof (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Aug 2020 11:44:35 -0400
Received: from correo.us.es ([193.147.175.20]:60706 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgH1Pod (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:44:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4208118CDC2
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 17:44:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 32449DA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Aug 2020 17:44:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 27F15DA704; Fri, 28 Aug 2020 17:44:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 10A26DA72F;
        Fri, 28 Aug 2020 17:44:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 28 Aug 2020 17:44:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id EA31742EF4E2;
        Fri, 28 Aug 2020 17:44:28 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     bazsi77@gmail.com
Subject: [PATCH nf-next] netfilter: nft_socket: add wildcard support
Date:   Fri, 28 Aug 2020 17:44:25 +0200
Message-Id: <20200828154425.21259-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add NFT_SOCKET_WILDCARD to match to wildcard socket listener.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
@Balazs: I think I posted this already but it seems it's not in patchwork.
         Please, let me know if this one looks good to you, thanks.

 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/netfilter/nft_socket.c               | 25 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index aeb88cbd303e..5cae73037283 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -1010,10 +1010,12 @@ enum nft_socket_attributes {
  *
  * @NFT_SOCKET_TRANSPARENT: Value of the IP(V6)_TRANSPARENT socket option
  * @NFT_SOCKET_MARK: Value of the socket mark
+ * @NFT_SOCKET_WILDCARD: Socket listener is bound to any address
  */
 enum nft_socket_keys {
 	NFT_SOCKET_TRANSPARENT,
 	NFT_SOCKET_MARK,
+	NFT_SOCKET_WILDCARD,
 	__NFT_SOCKET_MAX
 };
 #define NFT_SOCKET_MAX	(__NFT_SOCKET_MAX - 1)
diff --git a/net/netfilter/nft_socket.c b/net/netfilter/nft_socket.c
index 637ce3e8c575..684a7e493f45 100644
--- a/net/netfilter/nft_socket.c
+++ b/net/netfilter/nft_socket.c
@@ -14,6 +14,23 @@ struct nft_socket {
 	};
 };
 
+static void nft_socket_wildcard(const struct nft_pktinfo *pkt,
+				struct nft_regs *regs, struct sock *sk,
+				u32 *dest)
+{
+	switch (nft_pf(pkt)) {
+	case NFPROTO_IPV4:
+		nft_reg_store8(dest, inet_sk(sk)->inet_rcv_saddr == 0);
+		break;
+	case NFPROTO_IPV6:
+		nft_reg_store8(dest, ipv6_addr_any(&sk->sk_v6_rcv_saddr));
+		break;
+	default:
+		regs->verdict.code = NFT_BREAK;
+		return;
+	}
+}
+
 static void nft_socket_eval(const struct nft_expr *expr,
 			    struct nft_regs *regs,
 			    const struct nft_pktinfo *pkt)
@@ -59,6 +76,13 @@ static void nft_socket_eval(const struct nft_expr *expr,
 			return;
 		}
 		break;
+	case NFT_SOCKET_WILDCARD:
+		if (!sk_fullsock(sk)) {
+			regs->verdict.code = NFT_BREAK;
+			return;
+		}
+		nft_socket_wildcard(pkt, regs, sk, dest);
+		break;
 	default:
 		WARN_ON(1);
 		regs->verdict.code = NFT_BREAK;
@@ -97,6 +121,7 @@ static int nft_socket_init(const struct nft_ctx *ctx,
 	priv->key = ntohl(nla_get_u32(tb[NFTA_SOCKET_KEY]));
 	switch(priv->key) {
 	case NFT_SOCKET_TRANSPARENT:
+	case NFT_SOCKET_WILDCARD:
 		len = sizeof(u8);
 		break;
 	case NFT_SOCKET_MARK:
-- 
2.20.1

