Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D35210C8A7
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Nov 2019 13:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbfK1MZz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Nov 2019 07:25:55 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57726 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726227AbfK1MZz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Nov 2019 07:25:55 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1iaIrp-0001wt-89; Thu, 28 Nov 2019 13:25:53 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: conntrack: tell compile to not inline nf_ct_resolve_clash
Date:   Thu, 28 Nov 2019 13:25:48 +0100
Message-Id: <20191128122548.20080-1-fw@strlen.de>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

At this time compiler inlines it, but this code will not be executed
under normal conditions.

Also, no inlining allows to use "nf_ct_resolve_clash%return" perf probe.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 0af1898af2b8..739b193970b6 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -895,9 +895,10 @@ static void nf_ct_acct_merge(struct nf_conn *ct, enum ip_conntrack_info ctinfo,
 }
 
 /* Resolve race on insertion if this protocol allows this. */
-static int nf_ct_resolve_clash(struct net *net, struct sk_buff *skb,
-			       enum ip_conntrack_info ctinfo,
-			       struct nf_conntrack_tuple_hash *h)
+static __cold noinline int
+nf_ct_resolve_clash(struct net *net, struct sk_buff *skb,
+		    enum ip_conntrack_info ctinfo,
+		    struct nf_conntrack_tuple_hash *h)
 {
 	/* This is the conntrack entry already in hashes that won race. */
 	struct nf_conn *ct = nf_ct_tuplehash_to_ctrack(h);
-- 
2.23.0

