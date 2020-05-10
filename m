Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5927C1CCB08
	for <lists+netfilter-devel@lfdr.de>; Sun, 10 May 2020 14:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728882AbgEJM2R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 May 2020 08:28:17 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:39672 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgEJM2Q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 May 2020 08:28:16 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1jXl3z-00061G-GI; Sun, 10 May 2020 14:28:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf] netfilter: conntrack: fix infinite loop on rmmod
Date:   Sun, 10 May 2020 14:28:07 +0200
Message-Id: <20200510122807.24011-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

'rmmod nf_conntrack' can hang forever, because the netns exit
gets stuck in nf_conntrack_cleanup_net_list():

i_see_dead_people:
 busy = 0;
 list_for_each_entry(net, net_exit_list, exit_list) {
  nf_ct_iterate_cleanup(kill_all, net, 0, 0);
  if (atomic_read(&net->ct.count) != 0)
   busy = 1;
 }
 if (busy) {
  schedule();
  goto i_see_dead_people;
 }

When nf_ct_iterate_cleanup iterates the conntrack table, all nf_conn
structures can be found twice:
once for the original tuple and once for the conntracks reply tuple.

get_next_corpse() only calls the iterator when the entry is
in original direction -- the idea was to avoid unneeded invocations
of the iterator callback.

When support for clashing entries was added, the assumption that
all nf_conn objects are added twice, once in original, once for reply
tuple no longer holds -- NF_CLASH_BIT entries are only added in
the non-clashing reply direction.

Thus, if at least one NF_CLASH entry is in the list then
nf_conntrack_cleanup_net_list() always skips it completely.

During normal netns destruction, this causes a hang of several
seconds, until the gc worker removes the entry (NF_CLASH entries
always have a 1 second timeout).

But in the rmmod case, the gc worker has already been stopped, so
ct.count never becomes 0.

We can fix this in two ways:

1. Add a second test for CLASH_BIT and call iterator for those
   entries as well, or:
2. Skip the original tuple direction and use the reply tuple.

2) is simpler, so do that.

Fixes: 6a757c07e51f80ac ("netfilter: conntrack: allow insertion of clashing entries")
Reported-by: Chen Yi <yiche@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_conntrack_core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index c4582eb71766..8cbce1159a91 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2139,8 +2139,19 @@ get_next_corpse(int (*iter)(struct nf_conn *i, void *data),
 		nf_conntrack_lock(lockp);
 		if (*bucket < nf_conntrack_htable_size) {
 			hlist_nulls_for_each_entry(h, n, &nf_conntrack_hash[*bucket], hnnode) {
-				if (NF_CT_DIRECTION(h) != IP_CT_DIR_ORIGINAL)
+				if (NF_CT_DIRECTION(h) != IP_CT_DIR_REPLY)
 					continue;
+				/* All nf_conn objects are added to hash table twice, one
+				 * for original direction tuple, once for the reply tuple.
+				 *
+				 * Exception: In the IPS_NAT_CLASH case, only the reply
+				 * tuple is added (the original tuple already existed for
+				 * a different object).
+				 *
+				 * We only need to call the iterator once for each
+				 * conntrack, so we just use the 'reply' direction
+				 * tuple while iterating.
+				 */
 				ct = nf_ct_tuplehash_to_ctrack(h);
 				if (iter(ct, data))
 					goto found;
-- 
2.26.2

