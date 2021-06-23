Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E70663B18DF
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jun 2021 13:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFWLaj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Jun 2021 07:30:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60534 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbhFWLah (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:30:37 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id E075F6423C
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Jun 2021 13:26:54 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] libnftables: fix memleak when first message in batch is used to report error
Date:   Wed, 23 Jun 2021 13:28:16 +0200
Message-Id: <20210623112816.1668-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The err->seqnum == batch_seqnum case results in a memleak of mnl_err
objects under some scenarios such as nf_tables kernel support is not
available or user runs the nft executable as non-root.

Fixes: f930cc500318 ("nftables: fix supression of "permission denied" errors")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Supersedes: https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210623112628.1543-1-pablo@netfilter.org/

 src/libnftables.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/libnftables.c b/src/libnftables.c
index e080eb032770..2378f7dd76fb 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -89,6 +89,12 @@ static int nft_netlink(struct nft_ctx *nft,
 			last_seqnum = UINT32_MAX;
 		}
 	}
+	/* nfnetlink uses the first netlink message header in the batch whose
+	 * sequence number is zero to report for EOPNOTSUPP and EPERM errors in
+	 * some scenarios. Now it is safe to release here.
+	 */
+	list_for_each_entry_safe(err, tmp, &err_list, head)
+		mnl_err_list_free(err);
 out:
 	mnl_batch_reset(ctx.batch);
 	return ret;
-- 
2.30.2

