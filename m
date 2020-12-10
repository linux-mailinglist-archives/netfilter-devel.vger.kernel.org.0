Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C962D5920
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 12:22:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgLJLVK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 06:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbgLJLVK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 06:21:10 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81276C0613D6
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 03:20:30 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1knJzo-0000zA-6X; Thu, 10 Dec 2020 12:20:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: ctnetlink: always include remaining timeout
Date:   Thu, 10 Dec 2020 12:20:22 +0100
Message-Id: <20201210112022.7793-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

DESTROY events do not include the remaining timeout.

Unconditionally including the timeout allows to see if the entry timed
timed out or was removed explicitly.

The latter case can happen when a conntrack gets deleted prematurely,
e.g. due to a tcp reset, module removal, netdev notifier (nat/masquerade
device went down), ctnetlink and so on.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 Might make sense to further extend nf_ct_delete and also pass a
 reason code in the future.

 net/netfilter/nf_conntrack_netlink.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3d0fd33be018..3f957769cd72 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -778,15 +778,14 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 
 	if (ctnetlink_dump_status(skb, ct) < 0)
 		goto nla_put_failure;
+	if (ctnetlink_dump_timeout(skb, ct) < 0)
+		goto nla_put_failure;
 
 	if (events & (1 << IPCT_DESTROY)) {
 		if (ctnetlink_dump_acct(skb, ct, type) < 0 ||
 		    ctnetlink_dump_timestamp(skb, ct) < 0)
 			goto nla_put_failure;
 	} else {
-		if (ctnetlink_dump_timeout(skb, ct) < 0)
-			goto nla_put_failure;
-
 		if (events & (1 << IPCT_PROTOINFO)
 		    && ctnetlink_dump_protoinfo(skb, ct) < 0)
 			goto nla_put_failure;
-- 
2.26.2

