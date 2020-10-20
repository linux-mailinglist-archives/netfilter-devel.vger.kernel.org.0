Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D172837BF
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Oct 2020 16:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgJEO2t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Oct 2020 10:28:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726429AbgJEO2m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Oct 2020 10:28:42 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAD0C0613CE
        for <netfilter-devel@vger.kernel.org>; Mon,  5 Oct 2020 07:28:42 -0700 (PDT)
Received: from localhost ([::1]:58628 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kPRTk-0005Hw-N1; Mon, 05 Oct 2020 16:28:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: [iptables PATCH 2/3] nft: Fix error reporting for refreshed transactions
Date:   Mon,  5 Oct 2020 16:48:57 +0200
Message-Id: <20201005144858.11578-3-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005144858.11578-1-phil@nwl.cc>
References: <20201005144858.11578-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When preparing a batch from the list of batch objects in nft_action(),
the sequence number used for each object is stored within that object
for later matching against returned error messages. Though if the
transaction has to be refreshed, some of those objects may be skipped,
other objects take over their sequence number and errors are matched to
skipped objects. Avoid this by resetting the skipped object's sequence
number to zero.

Fixes: 58d7de0181f61 ("xtables: handle concurrent ruleset modifications")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 09421cf4eaaec..70be9ba908edc 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2729,9 +2729,10 @@ retry:
 	h->nft_genid++;
 
 	list_for_each_entry(n, &h->obj_list, head) {
-
-		if (n->skip)
+		if (n->skip) {
+			n->seq = 0;
 			continue;
+		}
 
 		n->seq = seq++;
 		switch (n->type) {
-- 
2.28.0

