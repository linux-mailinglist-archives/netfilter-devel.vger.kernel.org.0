Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00312124A82
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Dec 2019 15:59:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfLRO7a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Dec 2019 09:59:30 -0500
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:38317 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbfLRO73 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Dec 2019 09:59:29 -0500
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 339FF41635;
        Wed, 18 Dec 2019 22:59:14 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 1/3] netfilter: nf_tables: fix rule release in err path
Date:   Wed, 18 Dec 2019 22:59:11 +0800
Message-Id: <1576681153-10578-2-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
References: <1576681153-10578-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVkpVS01OS0tLSkxNT0lCTE5ZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MBw6Iyo6Sjg9PUwxKBUVNCgy
        LihPCz5VSlVKTkxNTUNKSk5PSUNOVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpOSE03Bg++
X-HM-Tid: 0a6f198526ad2086kuqy339ff41635
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

The err2 failed path in nf_tables_newrule fail err2  should only destory this new rule
without deactivate it. Because the rule is not been activated.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 net/netfilter/nf_tables_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index a8caf73..27e6a6f 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3130,7 +3130,7 @@ static int nf_tables_newrule(struct net *net, struct sock *nlsk,
 
 	return 0;
 err2:
-	nf_tables_rule_release(&ctx, rule);
+	nf_tables_rule_destroy(&ctx, rule);
 err1:
 	for (i = 0; i < n; i++) {
 		if (info[i].ops) {
-- 
1.8.3.1

