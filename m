Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B2A31EE535
	for <lists+netfilter-devel@lfdr.de>; Thu,  4 Jun 2020 15:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbgFDNWE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 4 Jun 2020 09:22:04 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:39900 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728474AbgFDNWA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:22:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591276918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=DHrMnCyPNfTHJnXV1DMm7XzmV+ayRU6NvyYnxtLnRIo=;
        b=JaXuKkTfFI4kP0NKaEU42mXxdf05xiJXKlGbM64UgNZiSQWDJxPrb67hCKCnUlAzpeA8FC
        hDhnS3V1+5rM/+NkmukqfsacZsLlKbYRP2tFI/Iq4GHvAzFqhCEtnxHxGB27kSsMN0qvlC
        7wZnVRst3UMJengG2xmK891Tv9hLZz4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-5vhAVLh8OLmA_U0I1odt_Q-1; Thu, 04 Jun 2020 09:21:54 -0400
X-MC-Unique: 5vhAVLh8OLmA_U0I1odt_Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A8819BFDE;
        Thu,  4 Jun 2020 13:21:48 +0000 (UTC)
Received: from madcap2.tricolour.ca (unknown [10.10.110.54])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AE1678F08;
        Thu,  4 Jun 2020 13:21:16 +0000 (UTC)
From:   Richard Guy Briggs <rgb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Cc:     Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, fw@strlen.de, twoerner@redhat.com,
        eparis@parisplace.org, tgraf@infradead.org,
        Richard Guy Briggs <rgb@redhat.com>
Subject: [PATCH ghak124 v3] audit: log nftables configuration change events
Date:   Thu,  4 Jun 2020 09:20:49 -0400
Message-Id: <f9da8b5dbf2396b621c77c17b5b1123be5aa484e.1591275439.git.rgb@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

iptables, ip6tables, arptables and ebtables table registration,
replacement and unregistration configuration events are logged for the
native (legacy) iptables setsockopt api, but not for the
nftables netlink api which is used by the nft-variant of iptables in
addition to nftables itself.

Add calls to log the configuration actions in the nftables netlink api.

This uses the same NETFILTER_CFG record format but overloads the table
field.

  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.878:162) : table=?:0;?:0 family=unspecified entries=2 op=nft_register_gen pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
  ...
  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.878:162) : table=firewalld:1;?:0 family=inet entries=0 op=nft_register_table pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
  ...
  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.911:163) : table=firewalld:1;filter_FORWARD:85 family=inet entries=8 op=nft_register_chain pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
  ...
  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.911:163) : table=firewalld:1;filter_FORWARD:85 family=inet entries=101 op=nft_register_rule pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
  ...
  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.911:163) : table=firewalld:1;__set0:87 family=inet entries=87 op=nft_register_setelem pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld
  ...
  type=NETFILTER_CFG msg=audit(2020-05-28 17:46:41.911:163) : table=firewalld:1;__set0:87 family=inet entries=0 op=nft_register_set pid=396 subj=system_u:system_r:firewalld_t:s0 comm=firewalld

For further information please see issue
https://github.com/linux-audit/audit-kernel/issues/124

Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
---
Changelog:
v3:
- inline message type rather than table

v2:
- differentiate between xtables and nftables
- add set, setelem, obj, flowtable, gen
- use nentries field as appropriate per type
- overload the "tables" field with table handle and chain/set/flowtable

 include/linux/audit.h         |  18 ++++++++
 kernel/auditsc.c              |  24 ++++++++--
 net/netfilter/nf_tables_api.c | 103 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+), 3 deletions(-)

diff --git a/include/linux/audit.h b/include/linux/audit.h
index 3fcd9ee49734..604ede630580 100644
--- a/include/linux/audit.h
+++ b/include/linux/audit.h
@@ -12,6 +12,7 @@
 #include <linux/sched.h>
 #include <linux/ptrace.h>
 #include <uapi/linux/audit.h>
+#include <uapi/linux/netfilter/nf_tables.h>
 
 #define AUDIT_INO_UNSET ((unsigned long)-1)
 #define AUDIT_DEV_UNSET ((dev_t)-1)
@@ -98,6 +99,23 @@ enum audit_nfcfgop {
 	AUDIT_XT_OP_REGISTER,
 	AUDIT_XT_OP_REPLACE,
 	AUDIT_XT_OP_UNREGISTER,
+	AUDIT_NFT_OP_TABLE_REGISTER,
+	AUDIT_NFT_OP_TABLE_UNREGISTER,
+	AUDIT_NFT_OP_CHAIN_REGISTER,
+	AUDIT_NFT_OP_CHAIN_UNREGISTER,
+	AUDIT_NFT_OP_RULE_REGISTER,
+	AUDIT_NFT_OP_RULE_UNREGISTER,
+	AUDIT_NFT_OP_SET_REGISTER,
+	AUDIT_NFT_OP_SET_UNREGISTER,
+	AUDIT_NFT_OP_SETELEM_REGISTER,
+	AUDIT_NFT_OP_SETELEM_UNREGISTER,
+	AUDIT_NFT_OP_GEN_REGISTER,
+	AUDIT_NFT_OP_OBJ_REGISTER,
+	AUDIT_NFT_OP_OBJ_UNREGISTER,
+	AUDIT_NFT_OP_OBJ_RESET,
+	AUDIT_NFT_OP_FLOWTABLE_REGISTER,
+	AUDIT_NFT_OP_FLOWTABLE_UNREGISTER,
+	AUDIT_NFT_OP_INVALID,
 };
 
 extern int is_audit_feature_set(int which);
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index 468a23390457..3a9100e95fda 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -75,6 +75,7 @@
 #include <linux/uaccess.h>
 #include <linux/fsnotify_backend.h>
 #include <uapi/linux/limits.h>
