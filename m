Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B034541DBF2
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Sep 2021 16:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351750AbhI3OHm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Sep 2021 10:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351633AbhI3OHm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:07:42 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4E1C06176A
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Sep 2021 07:05:59 -0700 (PDT)
Received: from localhost ([::1]:51756 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mVwhB-0007TP-Vm; Thu, 30 Sep 2021 16:05:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 03/17] nft-shared: Introduce init_cs family ops callback
Date:   Thu, 30 Sep 2021 16:04:05 +0200
Message-Id: <20210930140419.6170-4-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930140419.6170-1-phil@nwl.cc>
References: <20210930140419.6170-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Arptables sets a few defaults in struct iptables_command_state upon
initialization. Introduce a callback to do that.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft-arp.c    |  9 +++++++++
 iptables/nft-shared.h |  1 +
 iptables/xtables.c    | 12 +++++++-----
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/iptables/nft-arp.c b/iptables/nft-arp.c
index 2a9387a18dffe..fbaf1a6d52184 100644
--- a/iptables/nft-arp.c
+++ b/iptables/nft-arp.c
@@ -546,6 +546,14 @@ static void nft_arp_save_chain(const struct nftnl_chain *c, const char *policy)
 	printf(":%s %s\n", chain, policy ?: "-");
 }
 
+static void nft_arp_init_cs(struct iptables_command_state *cs)
+{
+	cs->arp.arp.arhln = 6;
+	cs->arp.arp.arhln_mask = 255;
+	cs->arp.arp.arhrd = htons(ARPHRD_ETHER);
+	cs->arp.arp.arhrd_mask = 65535;
+}
+
 struct nft_family_ops nft_family_ops_arp = {
 	.add			= nft_arp_add,
 	.is_same		= nft_arp_is_same,
@@ -559,6 +567,7 @@ struct nft_family_ops nft_family_ops_arp = {
 	.save_chain		= nft_arp_save_chain,
 	.post_parse		= NULL,
 	.rule_to_cs		= nft_rule_to_iptables_command_state,
+	.init_cs		= nft_arp_init_cs,
 	.clear_cs		= nft_clear_iptables_command_state,
 	.parse_target		= nft_ipv46_parse_target,
 };
diff --git a/iptables/nft-shared.h b/iptables/nft-shared.h
index cc8f3a79b369e..71094a28e73de 100644
--- a/iptables/nft-shared.h
+++ b/iptables/nft-shared.h
@@ -106,6 +106,7 @@ struct nft_family_ops {
 			   struct xtables_args *args);
 	void (*parse_match)(struct xtables_match *m, void *data);
 	void (*parse_target)(struct xtables_target *t, void *data);
+	void (*init_cs)(struct iptables_command_state *cs);
 	void (*rule_to_cs)(struct nft_handle *h, const struct nftnl_rule *r,
 			   struct iptables_command_state *cs);
 	void (*clear_cs)(struct iptables_command_state *cs);
diff --git a/iptables/xtables.c b/iptables/xtables.c
index c17cf7aec6178..092edaaf89224 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -433,10 +433,6 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
 	bool invert = false;
 	int wait = 0;
 
-	memset(cs, 0, sizeof(*cs));
-	cs->jumpto = "";
-	cs->argv = argv;
-
 	/* re-set optind to 0 in case do_command4 gets called
 	 * a second time */
 	optind = 0;
@@ -912,11 +908,17 @@ int do_commandx(struct nft_handle *h, int argc, char *argv[], char **table,
 		.table		= *table,
 		.restore	= restore,
 	};
-	struct iptables_command_state cs;
+	struct iptables_command_state cs = {
+		.jumpto = "",
+		.argv = argv,
+	};
 	struct xtables_args args = {
 		.family = h->family,
 	};
 
+	if (h->ops->init_cs)
+		h->ops->init_cs(&cs);
+
 	do_parse(h, argc, argv, &p, &cs, &args);
 
 	switch (p.command) {
-- 
2.33.0

