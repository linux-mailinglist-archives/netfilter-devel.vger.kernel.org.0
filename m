Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91387112673
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Dec 2019 10:06:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbfLDJGQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 4 Dec 2019 04:06:16 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:58032 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfLDJGQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 4 Dec 2019 04:06:16 -0500
Received: from localhost ([::1]:42890 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1icQbu-0005St-PR; Wed, 04 Dec 2019 10:06:14 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] Fix DEBUG build
Date:   Wed,  4 Dec 2019 10:06:05 +0100
Message-Id: <20191204090606.2088-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixed commit missed to update this conditional call to
nft_rule_print_save().

Fixes: 1e8ef6a584754 ("nft: family_ops: Pass nft_handle to 'rule_to_cs' callback")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index 78e422781723f..426765641cff6 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -998,7 +998,7 @@ bool nft_ipv46_rule_find(struct nft_handle *h, struct nftnl_rule *r, void *data)
 
 	DEBUGP("comparing with... ");
 #ifdef DEBUG_DEL
-	nft_rule_print_save(r, NFT_RULE_APPEND, 0);
+	nft_rule_print_save(h, r, NFT_RULE_APPEND, 0);
 #endif
 	if (!h->ops->is_same(cs, &this))
 		goto out;
-- 
2.24.0

