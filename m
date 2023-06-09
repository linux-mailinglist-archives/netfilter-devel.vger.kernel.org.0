Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39F5F7296F5
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Jun 2023 12:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjFIKem (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Jun 2023 06:34:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237805AbjFIKeI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Jun 2023 06:34:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 711BC3A92
        for <netfilter-devel@vger.kernel.org>; Fri,  9 Jun 2023 03:30:36 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables] nft: use payload matching for layer 4 protocol
Date:   Fri,  9 Jun 2023 12:30:30 +0200
Message-Id: <20230609103030.108396-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is an IPv4 header, which does not require the special handling
as in IPv6, use the payload matching instead of meta l4proto which
is slightly faster in this case.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft-ipv4.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/iptables/nft-ipv4.c b/iptables/nft-ipv4.c
index d67d8198bfaf..2a5d25d8694e 100644
--- a/iptables/nft-ipv4.c
+++ b/iptables/nft-ipv4.c
@@ -61,7 +61,8 @@ static int nft_ipv4_add(struct nft_handle *h, struct nftnl_rule *r,
 
 	if (cs->fw.ip.proto != 0) {
 		op = nft_invflags2cmp(cs->fw.ip.invflags, XT_INV_PROTO);
-		add_l4proto(h, r, cs->fw.ip.proto, op);
+		add_proto(h, r, offsetof(struct iphdr, protocol),
+			  sizeof(uint8_t), cs->fw.ip.proto, op);
 	}
 
 	if (cs->fw.ip.flags & IPT_F_FRAG) {
-- 
2.30.2

