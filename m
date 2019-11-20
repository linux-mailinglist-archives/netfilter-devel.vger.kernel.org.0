Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2075103289
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Nov 2019 05:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727530AbfKTEar (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Nov 2019 23:30:47 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:44462 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbfKTEar (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Nov 2019 23:30:47 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 1D116417F5;
        Wed, 20 Nov 2019 12:30:43 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nf_flow_table_offload: Fix setup block as TC_SETUP_FT cmd
Date:   Wed, 20 Nov 2019 12:30:42 +0800
Message-Id: <1574224242-17972-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVJQ0tCQkJDQkNCSktOSVlXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pwg6Eyo6TjgzCwhRFFEREC42
        LxAwFE9VSlVKTkxPSUlPSU9ISkJNVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPSU03Bg++
X-HM-Tid: 0a6e8713a9b62086kuqy1d116417f5
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Flow table offload should setup block through TC_SETUP_FT cmd

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_flow_table_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index c54c9a6..6067268 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -822,7 +822,7 @@ int nf_flow_table_offload_setup(struct nf_flowtable *flowtable,
 	bo.extack	= &extack;
 	INIT_LIST_HEAD(&bo.cb_list);
 
-	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_BLOCK, &bo);
+	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_FT, &bo);
 	if (err < 0)
 		return err;
 
-- 
1.8.3.1