+#include <uapi/linux/netfilter/nf_tables.h>
 
 #include "audit.h"
 
@@ -136,9 +137,26 @@ struct audit_nfcfgop_tab {
 };
 
 static const struct audit_nfcfgop_tab audit_nfcfgs[] = {
-	{ AUDIT_XT_OP_REGISTER,		"register"	},
-	{ AUDIT_XT_OP_REPLACE,		"replace"	},
-	{ AUDIT_XT_OP_UNREGISTER,	"unregister"	},
+	{ AUDIT_XT_OP_REGISTER,			"xt_register"		   },
+	{ AUDIT_XT_OP_REPLACE,			"xt_replace"		   },
+	{ AUDIT_XT_OP_UNREGISTER,		"xt_unregister"		   },
+	{ AUDIT_NFT_OP_TABLE_REGISTER,		"nft_register_table"	   },
+	{ AUDIT_NFT_OP_TABLE_UNREGISTER,	"nft_unregister_table"	   },
+	{ AUDIT_NFT_OP_CHAIN_REGISTER,		"nft_register_chain"	   },
+	{ AUDIT_NFT_OP_CHAIN_UNREGISTER,	"nft_unregister_chain"	   },
+	{ AUDIT_NFT_OP_RULE_REGISTER,		"nft_register_rule"	   },
+	{ AUDIT_NFT_OP_RULE_UNREGISTER,		"nft_unregister_rule"	   },
+	{ AUDIT_NFT_OP_SET_REGISTER,		"nft_register_set"	   },
+	{ AUDIT_NFT_OP_SET_UNREGISTER,		"nft_unregister_set"	   },
+	{ AUDIT_NFT_OP_SETELEM_REGISTER,	"nft_register_setelem"	   },
+	{ AUDIT_NFT_OP_SETELEM_UNREGISTER,	"nft_unregister_setelem"   },
+	{ AUDIT_NFT_OP_GEN_REGISTER,		"nft_register_gen"	   },
+	{ AUDIT_NFT_OP_OBJ_REGISTER,		"nft_register_obj"	   },
+	{ AUDIT_NFT_OP_OBJ_UNREGISTER,		"nft_unregister_obj"	   },
+	{ AUDIT_NFT_OP_OBJ_RESET,		"nft_reset_obj"		   },
+	{ AUDIT_NFT_OP_FLOWTABLE_REGISTER,	"nft_register_flowtable"   },
+	{ AUDIT_NFT_OP_FLOWTABLE_UNREGISTER,	"nft_unregister_flowtable" },
+	{ AUDIT_NFT_OP_INVALID,			"nft_invalid"		   },
 };
 
 static int audit_match_perm(struct audit_context *ctx, int mask)
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3558e76e2733..b9e7440cc87d 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -12,6 +12,7 @@
 #include <linux/netlink.h>
 #include <linux/vmalloc.h>
 #include <linux/rhashtable.h>
+#include <linux/audit.h>
 #include <linux/netfilter.h>
 #include <linux/netfilter/nfnetlink.h>
 #include <linux/netfilter/nf_tables.h>
@@ -693,6 +694,16 @@ static void nf_tables_table_notify(const struct nft_ctx *ctx, int event)
 {
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;?:0",
+			      ctx->table->name, ctx->table->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			ctx->table->use,
+			event == NFT_MSG_NEWTABLE ?
+				AUDIT_NFT_OP_TABLE_REGISTER :
+				AUDIT_NFT_OP_TABLE_UNREGISTER);
+	kfree(buf);
 
 	if (!ctx->report &&
 	    !nfnetlink_has_listeners(ctx->net, NFNLGRP_NFTABLES))
@@ -1428,6 +1439,17 @@ static void nf_tables_chain_notify(const struct nft_ctx *ctx, int event)
 {
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;%s:%llu",
+			      ctx->table->name, ctx->table->handle,
+			      ctx->chain->name, ctx->chain->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			ctx->chain->use,
+			event == NFT_MSG_NEWCHAIN ?
+				AUDIT_NFT_OP_CHAIN_REGISTER :
+				AUDIT_NFT_OP_CHAIN_UNREGISTER);
+	kfree(buf);
 
 	if (!ctx->report &&
 	    !nfnetlink_has_listeners(ctx->net, NFNLGRP_NFTABLES))
