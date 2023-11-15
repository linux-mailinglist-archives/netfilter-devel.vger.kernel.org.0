Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBEE7EB43A
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Nov 2023 16:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233632AbjKNPzC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Nov 2023 10:55:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbjKNPzB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Nov 2023 10:55:01 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61581FE
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Nov 2023 07:54:57 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1r2vkd-0001CU-43; Tue, 14 Nov 2023 16:54:55 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC nf-next] netfilter: nf_tables: reject flowtable hw offload for same device
Date:   Tue, 14 Nov 2023 16:54:47 +0100
Message-ID: <20231114155450.30813-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The existing check is not sufficient, as it only considers flowtables
within the same table.

In case of HW offload, we need check all flowtables that exist in
the same net namespace.

We can skip flowtables that are slated for removal (not active in next gen).

Ideally this check would supersede the existing one, but this is
probably too risky and might prevent existing configs from working.

As is, you can do all of the following:

table ip t { flowtable f { devices = { lo  } } }
table ip6 t { flowtable f { devices = { lo  } } }
table inet t { flowtable f { devices = { lo  } } }

... but IMO this should not be possible in the first place.

Disable this at least when hw offlaod is requested.

This is related to XDP flowtable work, the idea is to keep a small
hashtable that has a 'struct net_device := struct nf_flowtable' map so
that xdp program can obtain the flowtable that the net_device is
part of.

This mapping must be unique.  The idea is to add a "XDP OFFLOAD"
flag to nftables api and then have this function run for 'xdp offload'
case too.

This is useful, because it would permit the "xdp offload" hashtable
to tolerate duplicate keys -- they would only occur during transactional
updates, e.g. a flush of the current table combined with atomic reload.

Without this change, the nf_flowtable core cannot tell when flowtable
is a real duplicate, or just a temporary artefact of the
two-phase-commit protocol (i.e., the clashing entry is queued for removal).

NB: This also disables ip and ip6 family for same device, plan would be
to support 'xdp offload' only for NFPROTO_INET for simplicity.

CC: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_tables_api.c | 36 +++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3c1fd8283bf4..0c3485410efc 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8183,6 +8183,37 @@ static void nft_unregister_flowtable_net_hooks(struct net *net,
 	__nft_unregister_flowtable_net_hooks(net, hook_list, false);
 }
 
+static bool nft_flowtable_offload_clash(struct net *net,
+				        const struct nft_hook *hook,
+				        struct nft_flowtable *flowtable)
+{
+	const struct nftables_pernet *nft_net;
+	struct nft_flowtable *existing_ft;
+	const struct nft_table *table;
+
+	/* No offload requested, no need to validate */
+	if (!nf_flowtable_hw_offload(&flowtable->data))
+		return false;
+
+	nft_net = nft_pernet(net);
+
+	list_for_each_entry(table, &nft_net->tables, list) {
+		list_for_each_entry(existing_ft, &table->flowtables, list) {
+		        const struct nft_hook *hook2;
+
+			if (!nft_is_active_next(net, existing_ft))
+				continue;
+
+			list_for_each_entry(hook2, &existing_ft->hook_list, list) {
+				if (hook->ops.dev == hook2->ops.dev)
+					return true;
+			}
+		}
+	}
+
+	return false;
+}
+
 static int nft_register_flowtable_net_hooks(struct net *net,
 					    struct nft_table *table,
 					    struct list_head *hook_list,
@@ -8193,6 +8224,11 @@ static int nft_register_flowtable_net_hooks(struct net *net,
 	int err, i = 0;
 
 	list_for_each_entry(hook, hook_list, list) {
+		if (nft_flowtable_offload_clash(net, hook, flowtable)) {
+			err = -EEXIST;
+			goto err_unregister_net_hooks;
+		}
+
 		list_for_each_entry(ft, &table->flowtables, list) {
 			if (!nft_is_active_next(net, ft))
 				continue;
-- 
2.41.0

