Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7933DB9D7
	for <lists+netfilter-devel@lfdr.de>; Fri, 18 Oct 2019 00:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438283AbfJQWs5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 17 Oct 2019 18:48:57 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42612 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438247AbfJQWs5 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 17 Oct 2019 18:48:57 -0400
Received: from localhost ([::1]:55702 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iLEZj-000442-MH; Fri, 18 Oct 2019 00:48:56 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 7/8] xtables-restore: Drop local xtc_ops instance
Date:   Fri, 18 Oct 2019 00:48:35 +0200
Message-Id: <20191017224836.8261-8-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191017224836.8261-1-phil@nwl.cc>
References: <20191017224836.8261-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

It is merely used to hold nft_strerror() pointer but using that function
in turn does not provide any benefit as it falls back to plain
strerror() if nft_fn is not initialized.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-restore.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/iptables/xtables-restore.c b/iptables/xtables-restore.c
index bb6ee78933f7a..900e476eaf968 100644
--- a/iptables/xtables-restore.c
+++ b/iptables/xtables-restore.c
@@ -81,10 +81,6 @@ static const struct nft_xt_restore_cb restore_cb = {
 	.chain_restore  = nft_chain_restore,
 };
 
-static const struct xtc_ops xtc_ops = {
-	.strerror	= nft_strerror,
-};
-
 void xtables_restore_parse(struct nft_handle *h,
 			   const struct nft_xt_restore_parse *p,
 			   const struct nft_xt_restore_cb *cb)
@@ -92,7 +88,6 @@ void xtables_restore_parse(struct nft_handle *h,
 	const struct builtin_table *curtable = NULL;
 	char buffer[10240];
 	int in_table = 0;
-	const struct xtc_ops *ops = &xtc_ops;
 
 	line = 0;
 
@@ -206,7 +201,7 @@ void xtables_restore_parse(struct nft_handle *h,
 						      "Can't set policy `%s'"
 						      " on `%s' line %u: %s\n",
 						      policy, chain, line,
-						      ops->strerror(errno));
+						      strerror(errno));
 				}
 				DEBUGP("Setting policy of chain %s to %s\n",
 				       chain, policy);
@@ -223,7 +218,7 @@ void xtables_restore_parse(struct nft_handle *h,
 					      "Can't set policy `%s'"
 					      " on `%s' line %u: %s\n",
 					      policy, chain, line,
-					      ops->strerror(errno));
+					      strerror(errno));
 			}
 			ret = 1;
 		} else if (in_table) {
-- 
2.23.0

