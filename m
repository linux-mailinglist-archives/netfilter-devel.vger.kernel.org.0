Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C66E4D1D2D
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Mar 2022 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241074AbiCHQbQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Mar 2022 11:31:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbiCHQbQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Mar 2022 11:31:16 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97102506C4
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Mar 2022 08:30:19 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nRcj3-00068l-OZ; Tue, 08 Mar 2022 17:30:17 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] Revert "netfilter: conntrack: tag conntracks picked up in local out hook"
Date:   Tue,  8 Mar 2022 17:30:12 +0100
Message-Id: <20220308163012.28762-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220308125924.6708-1-fw@strlen.de>
References: <20220308125924.6708-1-fw@strlen.de>
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

This was a prerequisite for the ill-fated
"netfilter: nat: force port remap to prevent shadowing well-known ports".

As this has been reverted, this change can be backed out too.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/net/netfilter/nf_conntrack.h | 1 -
 net/netfilter/nf_conntrack_core.c    | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 8731d5bcb47d..b08b70989d2c 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -97,7 +97,6 @@ struct nf_conn {
 	unsigned long status;
 
 	u16		cpu;
-	u16		local_origin:1;
 	possible_net_t ct_net;
 
 #if IS_ENABLED(CONFIG_NF_NAT)
diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index d6aa5b47031e..bf1e17c678f1 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -1748,9 +1748,6 @@ resolve_normal_ct(struct nf_conn *tmpl,
 			return 0;
 		if (IS_ERR(h))
 			return PTR_ERR(h);
-
-		ct = nf_ct_tuplehash_to_ctrack(h);
-		ct->local_origin = state->hook == NF_INET_LOCAL_OUT;
 	}
 	ct = nf_ct_tuplehash_to_ctrack(h);
 
-- 
2.34.1

