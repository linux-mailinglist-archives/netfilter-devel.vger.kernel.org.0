Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B8241291B
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Sep 2021 00:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhITW5n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 18:57:43 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39290 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbhITWzm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 18:55:42 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7A80763EA5
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Sep 2021 00:52:56 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] monitor: honor NLM_F_APPEND flag
Date:   Tue, 21 Sep 2021 00:54:07 +0200
Message-Id: <20210920225407.1237-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920225407.1237-1-pablo@netfilter.org>
References: <20210920225407.1237-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print 'add' or 'insert' according to this netlink flag.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/monitor.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/src/monitor.c b/src/monitor.c
index ffaa39b67304..bb60a70a11ac 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -40,6 +40,12 @@
 #include <iface.h>
 #include <json.h>
 
+enum {
+	NFT_OF_EVENT_ADD,
+	NFT_OF_EVENT_INSERT,
+	NFT_OF_EVENT_DEL,
+};
+
 #define nft_mon_print(monh, ...) nft_print(&monh->ctx->nft->output, __VA_ARGS__)
 
 struct nftnl_table *netlink_table_alloc(const struct nlmsghdr *nlh)
@@ -120,9 +126,9 @@ struct nftnl_obj *netlink_obj_alloc(const struct nlmsghdr *nlh)
 	return nlo;
 }
 
-static uint32_t netlink_msg2nftnl_of(uint32_t msg)
+static uint32_t netlink_msg2nftnl_of(uint32_t type, uint16_t flags)
 {
-	switch (msg) {
+	switch (type) {
 	case NFT_MSG_NEWTABLE:
 	case NFT_MSG_NEWCHAIN:
 	case NFT_MSG_NEWSET:
@@ -130,7 +136,10 @@ static uint32_t netlink_msg2nftnl_of(uint32_t msg)
 	case NFT_MSG_NEWRULE:
 	case NFT_MSG_NEWOBJ:
 	case NFT_MSG_NEWFLOWTABLE:
-		return NFTNL_OF_EVENT_NEW;
+		if (flags & NLM_F_APPEND)
+			return NFT_OF_EVENT_ADD;
+		else
+			return NFT_OF_EVENT_INSERT;
 	case NFT_MSG_DELTABLE:
 	case NFT_MSG_DELCHAIN:
 	case NFT_MSG_DELSET:
@@ -147,18 +156,20 @@ static uint32_t netlink_msg2nftnl_of(uint32_t msg)
 static const char *nftnl_of2cmd(uint32_t of)
 {
 	switch (of) {
-	case NFTNL_OF_EVENT_NEW:
+	case NFT_OF_EVENT_ADD:
 		return "add";
-	case NFTNL_OF_EVENT_DEL:
+	case NFT_OF_EVENT_INSERT:
+		return "insert";
+	case NFT_OF_EVENT_DEL:
 		return "delete";
 	default:
 		return "???";
 	}
 }
 
-static const char *netlink_msg2cmd(uint32_t msg)
+static const char *netlink_msg2cmd(uint32_t type, uint16_t flags)
 {
-	return nftnl_of2cmd(netlink_msg2nftnl_of(msg));
+	return nftnl_of2cmd(netlink_msg2nftnl_of(type, flags));
 }
 
 static void nlr_for_each_set(struct nftnl_rule *nlr,
@@ -206,7 +217,7 @@ static int netlink_events_table_cb(const struct nlmsghdr *nlh, int type,
 
 	nlt = netlink_table_alloc(nlh);
 	t = netlink_delinearize_table(monh->ctx, nlt);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	switch (monh->format) {
 	case NFTNL_OUTPUT_DEFAULT:
@@ -243,7 +254,7 @@ static int netlink_events_chain_cb(const struct nlmsghdr *nlh, int type,
 
 	nlc = netlink_chain_alloc(nlh);
 	c = netlink_delinearize_chain(monh->ctx, nlc);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	switch (monh->format) {
 	case NFTNL_OUTPUT_DEFAULT:
@@ -292,7 +303,7 @@ static int netlink_events_set_cb(const struct nlmsghdr *nlh, int type,
 		return MNL_CB_ERROR;
 	}
 	family = family2str(set->handle.family);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	switch (monh->format) {
 	case NFTNL_OUTPUT_DEFAULT:
@@ -394,7 +405,7 @@ static int netlink_events_setelem_cb(const struct nlmsghdr *nlh, int type,
 	table = nftnl_set_get_str(nls, NFTNL_SET_TABLE);
 	setname = nftnl_set_get_str(nls, NFTNL_SET_NAME);
 	family = nftnl_set_get_u32(nls, NFTNL_SET_FAMILY);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	set = set_lookup_global(family, table, setname, &monh->ctx->nft->cache);
 	if (set == NULL) {
@@ -482,7 +493,7 @@ static int netlink_events_obj_cb(const struct nlmsghdr *nlh, int type,
 		return MNL_CB_ERROR;
 	}
 	family = family2str(obj->handle.family);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	switch (monh->format) {
 	case NFTNL_OUTPUT_DEFAULT:
@@ -530,7 +541,7 @@ static int netlink_events_rule_cb(const struct nlmsghdr *nlh, int type,
 	r = netlink_delinearize_rule(monh->ctx, nlr);
 	nlr_for_each_set(nlr, rule_map_decompose_cb, NULL,
 			 &monh->ctx->nft->cache);
-	cmd = netlink_msg2cmd(type);
+	cmd = netlink_msg2cmd(type, nlh->nlmsg_flags);
 
 	switch (monh->format) {
 	case NFTNL_OUTPUT_DEFAULT:
-- 
2.30.2

