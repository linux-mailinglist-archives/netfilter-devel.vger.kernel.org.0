Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4115BE593
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Sep 2022 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiITMUb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Sep 2022 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbiITMUa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:20:30 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADCA57332C
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Sep 2022 05:20:28 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1oacEj-0007zH-PR; Tue, 20 Sep 2022 14:20:25 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     syzkaller-bugs@googlegroups.com, Florian Westphal <fw@strlen.de>,
        syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com
Subject: [PATCH nf] netfilter: ebtables: fix memory leak when blob is malformed
Date:   Tue, 20 Sep 2022 14:20:17 +0200
Message-Id: <20220920122017.2600-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <000000000000b010bd05e9100e11@google.com>
References: <000000000000b010bd05e9100e11@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The bug fix was incomplete, it "replaced" crash with a memory leak.
The old code had an assignment to "ret" embedded into the conditional,
restore this.

Fixes: 7997eff82828 ("netfilter: ebtables: reject blobs that don't provide all entry points")
Reported-and-tested-by: syzbot+a24c5252f3e3ab733464@syzkaller.appspotmail.com
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 8f6639e095a0..c4af063c0c8f 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -1040,8 +1040,10 @@ static int do_replace_finish(struct net *net, struct ebt_replace *repl,
 		goto free_iterate;
 	}
 
-	if (repl->valid_hooks != t->valid_hooks)
+	if (repl->valid_hooks != t->valid_hooks) {
+		ret = -EINVAL;
 		goto free_unlock;
+	}
 
 	if (repl->num_counters && repl->num_counters != t->private->nentries) {
 		ret = -EINVAL;
-- 
2.18.1

