Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4866FDC2C
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 12:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfKOLVb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 06:21:31 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:62064 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726521AbfKOLVb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 06:21:31 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 4DBC2415EB;
        Fri, 15 Nov 2019 19:21:29 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next] netfilter: nf_tables: check the bind callback failed and unbind callback if hook register failed
Date:   Fri, 15 Nov 2019 19:21:26 +0800
Message-Id: <1573816886-2743-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVJT01CQkJMT0tNS0tOQllXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nwg6Qyo4NDg3CwouFR0uPxZP
        M0waCihVSlVKTkxIQ0pNQ0NCTkNCVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpCSUg3Bg++
X-HM-Tid: 0a6e6ecbefef2086kuqy4dbc2415eb
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

Undo the callback binding before unregistering the existing hooks. It also
should check err of the bind setup call

Fixes: c29f74e0df7a ("netfilter: nf_flow_table: hardware offload support")
Signed-off-by: wenxu <wenxu@ucloud.cn>
---
This patch is based on:
http://patchwork.ozlabs.org/patch/1195539/

 net/netfilter/nf_tables_api.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 0f8080e..149de13 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -6001,12 +6001,20 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 			}
 		}
 
-		flowtable->data.type->setup(&flowtable->data, hook->ops.dev,
-					    FLOW_BLOCK_BIND);
-		err = nf_register_net_hook(net, &hook->ops);
+		err = flowtable->data.type->setup(&flowtable->data,
+						  hook->ops.dev,
+						  FLOW_BLOCK_BIND);
 		if (err < 0)
 			goto err_unregister_net_hooks;
 
+		err = nf_register_net_hook(net, &hook->ops);
+		if (err < 0) {
+			flowtable->data.type->setup(&flowtable->data,
+						    hook->ops.dev,
+						    FLOW_BLOCK_UNBIND);
+			goto err_unregister_net_hooks;
+		}
+
 		i++;
 	}
 
-- 
1.8.3.1

