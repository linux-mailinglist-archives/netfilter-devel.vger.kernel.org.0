Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A146C3DF877
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Aug 2021 01:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbhHCX1j (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 3 Aug 2021 19:27:39 -0400
Received: from mail.netfilter.org ([217.70.188.207]:54548 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbhHCX1j (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 3 Aug 2021 19:27:39 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1732660043;
        Wed,  4 Aug 2021 01:26:50 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nf 1/2] netfilter: nfnetlink_hook: use the sequence number of the request message
Date:   Wed,  4 Aug 2021 01:27:19 +0200
Message-Id: <20210803232720.25833-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The sequence number allows to correlate the netlink reply message (as
part of the dump) with the original request message.

The cb->seq field is internally used to detect an interference (update)
of the hook list during the netlink dump, do not use it as sequence
number in the netlink dump header.

Fixes: e2cf17d3774c ("netfilter: add new hook nfnl subsystem")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nfnetlink_hook.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
index 30fe94477f8d..f204752ba4a4 100644
--- a/net/netfilter/nfnetlink_hook.c
+++ b/net/netfilter/nfnetlink_hook.c
@@ -262,7 +262,8 @@ static int nfnl_hook_dump(struct sk_buff *nlskb,
 	ops = nf_hook_entries_get_hook_ops(e);
 
 	for (; i < e->num_hook_entries; i++) {
-		err = nfnl_hook_dump_one(nlskb, ctx, ops[i], cb->seq);
+		err = nfnl_hook_dump_one(nlskb, ctx, ops[i],
+					 cb->nlh->nlmsg_seq);
 		if (err)
 			break;
 	}
-- 
2.20.1

