Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D42F6AAF81
	for <lists+netfilter-devel@lfdr.de>; Sun,  5 Mar 2023 13:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjCEMeS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 Mar 2023 07:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjCEMeQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 Mar 2023 07:34:16 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A340AEC57
        for <netfilter-devel@vger.kernel.org>; Sun,  5 Mar 2023 04:34:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=gxQJBiJSCP1Mw3mZ8P/rp2jypDJVUKWEsmOuVBRilZM=; b=lXVHci4LZFQq59Zl2R/xCwXVbN
        TI6I8aucNIAaMefXzIKnaj0SBoRjaJwhd0l2/Jb+CZ8phj/nMDE58aw7Z50DVDlSHxl6XBp/VgwnC
        joo19DuBemlE447K+FbbLbA02I/i/EOwkZI71ucalVFPs8EsUOLQsxJar+SHqE4M+vch1zoD8QFPi
        1kJ613nO58Xnp+r7E86Wd/WenRmqGekZh8XrDELb0NID7CbXFQuwt4bOyaUfsHUtrPPNNwd/hC6fu
        rxxJvtpZ5sIQ4uB3+X5+UsX+pQ2GQAt470kZr+RaUQQoYPERRuertde9MFswhy2ezjaRqIYq2Ysm1
        tjnKwvNA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1pYnZ6-00E3og-Ux
        for netfilter-devel@vger.kernel.org; Sun, 05 Mar 2023 12:34:12 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 06/13] netfilter: nft_masq: correct length for loading protocol registers
Date:   Sun,  5 Mar 2023 12:18:10 +0000
Message-Id: <20230305121817.2234734-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305121817.2234734-1-jeremy@azazel.net>
References: <20230305121817.2234734-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The values in the protocol registers are two bytes wide.  However, when
parsing the register loads, the code currently uses the larger 16-byte
size of a `union nf_inet_addr`.  Change it to use the (correct) size of
a `union nf_conntrack_man_proto` instead.

Fixes: 8a6bf5da1aef ("netfilter: nft_masq: support port range")
Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 net/netfilter/nft_masq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_masq.c b/net/netfilter/nft_masq.c
index e55e455275c4..9544c2f16998 100644
--- a/net/netfilter/nft_masq.c
+++ b/net/netfilter/nft_masq.c
@@ -43,7 +43,7 @@ static int nft_masq_init(const struct nft_ctx *ctx,
 			 const struct nft_expr *expr,
 			 const struct nlattr * const tb[])
 {
-	u32 plen = sizeof_field(struct nf_nat_range, min_addr.all);
+	u32 plen = sizeof_field(struct nf_nat_range, min_proto.all);
 	struct nft_masq *priv = nft_expr_priv(expr);
 	int err;
 
-- 
2.39.2

