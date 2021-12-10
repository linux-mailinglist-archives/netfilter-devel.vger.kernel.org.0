Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C08846F7E7
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Dec 2021 01:12:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233422AbhLJAQM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Dec 2021 19:16:12 -0500
Received: from mail.netfilter.org ([217.70.188.207]:44332 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbhLJAQM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Dec 2021 19:16:12 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 98F7E60087
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Dec 2021 01:10:14 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 1/5] netfilter: nf_tables: remove rcu read-size lock
Date:   Fri, 10 Dec 2021 01:12:27 +0100
Message-Id: <20211210001231.144098-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211210001231.144098-1-pablo@netfilter.org>
References: <20211210001231.144098-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Chain stats are updated from the Netfilter hook path which already run
under rcu read-size lock section.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_tables_core.c b/net/netfilter/nf_tables_core.c
index adc348056076..41c7509955e6 100644
--- a/net/netfilter/nf_tables_core.c
+++ b/net/netfilter/nf_tables_core.c
@@ -110,7 +110,6 @@ static noinline void nft_update_chain_stats(const struct nft_chain *chain,
 
 	base_chain = nft_base_chain(chain);
 
-	rcu_read_lock();
 	pstats = READ_ONCE(base_chain->stats);
 	if (pstats) {
 		local_bh_disable();
@@ -121,7 +120,6 @@ static noinline void nft_update_chain_stats(const struct nft_chain *chain,
 		u64_stats_update_end(&stats->syncp);
 		local_bh_enable();
 	}
-	rcu_read_unlock();
 }
 
 struct nft_jumpstack {
-- 
2.30.2