@@ -2691,6 +2713,17 @@ static void nf_tables_rule_notify(const struct nft_ctx *ctx,
 {
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;%s:%llu",
+			      ctx->table->name, ctx->table->handle,
+			      ctx->chain->name, ctx->chain->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			rule->handle,
+			event == NFT_MSG_NEWRULE ?
+				AUDIT_NFT_OP_RULE_REGISTER :
+				AUDIT_NFT_OP_RULE_UNREGISTER);
+	kfree(buf);
 
 	if (!ctx->report &&
 	    !nfnetlink_has_listeners(ctx->net, NFNLGRP_NFTABLES))
@@ -3693,6 +3726,17 @@ static void nf_tables_set_notify(const struct nft_ctx *ctx,
 	struct sk_buff *skb;
 	u32 portid = ctx->portid;
 	int err;
+	char *buf = kasprintf(gfp_flags, "%s:%llu;%s:%llu",
+			      ctx->table->name, ctx->table->handle,
+			      set->name, set->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			set->field_count,
+			event == NFT_MSG_NEWSET ?
+				AUDIT_NFT_OP_SET_REGISTER :
+				AUDIT_NFT_OP_SET_UNREGISTER);
+	kfree(buf);
 
 	if (!ctx->report &&
 	    !nfnetlink_has_listeners(ctx->net, NFNLGRP_NFTABLES))
@@ -4809,6 +4853,17 @@ static void nf_tables_setelem_notify(const struct nft_ctx *ctx,
 	u32 portid = ctx->portid;
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;%s:%llu",
+			      ctx->table->name, ctx->table->handle,
+			      set->name, set->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			set->handle,
+			event == NFT_MSG_NEWSETELEM ?
+				AUDIT_NFT_OP_SETELEM_REGISTER :
+				AUDIT_NFT_OP_SETELEM_UNREGISTER);
+	kfree(buf);
 
 	if (!ctx->report && !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
 		return;
@@ -5890,6 +5945,19 @@ static int nf_tables_dump_obj(struct sk_buff *skb, struct netlink_callback *cb)
 			    obj->ops->type->type != filter->type)
 				goto cont;
 
+			if (reset) {
+				char *buf = kasprintf(GFP_KERNEL,
+						      "%s:%llu;?:0",
+						      table->name,
+						      table->handle);
+
+				audit_log_nfcfg(buf,
+						family,
+						obj->handle,
+						AUDIT_NFT_OP_OBJ_RESET);
+				kfree(buf);
+			}
+
 			if (nf_tables_fill_obj_info(skb, net, NETLINK_CB(cb->skb).portid,
 						    cb->nlh->nlmsg_seq,
 						    NFT_MSG_NEWOBJ,
@@ -6000,6 +6068,17 @@ static int nf_tables_getobj(struct net *net, struct sock *nlsk,
 	if (NFNL_MSG_TYPE(nlh->nlmsg_type) == NFT_MSG_GETOBJ_RESET)
 		reset = true;
 
+	if (reset) {
+		char *buf = kasprintf(GFP_KERNEL, "%s:%llu;?:0",
+				      table->name, table->handle);
+
+		audit_log_nfcfg(buf,
+				family,
+				obj->handle,
+				AUDIT_NFT_OP_OBJ_RESET);
+		kfree(buf);
+	}
+
 	err = nf_tables_fill_obj_info(skb2, net, NETLINK_CB(skb).portid,
 				      nlh->nlmsg_seq, NFT_MSG_NEWOBJ, 0,
 				      family, table, obj, reset);
@@ -6075,6 +6154,16 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 {
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;?:0",
+			      table->name, table->handle);
+
+	audit_log_nfcfg(buf,
+			family,
+			obj->handle,
+			event == NFT_MSG_NEWOBJ ?
+				AUDIT_NFT_OP_OBJ_REGISTER :
+				AUDIT_NFT_OP_OBJ_UNREGISTER);
+	kfree(buf);
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
@@ -6701,6 +6790,17 @@ static void nf_tables_flowtable_notify(struct nft_ctx *ctx,
 {
 	struct sk_buff *skb;
 	int err;
+	char *buf = kasprintf(GFP_KERNEL, "%s:%llu;%s:%llu",
+			      flowtable->table->name, flowtable->table->handle,
+			      flowtable->name, flowtable->handle);
+
+	audit_log_nfcfg(buf,
+			ctx->family,
+			flowtable->hooknum,
+			event == NFT_MSG_NEWFLOWTABLE ?
+				AUDIT_NFT_OP_FLOWTABLE_REGISTER :
+				AUDIT_NFT_OP_FLOWTABLE_UNREGISTER);
+	kfree(buf);
 
 	if (ctx->report &&
 	    !nfnetlink_has_listeners(ctx->net, NFNLGRP_NFTABLES))
@@ -6822,6 +6922,9 @@ static void nf_tables_gen_notify(struct net *net, struct sk_buff *skb,
 	struct sk_buff *skb2;
 	int err;
 
+	audit_log_nfcfg("?:0;?:0", 0, net->nft.base_seq,
+			AUDIT_NFT_OP_GEN_REGISTER);
+
 	if (nlmsg_report(nlh) &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
 		return;
-- 
1.8.3.1

