Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0A3644EC6
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Dec 2022 23:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbiLFWxz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Dec 2022 17:53:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiLFWxx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Dec 2022 17:53:53 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6FFCF4A056
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Dec 2022 14:53:51 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kadlec@netfilter.org
Subject: [PATCH nft] doc: statements: fwd supports for sending packets via neighbouring layer
Date:   Tue,  6 Dec 2022 23:53:01 +0100
Message-Id: <20221206225302.61932-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Document ability to forward packets through neighbour layer added in
30d45266bf38 ("expr: extend fwd statement to support address and family").

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/statements.txt | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/doc/statements.txt b/doc/statements.txt
index 8076c21cded4..66877eac847b 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -683,7 +683,25 @@ The fwd statement is used to redirect a raw packet to another interface. It is
 only available in the netdev family ingress and egress hooks. It is similar to
 the dup statement except that no copy is made.
 
+You can also specify the address of the next hop and the device to forward the
+packet to. This updates the source and destination MAC address of the packet by
+transmitting it through the neighboring Layer 2 layer. This also decrements the
+ttl field of the IP packet. This provides a way to effectively bypass the
+classical forwarding path, thus skipping the fib (forwarding information base)
+lookup.
+
+[verse]
 *fwd to* 'device'
+*fwd* [*ip* | *ip6*] *to* 'address' *device* 'device'
+
+.Using the fwd statement
+------------------------
+# redirect raw packet to device
+netdev ingress fwd to "eth0"
+
+# forward packet to next hop 192.168.200.1 via eth0 device
+netdev ingress ether saddr set fwd ip to 192.168.200.1 device "eth0"
+-----------------------------------
 
 SET STATEMENT
 ~~~~~~~~~~~~~
-- 
2.30.2

