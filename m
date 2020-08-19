Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D52F249A7B
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Aug 2020 12:37:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbgHSKhc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Aug 2020 06:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726782AbgHSKha (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:37:30 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECFEC061342
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Aug 2020 03:37:29 -0700 (PDT)
Received: from localhost ([::1]:38122 helo=minime)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1k8LT3-0000EF-I8; Wed, 19 Aug 2020 12:37:17 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/4] nft: cache: Check consistency with NFT_CL_FAKE, too
Date:   Wed, 19 Aug 2020 12:37:09 +0200
Message-Id: <20200819103712.12974-2-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200819103712.12974-1-phil@nwl.cc>
References: <20200819103712.12974-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Athough this cache level fetches table names only, it shouldn't skip the
consistency check.

Fixes: f42bfb344af82 ("nft: cache: Re-establish cache consistency check")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/iptables/nft-cache.c b/iptables/nft-cache.c
index c6baf090ae85f..32cfd6cf0989a 100644
--- a/iptables/nft-cache.c
+++ b/iptables/nft-cache.c
@@ -502,14 +502,14 @@ retry:
 	if (req->level >= NFT_CL_TABLES)
 		fetch_table_cache(h);
 	if (req->level == NFT_CL_FAKE)
-		return;
+		goto genid_check;
 	if (req->level >= NFT_CL_CHAINS)
 		fetch_chain_cache(h, t, chains);
 	if (req->level >= NFT_CL_SETS)
 		fetch_set_cache(h, t, NULL);
 	if (req->level >= NFT_CL_RULES)
 		fetch_rule_cache(h, t);
-
+genid_check:
 	mnl_genid_get(h, &genid_check);
 	if (h->nft_genid != genid_check) {
 		flush_cache(h, h->cache, NULL);
-- 
2.27.0

