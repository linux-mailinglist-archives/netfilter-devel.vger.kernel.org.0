Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88EFE39F736
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 15:00:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhFHNCj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 09:02:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56430 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbhFHNCj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 09:02:39 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5F52564133
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 14:59:33 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] netlink: quick sort array of devices
Date:   Tue,  8 Jun 2021 15:00:39 +0200
Message-Id: <20210608130039.361-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210608130039.361-1-pablo@netfilter.org>
References: <20210608130039.361-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Provide an ordered list of devices for (netdev) chain and flowtable.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1525
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/netlink.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/src/netlink.c b/src/netlink.c
index 6b6fe27762d5..fef869438c35 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -517,6 +517,11 @@ static int chain_parse_udata_cb(const struct nftnl_udata *attr, void *data)
 	return 0;
 }
 
+static int qsort_device_cmp(const void *a, const void *b)
+{
+	return strcmp(a, b) < 0;
+}
+
 struct chain *netlink_delinearize_chain(struct netlink_ctx *ctx,
 					const struct nftnl_chain *nlc)
 {
@@ -580,6 +585,11 @@ struct chain *netlink_delinearize_chain(struct netlink_ctx *ctx,
 			chain->dev_array_len = len;
 		}
 		chain->flags        |= CHAIN_F_BASECHAIN;
+
+		if (chain->dev_array_len) {
+			qsort(chain->dev_array, chain->dev_array_len,
+			      sizeof(char *), qsort_device_cmp);
+		}
 	}
 
 	if (nftnl_chain_is_set(nlc, NFTNL_CHAIN_USERDATA)) {
@@ -1582,6 +1592,11 @@ netlink_delinearize_flowtable(struct netlink_ctx *ctx,
 
 	flowtable->dev_array_len = len;
 
+	if (flowtable->dev_array_len) {
+		qsort(flowtable->dev_array, flowtable->dev_array_len,
+		      sizeof(char *), qsort_device_cmp);
+	}
+
 	priority = nftnl_flowtable_get_u32(nlo, NFTNL_FLOWTABLE_PRIO);
 	flowtable->priority.expr =
 				constant_expr_alloc(&netlink_location,
-- 
2.20.1

