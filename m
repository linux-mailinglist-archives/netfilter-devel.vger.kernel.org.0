Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4151A4E530E
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Mar 2022 14:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244275AbiCWNYd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244263AbiCWNYd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:24:33 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA11BCB3
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Mar 2022 06:23:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nX0x3-00016X-3h; Wed, 23 Mar 2022 14:23:01 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 13/16] netfilter: cttimeout: decouple unlink and free on netns destruction
Date:   Wed, 23 Mar 2022 14:22:11 +0100
Message-Id: <20220323132214.6700-14-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220323132214.6700-1-fw@strlen.de>
References: <20220323132214.6700-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Increment the extid on module removal; this makes sure that even
in extreme cases any old uncofirmed entry that happened to be kept
e.g. on nfnetlink_queue list will not trip over a stale timeout
reference.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nfnetlink_cttimeout.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/net/netfilter/nfnetlink_cttimeout.c b/net/netfilter/nfnetlink_cttimeout.c
index 49fe2ec40af9..5d49fbeabd86 100644
--- a/net/netfilter/nfnetlink_cttimeout.c
+++ b/net/netfilter/nfnetlink_cttimeout.c
@@ -657,12 +657,24 @@ static int __init cttimeout_init(void)
 	return ret;
 }
 
+static int untimeout(struct nf_conn *ct, void *timeout)
+{
+	struct nf_conn_timeout *timeout_ext = nf_ct_timeout_find(ct);
+
+	if (timeout_ext)
+		RCU_INIT_POINTER(timeout_ext->timeout, NULL);
+
+	return 0;
+}
+
 static void __exit cttimeout_exit(void)
 {
 	nfnetlink_subsys_unregister(&cttimeout_subsys);
 
 	unregister_pernet_subsys(&cttimeout_ops);
 	RCU_INIT_POINTER(nf_ct_timeout_hook, NULL);
+
+	nf_ct_iterate_destroy(untimeout, NULL);
 	synchronize_rcu();
 }
 
-- 
2.34.1

