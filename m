Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51E6A35750B
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Apr 2021 21:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbhDGTjX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Apr 2021 15:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236301AbhDGTjW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:39:22 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A670C06175F
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Apr 2021 12:39:13 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lUE18-000274-P6; Wed, 07 Apr 2021 21:39:10 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        syzbot+cfc0247ac173f597aaaa@syzkaller.appspotmail.com,
        Andy Nguyen <theflow@google.com>
Subject: [PATCH nf] netfilter: x_tables: fix compat match/target pad out-of-bound write
Date:   Wed,  7 Apr 2021 21:38:57 +0200
Message-Id: <20210407193857.21120-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

xt_compat_match/target_from_user doesn't check that zeroing the area
to start of next rule won't write past end of allocated ruleset blob.

Remove this code and zero the entire blob beforehand.

Reported-by: syzbot+cfc0247ac173f597aaaa@syzkaller.appspotmail.com
Reported-by: Andy Nguyen <theflow@google.com>
Fixes: 9fa492cdc160c ("[NETFILTER]: x_tables: simplify compat API")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/ipv4/netfilter/arp_tables.c |  2 ++
 net/ipv4/netfilter/ip_tables.c  |  2 ++
 net/ipv6/netfilter/ip6_tables.c |  2 ++
 net/netfilter/x_tables.c        | 10 ++--------
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/netfilter/arp_tables.c b/net/ipv4/netfilter/arp_tables.c
index 6c26533480dd..d6d45d820d79 100644
--- a/net/ipv4/netfilter/arp_tables.c
+++ b/net/ipv4/netfilter/arp_tables.c
@@ -1193,6 +1193,8 @@ static int translate_compat_table(struct net *net,
 	if (!newinfo)
 		goto out_unlock;
 
+	memset(newinfo->entries, 0, size);
+
 	newinfo->number = compatr->num_entries;
 	for (i = 0; i < NF_ARP_NUMHOOKS; i++) {
 		newinfo->hook_entry[i] = compatr->hook_entry[i];
diff --git a/net/ipv4/netfilter/ip_tables.c b/net/ipv4/netfilter/ip_tables.c
index f15bc21d7301..f77ea0dbe656 100644
--- a/net/ipv4/netfilter/ip_tables.c
+++ b/net/ipv4/netfilter/ip_tables.c
@@ -1428,6 +1428,8 @@ translate_compat_table(struct net *net,
 	if (!newinfo)
 		goto out_unlock;
 
+	memset(newinfo->entries, 0, size);
+
 	newinfo->number = compatr->num_entries;
 	for (i = 0; i < NF_INET_NUMHOOKS; i++) {
 		newinfo->hook_entry[i] = compatr->hook_entry[i];
diff --git a/net/ipv6/netfilter/ip6_tables.c b/net/ipv6/netfilter/ip6_tables.c
index 2e2119bfcf13..eb2b5404806c 100644
--- a/net/ipv6/netfilter/ip6_tables.c
+++ b/net/ipv6/netfilter/ip6_tables.c
@@ -1443,6 +1443,8 @@ translate_compat_table(struct net *net,
 	if (!newinfo)
 		goto out_unlock;
 
+	memset(newinfo->entries, 0, size);
+
 	newinfo->number = compatr->num_entries;
 	for (i = 0; i < NF_INET_NUMHOOKS; i++) {
 		newinfo->hook_entry[i] = compatr->hook_entry[i];
diff --git a/net/netfilter/x_tables.c b/net/netfilter/x_tables.c
index 6bd31a7a27fc..92e9d4ebc5e8 100644
--- a/net/netfilter/x_tables.c
+++ b/net/netfilter/x_tables.c
@@ -733,7 +733,7 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 {
 	const struct xt_match *match = m->u.kernel.match;
 	struct compat_xt_entry_match *cm = (struct compat_xt_entry_match *)m;
-	int pad, off = xt_compat_match_offset(match);
+	int off = xt_compat_match_offset(match);
 	u_int16_t msize = cm->u.user.match_size;
 	char name[sizeof(m->u.user.name)];
 
@@ -743,9 +743,6 @@ void xt_compat_match_from_user(struct xt_entry_match *m, void **dstptr,
 		match->compat_from_user(m->data, cm->data);
 	else
 		memcpy(m->data, cm->data, msize - sizeof(*cm));
-	pad = XT_ALIGN(match->matchsize) - match->matchsize;
-	if (pad > 0)
-		memset(m->data + match->matchsize, 0, pad);
 
 	msize += off;
 	m->u.user.match_size = msize;
@@ -1116,7 +1113,7 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 {
 	const struct xt_target *target = t->u.kernel.target;
 	struct compat_xt_entry_target *ct = (struct compat_xt_entry_target *)t;
-	int pad, off = xt_compat_target_offset(target);
+	int off = xt_compat_target_offset(target);
 	u_int16_t tsize = ct->u.user.target_size;
 	char name[sizeof(t->u.user.name)];
 
@@ -1126,9 +1123,6 @@ void xt_compat_target_from_user(struct xt_entry_target *t, void **dstptr,
 		target->compat_from_user(t->data, ct->data);
 	else
 		memcpy(t->data, ct->data, tsize - sizeof(*ct));
-	pad = XT_ALIGN(target->targetsize) - target->targetsize;
-	if (pad > 0)
-		memset(t->data + target->targetsize, 0, pad);
 
 	tsize += off;
 	t->u.user.target_size = tsize;
-- 
2.26.3

