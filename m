Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 022E06E84F1
	for <lists+netfilter-devel@lfdr.de>; Thu, 20 Apr 2023 00:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233094AbjDSW3T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Apr 2023 18:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233189AbjDSW3H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Apr 2023 18:29:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27B22C676
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Apr 2023 15:27:37 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next,v4 7/7] netfilter: nf_tables: remove artificial cap on maximum number of netdevices
Date:   Thu, 20 Apr 2023 00:23:35 +0200
Message-Id: <20230419222335.1039-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230419222335.1039-1-pablo@netfilter.org>
References: <20230419222335.1039-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove NFT_NETDEVICE_MAX (256) artificial cap on the maximum number of
netdevices that are allowed per chain/flowtable.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v4: new in this series

 include/net/netfilter/nf_tables.h | 2 --
 net/netfilter/nf_tables_api.c     | 8 +-------
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 262dc17d2c0b..552e19ba4f43 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -1344,8 +1344,6 @@ struct nft_object_ops {
 int nft_register_obj(struct nft_object_type *obj_type);
 void nft_unregister_obj(struct nft_object_type *obj_type);
 
-#define NFT_NETDEVICE_MAX	256
-
 /**
  *	struct nft_flowtable - nf_tables flow table
  *
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index c82113d49868..d3a5f7fe675f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1978,7 +1978,7 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 {
 	struct nft_hook *hook, *next;
 	const struct nlattr *tmp;
-	int rem, n = 0, err;
+	int rem, err;
 
 	nla_for_each_nested(tmp, attr, rem) {
 		if (nla_type(tmp) != NFTA_DEVICE_NAME) {
@@ -1999,12 +1999,6 @@ static int nf_tables_parse_netdev_hooks(struct net *net,
 			goto err_hook;
 		}
 		list_add_tail(&hook->list, hook_list);
-		n++;
-
-		if (n == NFT_NETDEVICE_MAX) {
-			err = -EFBIG;
-			goto err_hook;
-		}
 	}
 
 	return 0;
-- 
2.30.2

