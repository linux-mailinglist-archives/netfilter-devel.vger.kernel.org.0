Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FAE616D17
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Nov 2022 19:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbiKBSrd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Nov 2022 14:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbiKBSrS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Nov 2022 14:47:18 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F6812FFE4;
        Wed,  2 Nov 2022 11:47:13 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net 5/7] ipvs: fix WARNING in ip_vs_app_net_cleanup()
Date:   Wed,  2 Nov 2022 19:46:57 +0100
Message-Id: <20221102184659.2502-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221102184659.2502-1-pablo@netfilter.org>
References: <20221102184659.2502-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

During the initialization of ip_vs_app_net_init(), if file ip_vs_app
fails to be created, the initialization is successful by default.
Therefore, the ip_vs_app file doesn't be found during the remove in
ip_vs_app_net_cleanup(). It will cause WRNING.

The following is the stack information:
name 'ip_vs_app'
WARNING: CPU: 1 PID: 9 at fs/proc/generic.c:712 remove_proc_entry+0x389/0x460
Modules linked in:
Workqueue: netns cleanup_net
RIP: 0010:remove_proc_entry+0x389/0x460
Call Trace:
<TASK>
ops_exit_list+0x125/0x170
cleanup_net+0x4ea/0xb00
process_one_work+0x9bf/0x1710
worker_thread+0x665/0x1080
kthread+0x2e4/0x3a0
ret_from_fork+0x1f/0x30
</TASK>

Fixes: 457c4cbc5a3d ("[NET]: Make /proc/net per network namespace")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/ipvs/ip_vs_app.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_app.c b/net/netfilter/ipvs/ip_vs_app.c
index f9b16f2b2219..fdacbc3c15be 100644
--- a/net/netfilter/ipvs/ip_vs_app.c
+++ b/net/netfilter/ipvs/ip_vs_app.c
@@ -599,13 +599,19 @@ static const struct seq_operations ip_vs_app_seq_ops = {
 int __net_init ip_vs_app_net_init(struct netns_ipvs *ipvs)
 {
 	INIT_LIST_HEAD(&ipvs->app_list);
-	proc_create_net("ip_vs_app", 0, ipvs->net->proc_net, &ip_vs_app_seq_ops,
-			sizeof(struct seq_net_private));
+#ifdef CONFIG_PROC_FS
+	if (!proc_create_net("ip_vs_app", 0, ipvs->net->proc_net,
+			     &ip_vs_app_seq_ops,
+			     sizeof(struct seq_net_private)))
+		return -ENOMEM;
+#endif
 	return 0;
 }
 
 void __net_exit ip_vs_app_net_cleanup(struct netns_ipvs *ipvs)
 {
 	unregister_ip_vs_app(ipvs, NULL /* all */);
+#ifdef CONFIG_PROC_FS
 	remove_proc_entry("ip_vs_app", ipvs->net->proc_net);
+#endif
 }
-- 
2.30.2

