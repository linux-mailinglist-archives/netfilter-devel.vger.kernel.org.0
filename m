Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25DEA1157B8
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 20:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfLFTXh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 14:23:37 -0500
Received: from correo.us.es ([193.147.175.20]:36228 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726317AbfLFTXg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 14:23:36 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 230A0E34CF
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 20:23:33 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 14D42DA709
        for <netfilter-devel@vger.kernel.org>; Fri,  6 Dec 2019 20:23:33 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 09F32DA705; Fri,  6 Dec 2019 20:23:33 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E27FBDA709;
        Fri,  6 Dec 2019 20:23:30 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 06 Dec 2019 20:23:30 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id BCD7941E4800;
        Fri,  6 Dec 2019 20:23:30 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nf,v2] netfilter: nft_set_rbtree: bogus lookup/get on consecutive elements in named sets
Date:   Fri,  6 Dec 2019 20:23:29 +0100
Message-Id: <20191206192329.145662-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The existing rbtree implementation might store consecutive elements
where the closing element and the opening element might overlap, eg.

	[ a, a+1) [ a+1, a+2)

This patch removes the optimization for non-anonymous sets in the exact
matching case, where it is assumed to stop searching in case that the
closing element is found. Instead, invalidate candidate interval and
keep looking further in the tree.

This patch fixes the lookup and get operations.

Fixes: e701001e7cbe ("netfilter: nft_rbtree: allow adjacent intervals with dynamic updates")
Fixes: ba0e4d9917b4 ("netfilter: nf_tables: get set elements via netlink")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: missing closing bracket on _get() reported by Phil Sutter.

 net/netfilter/nft_set_rbtree.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nft_set_rbtree.c b/net/netfilter/nft_set_rbtree.c
index 57123259452f..170abe613231 100644
--- a/net/netfilter/nft_set_rbtree.c
+++ b/net/netfilter/nft_set_rbtree.c
@@ -74,8 +74,13 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 				parent = rcu_dereference_raw(parent->rb_left);
 				continue;
 			}
-			if (nft_rbtree_interval_end(rbe))
-				goto out;
+			if (nft_rbtree_interval_end(rbe)) {
+				if (set->flags & NFT_SET_ANONYMOUS)
+					return false;
+				parent = rcu_dereference_raw(parent->rb_left);
+				interval = NULL;
+				continue;
+			}
 
 			*ext = &rbe->ext;
 			return true;
@@ -88,7 +93,7 @@ static bool __nft_rbtree_lookup(const struct net *net, const struct nft_set *set
 		*ext = &interval->ext;
 		return true;
 	}
-out:
+
 	return false;
 }
 
@@ -139,8 +144,10 @@ static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
 			if (flags & NFT_SET_ELEM_INTERVAL_END)
 				interval = rbe;
 		} else {
-			if (!nft_set_elem_active(&rbe->ext, genmask))
+			if (!nft_set_elem_active(&rbe->ext, genmask)) {
 				parent = rcu_dereference_raw(parent->rb_left);
+				continue;
+			}
 
 			if (!nft_set_ext_exists(&rbe->ext, NFT_SET_EXT_FLAGS) ||
 			    (*nft_set_ext_flags(&rbe->ext) & NFT_SET_ELEM_INTERVAL_END) ==
@@ -148,7 +155,11 @@ static bool __nft_rbtree_get(const struct net *net, const struct nft_set *set,
 				*elem = rbe;
 				return true;
 			}
-			return false;
+
+			if (nft_rbtree_interval_end(rbe))
+				interval = NULL;
+
+			parent = rcu_dereference_raw(parent->rb_left);
 		}
 	}
 
-- 
2.11.0

