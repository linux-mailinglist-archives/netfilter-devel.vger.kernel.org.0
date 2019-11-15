Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 115EEFD9B0
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 10:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727022AbfKOJr3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 04:47:29 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54728 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJr3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:47:29 -0500
Received: from localhost ([::1]:39586 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iVYCN-0008Dy-Mj; Fri, 15 Nov 2019 10:47:27 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] nft: CMD_ZERO needs a rule cache
Date:   Fri, 15 Nov 2019 10:47:24 +0100
Message-Id: <20191115094725.19756-2-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191115094725.19756-1-phil@nwl.cc>
References: <20191115094725.19756-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In order to zero rule counters, they have to be fetched from kernel. Fix
this for both standalone calls as well as xtables-restore --noflush.

Fixes: b5cb6e631c828 ("nft-cache: Fetch only chains in nft_chain_list_get()")
Fixes: 09cb517949e69 ("xtables-restore: Improve performance of --noflush operation")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c             | 2 ++
 iptables/xtables-restore.c | 1 +
 2 files changed, 3 insertions(+)

diff --git a/iptables/nft.c b/iptables/nft.c
index 3c230c121f8b9..83cf5fb703d3e 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2922,6 +2922,8 @@ static int __nft_chain_zero_counters(struct nftnl_chain *c, void *data)
 			return -1;
 	}
 
+	nft_build_cache(h, c);
+
 	iter = nftnl_rule_iter_create(c);
 	if (iter == NULL)
 		return -1;
diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index 282aa153b1599..2f0fe7d439d94 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -268,6 +268,7 @@ static bool cmd_needs_full_cache(char *cmd)
 	case 'C':
 	case 'S':
 	case 'L':
+	case 'Z':
 		return true;
 	}
 
-- 
2.24.0

