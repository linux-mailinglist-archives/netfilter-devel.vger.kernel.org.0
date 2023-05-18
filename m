Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B9B1707D31
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230192AbjERJrN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjERJrM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:47:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE14E10DC
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:47:11 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1pzaDy-0005eP-QN; Thu, 18 May 2023 11:47:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netdev@breakpoint.cc
Cc:     Jakub Kicinski <kuba@kernel.org>, eric@breakpoint.cc,
        Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        netfilter-devel <netfilter-devel@vger.kernel.org>,
        Faicker Mo <faicker.mo@ucloud.cn>
Subject: [PATCH net-next 6/9] netfilter: conntrack: allow insertion clash of gre protocol
Date:   Thu, 18 May 2023 11:46:39 +0200
Message-Id: <20230518094642.84097-7-fw@strlen.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230518094642.84097-1-fw@strlen.de>
References: <20230518094642.84097-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Faicker Mo <faicker.mo@ucloud.cn>

NVGRE tunnel is used in the VM-to-VM communications. The VM packets
are encapsulated in NVGRE and sent from the host. For NVGRE
there are two tuples(outer sip and outer dip) in the host conntrack item.
Insertion clashes are more likely to happen if the concurrent connections
are sent from the VM.

Signed-off-by: Faicker Mo <faicker.mo@ucloud.cn>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_proto_gre.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_conntrack_proto_gre.c b/net/netfilter/nf_conntrack_proto_gre.c
index 728eeb0aea87..ad6f0ca40cd2 100644
--- a/net/netfilter/nf_conntrack_proto_gre.c
+++ b/net/netfilter/nf_conntrack_proto_gre.c
@@ -296,6 +296,7 @@ void nf_conntrack_gre_init_net(struct net *net)
 /* protocol helper struct */
 const struct nf_conntrack_l4proto nf_conntrack_l4proto_gre = {
 	.l4proto	 = IPPROTO_GRE,
+	.allow_clash	 = true,
 #ifdef CONFIG_NF_CONNTRACK_PROCFS
 	.print_conntrack = gre_print_conntrack,
 #endif
-- 
2.40.1

