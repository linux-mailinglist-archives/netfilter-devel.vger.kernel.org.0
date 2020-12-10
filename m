Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A1D2D5C2B
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Dec 2020 14:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389225AbgLJNoK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Dec 2020 08:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389219AbgLJNoJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:44:09 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96133C0613CF
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Dec 2020 05:43:29 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1knMEC-0001fY-7Y; Thu, 10 Dec 2020 14:43:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 1/1] netfilter: ctnetlink: add timeout and protoinfo to destroy events
Date:   Thu, 10 Dec 2020 14:43:23 +0100
Message-Id: <20201210134323.23808-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

DESTROY events do not include the remaining timeout.

Unconditionally add the timeout so one can see if the entry timed
out or was removed explicitly.

The latter case can happen when a conntrack gets deleted prematurely,
e.g. due to a tcp reset, module removal, netdev notifier (nat/masquerade
device went down), ctnetlink and so on.

Pablo suggested to also add the tcp (or other l4 tracker) information
to help with debugging.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_netlink.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 3d0fd33be018..0ae03da5b944 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -779,14 +779,18 @@ ctnetlink_conntrack_event(unsigned int events, struct nf_ct_event *item)
 	if (ctnetlink_dump_status(skb, ct) < 0)
 		goto nla_put_failure;
 
+	if (ctnetlink_dump_timeout(skb, ct) < 0)
+		goto nla_put_failure;
+
 	if (events & (1 << IPCT_DESTROY)) {
+		/* always add protoinfo here */
+		if (ctnetlink_dump_protoinfo(skb, ct) < 0)
+			goto nla_put_failure;
+
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

