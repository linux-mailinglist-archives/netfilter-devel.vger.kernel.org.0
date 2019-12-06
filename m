Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 922AF115004
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Dec 2019 12:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbfLFLrn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Dec 2019 06:47:43 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:34912 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbfLFLrn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Dec 2019 06:47:43 -0500
Received: from localhost ([::1]:48002 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1idC5F-0002lm-PN; Fri, 06 Dec 2019 12:47:41 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 3/6] extensions: cluster: Avoid undefined shift
Date:   Fri,  6 Dec 2019 12:47:08 +0100
Message-Id: <20191206114711.6015-4-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206114711.6015-1-phil@nwl.cc>
References: <20191206114711.6015-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Value 1 is signed 32-bit by default and left-shifting that by 31 is
undefined. Fix this by marking the value as unsigned.

Fixes: 64a0e09894e52 ("extensions: libxt_cluster: Add translation to nft")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_cluster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/extensions/libxt_cluster.c b/extensions/libxt_cluster.c
index c9c35ee22e3df..d164bf6960166 100644
--- a/extensions/libxt_cluster.c
+++ b/extensions/libxt_cluster.c
@@ -156,7 +156,7 @@ static int cluster_xlate(struct xt_xlate *xl,
 		xt_xlate_add(xl, "%s %u seed 0x%08x ", jhash_st,
 				info->total_nodes, info->hash_seed);
 		for (node = 0; node < 32; node++) {
-			if (info->node_mask & (1 << node)) {
+			if (info->node_mask & (1u << node)) {
 				if (needs_set == 0) {
 					xt_xlate_add(xl, "{ ");
 					needs_set = 1;
-- 
2.24.0

