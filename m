Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F640EA288
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Oct 2019 18:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJ3R1c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Oct 2019 13:27:32 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45132 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbfJ3R1c (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Oct 2019 13:27:32 -0400
Received: from localhost ([::1]:58222 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iPrko-0007nE-Rk; Wed, 30 Oct 2019 18:27:30 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 10/12] nft: Embed rule's table name in nft_xt_ctx
Date:   Wed, 30 Oct 2019 18:26:59 +0100
Message-Id: <20191030172701.5892-11-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191030172701.5892-1-phil@nwl.cc>
References: <20191030172701.5892-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Down to the point where expression parsing happens, the rule's table is
not known anymore but relevant if set lookups are required.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-shared.c | 1 +
 iptables/nft-shared.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/iptables/nft-shared.c b/iptables/nft-shared.c
index a67302ee621ae..19630c1e2990c 100644
--- a/iptables/nft-shared.c
+++ b/iptables/nft-shared.c
@@ -597,6 +597,7 @@ void nft_rule_to_iptables_command_state(struct nft_handle *h,
 	struct nft_xt_ctx ctx = {
 		.cs = cs,
 		.h = h,
+		.table = nftnl_rule_get_str(r, NFTNL_RULE_TABLE),
 	};
 
 	iter = nftnl_expr_iter_create(r);
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index 6b2ff630b2257..0519749f43cd8 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -51,6 +51,7 @@ struct nft_xt_ctx {
 	struct nftnl_expr_iter *iter;
 	struct nft_handle *h;
 	uint32_t flags;
+	const char *table;
 
 	uint32_t reg;
 	struct {
-- 
2.23.0

