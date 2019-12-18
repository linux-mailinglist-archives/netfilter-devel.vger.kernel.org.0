Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49E00124A81
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 15:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727114AbfLRO7X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 09:59:23 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:38315 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfLRO7X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:59:23 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 61E8341644;
        Wed, 18 Dec 2019 22:59:14 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 3/3] netfilter: nf_tables: fix miss dec set use counter in the nf_tables_destroy_set
Date:   Wed, 18 Dec 2019 22:59:13 +0800
Message-Id: <1576681153-10578-4-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
References: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS01OS0tLSkxNT0lCTE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nzo6NBw4ITg2IUwMEhAfNC4c
        IjcKCyNVSlVKTkxNTUNKSk5PT0hJVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpDSU43Bg++
X-HM-Tid: 0a6f198527692086kuqy61e8341644
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

In the create rule path nf_tables_bind_set the set->use will inc, and
with the activate operatoion also inc it. In the delete rule patch
deactivate will dec it. So the destroy opertion should also deactivate
it.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_tables_api.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 174b362..d71793e 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4147,8 +4147,10 @@ void nf_tables_deactivate_set(const struct nft_ctx *ctx, struct nft_set *set,
 
 void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set)
 {
-	if (list_empty(&set->bindings) && nft_set_is_anonymous(set))
+	if (list_empty(&set->bindings) && nft_set_is_anonymous(set)) {
+		set->use--;
 		nft_set_destroy(set);
+	}
 }
 EXPORT_SYMBOL_GPL(nf_tables_destroy_set);
 
-- 
1.8.3.1

