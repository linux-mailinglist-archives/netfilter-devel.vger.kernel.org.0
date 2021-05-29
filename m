Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C19394D39
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 May 2021 18:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229796AbhE2QwM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 May 2021 12:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhE2QwL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 May 2021 12:52:11 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1CA6C061574
        for <netfilter-devel@vger.kernel.org>; Sat, 29 May 2021 09:50:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ln2AP-0000mn-Rx; Sat, 29 May 2021 18:50:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, kernel test robot <lkp@intel.com>
Subject: [PATCH nf-next] netfilter: nft_compat: fix bridge family target evaluation
Date:   Sat, 29 May 2021 18:50:25 +0200
Message-Id: <20210529165025.146435-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This always evals to true, so all packets get dropped in the ebtables
compat layer. ip(6)tables is fine.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 6d6dbfe7fe1e6e1 ("netfilter: nf_tables: remove xt_action_param from nft_pktinfo")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Pablo, feel free to squash if you prefer that.

 net/netfilter/nft_compat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 936e244f5aba..3144a9ad2f6a 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -110,7 +110,7 @@ static void nft_target_eval_bridge(const struct nft_expr *expr,
 
 	ret = target->target(skb, &xt);
 
-	if (&xt.hotdrop)
+	if (xt.hotdrop)
 		ret = NF_DROP;
 
 	switch (ret) {
-- 
2.31.1

