Return-Path: <netfilter-devel+bounces-4197-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F99998E35F
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Oct 2024 21:20:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 893571F209B1
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Oct 2024 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521DB212F1F;
	Wed,  2 Oct 2024 19:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="LVrBKL+V"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D930212F0E
	for <netfilter-devel@vger.kernel.org>; Wed,  2 Oct 2024 19:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727896798; cv=none; b=Lm9PL3MBzUvEGmaRnCdx4Yv/Wn5L0MSL/T1Yvk5OQds/9kBnSYA8WLpwsJmPujIDonaCdxG80DUW/D1Y+DfXgkD0OASRnKiUFgcOBWVEQjPS6mnpWJZYdWFt9aOgkACkMAPG1CtE9oiS0yVSBNPPFvcEs/QGCBFOnvk1I/JYrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727896798; c=relaxed/simple;
	bh=dwH3A2uc/P90ZwmDnKGJAxoUH3+Z9iOsh8O5q0GUomI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q/dYaES5+dLtCV0m0PBTR6xkOod0SXRUao6EfFfSq/7oNX8t8MZrlfnlyaprEp2I+BzjDp+wJit78T9dhmFPooAUydJe7eWK1G32A/VFe7z0fffhq2WLIE2Z6fa8BOdShad0O26ZevsO6HkM9kTdzaPuqH/nRgXfw9Caj0zCXGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=LVrBKL+V; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=umRZI7d5lkG1CZl5+ZeSS7YPt9xz1kvcPC4PiAkUq44=; b=LVrBKL+VjDUbR8YX00IzWRzhtT
	0JQU60D5inYBHlIozWpJyxhAZ9jCu6cX/DGiKQYR9DIDxsxLrA8bSJ7FnJBZYgU96Sbla7LTWnwg9
	yM+zLCTj/sefdU+htQ1e11THKadymSalMATL3BW7faljUw1bY9du4Wa3eWCwtQCaINr+y+SWICAVE
	vkV553mpvyq8tCitBXaoJ2mkIxO77jr52iXqDtqy3TLfwqv59PMKH/s0mMie0FLRD3+xRunknXq8s
	sFjzuslLSCTBa/2QlMhuzTMsmqX/A3SPhU6yOSLbFyO9D5B4U0PJXJqvY0D7somEhFpTCAKD1t5mk
	PGbmqryA==;
Received: from localhost ([::1] helo=xic)
	by orbyte.nwl.cc with esmtp (Exim 4.97.1)
	(envelope-from <phil@nwl.cc>)
	id 1sw4sz-000000002lH-3xiv;
	Wed, 02 Oct 2024 21:19:46 +0200
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 3/4] utils: Introduce nftnl_parse_str_attr()
Date: Wed,  2 Oct 2024 21:19:40 +0200
Message-ID: <20241002191941.8410-4-phil@nwl.cc>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241002191941.8410-1-phil@nwl.cc>
References: <20241002191941.8410-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Wrap the common parsing of string attributes in a function. Apart from
slightly reducing code size, this unifies callers in conditional freeing
of the field in case it was set before (missing in twelve spots) and
error checking for failing strdup()-calls (missing in four spots).

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/utils.h         |  3 +++
 src/chain.c             | 33 +++++++++------------------------
 src/expr/dynset.c       | 12 +++++-------
 src/expr/flow_offload.c | 12 +++++-------
 src/expr/log.c          | 13 ++++---------
 src/expr/lookup.c       | 12 +++++-------
 src/expr/objref.c       | 18 ++++++++----------
 src/flowtable.c         | 24 ++++++++----------------
 src/object.c            | 14 ++++++--------
 src/rule.c              | 22 ++++++----------------
 src/set.c               | 22 ++++++----------------
 src/set_elem.c          | 38 +++++++++++++-------------------------
 src/table.c             | 11 +++--------
 src/trace.c             | 28 ++++++++++------------------
 src/utils.c             | 15 +++++++++++++++
 15 files changed, 106 insertions(+), 171 deletions(-)

diff --git a/include/utils.h b/include/utils.h
index c8e890eae2ffd..8b5feba2bc659 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -87,4 +87,7 @@ int nftnl_set_str_attr(const char **dptr, uint32_t *flags,
 void mnl_attr_put_ifname(struct nlmsghdr *nlh, int attr, const char *ifname);
 const char *mnl_attr_get_ifname(struct nlattr *attr);
 
+int nftnl_parse_str_attr(const struct nlattr *tb, int attr,
+			 const char **field, uint32_t *flags);
+
 #endif
diff --git a/src/chain.c b/src/chain.c
index 830e09fcfbbb1..7691975a96b5f 100644
--- a/src/chain.c
+++ b/src/chain.c
@@ -746,22 +746,12 @@ int nftnl_chain_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_chain *c)
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_chain_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_CHAIN_NAME]) {
-		if (c->flags & (1 << NFTNL_CHAIN_NAME))
-			xfree(c->name);
-		c->name = strdup(mnl_attr_get_str(tb[NFTA_CHAIN_NAME]));
-		if (!c->name)
-			return -1;
-		c->flags |= (1 << NFTNL_CHAIN_NAME);
-	}
-	if (tb[NFTA_CHAIN_TABLE]) {
-		if (c->flags & (1 << NFTNL_CHAIN_TABLE))
-			xfree(c->table);
-		c->table = strdup(mnl_attr_get_str(tb[NFTA_CHAIN_TABLE]));
-		if (!c->table)
-			return -1;
-		c->flags |= (1 << NFTNL_CHAIN_TABLE);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_CHAIN_NAME], NFTNL_CHAIN_NAME,
+				 &c->name, &c->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_CHAIN_TABLE], NFTNL_CHAIN_TABLE,
+				 &c->table, &c->flags) < 0)
+		return -1;
 	if (tb[NFTA_CHAIN_HOOK]) {
 		ret = nftnl_chain_parse_hook(tb[NFTA_CHAIN_HOOK], c);
 		if (ret < 0)
@@ -784,14 +774,9 @@ int nftnl_chain_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_chain *c)
 		c->handle = be64toh(mnl_attr_get_u64(tb[NFTA_CHAIN_HANDLE]));
 		c->flags |= (1 << NFTNL_CHAIN_HANDLE);
 	}
-	if (tb[NFTA_CHAIN_TYPE]) {
-		if (c->flags & (1 << NFTNL_CHAIN_TYPE))
-			xfree(c->type);
-		c->type = strdup(mnl_attr_get_str(tb[NFTA_CHAIN_TYPE]));
-		if (!c->type)
-			return -1;
-		c->flags |= (1 << NFTNL_CHAIN_TYPE);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_CHAIN_TYPE], NFTNL_CHAIN_TYPE,
+				 &c->type, &c->flags) < 0)
+		return -1;
 	if (tb[NFTA_CHAIN_FLAGS]) {
 		c->chain_flags = ntohl(mnl_attr_get_u32(tb[NFTA_CHAIN_FLAGS]));
 		c->flags |= (1 << NFTNL_CHAIN_FLAGS);
diff --git a/src/expr/dynset.c b/src/expr/dynset.c
index 9d2bfe5e206b1..1075f52c43f7f 100644
--- a/src/expr/dynset.c
+++ b/src/expr/dynset.c
@@ -249,13 +249,11 @@ nftnl_expr_dynset_parse(struct nftnl_expr *e, struct nlattr *attr)
 		dynset->timeout = be64toh(mnl_attr_get_u64(tb[NFTA_DYNSET_TIMEOUT]));
 		e->flags |= (1 << NFTNL_EXPR_DYNSET_TIMEOUT);
 	}
-	if (tb[NFTA_DYNSET_SET_NAME]) {
-		dynset->set_name =
-			strdup(mnl_attr_get_str(tb[NFTA_DYNSET_SET_NAME]));
-		if (!dynset->set_name)
-			return -1;
-		e->flags |= (1 << NFTNL_EXPR_DYNSET_SET_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_DYNSET_SET_NAME],
+				 NFTNL_EXPR_DYNSET_SET_NAME,
+				 (const char **)&dynset->set_name,
+				 &e->flags) < 0)
+		return -1;
 	if (tb[NFTA_DYNSET_SET_ID]) {
 		dynset->set_id = ntohl(mnl_attr_get_u32(tb[NFTA_DYNSET_SET_ID]));
 		e->flags |= (1 << NFTNL_EXPR_DYNSET_SET_ID);
diff --git a/src/expr/flow_offload.c b/src/expr/flow_offload.c
index 5f209a63fa960..ce22ec419a944 100644
--- a/src/expr/flow_offload.c
+++ b/src/expr/flow_offload.c
@@ -79,13 +79,11 @@ static int nftnl_expr_flow_parse(struct nftnl_expr *e, struct nlattr *attr)
 	if (mnl_attr_parse_nested(attr, nftnl_expr_flow_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_FLOW_TABLE_NAME]) {
-		flow->table_name =
-			strdup(mnl_attr_get_str(tb[NFTA_FLOW_TABLE_NAME]));
-		if (!flow->table_name)
-			return -1;
-		e->flags |= (1 << NFTNL_EXPR_FLOW_TABLE_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_FLOW_TABLE_NAME],
+				 NFTNL_EXPR_FLOW_TABLE_NAME,
+				 (const char **)&flow->table_name,
+				 &e->flags) < 0)
+		return -1;
 
 	return ret;
 }
diff --git a/src/expr/log.c b/src/expr/log.c
index 18ec2b64a5b93..0d255f7aaa475 100644
--- a/src/expr/log.c
+++ b/src/expr/log.c
@@ -151,15 +151,10 @@ nftnl_expr_log_parse(struct nftnl_expr *e, struct nlattr *attr)
 	if (mnl_attr_parse_nested(attr, nftnl_expr_log_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_LOG_PREFIX]) {
-		if (log->prefix)
-			xfree(log->prefix);
-
-		log->prefix = strdup(mnl_attr_get_str(tb[NFTA_LOG_PREFIX]));
-		if (!log->prefix)
-			return -1;
-		e->flags |= (1 << NFTNL_EXPR_LOG_PREFIX);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_LOG_PREFIX],
+				 NFTNL_EXPR_LOG_PREFIX,
+				 &log->prefix, &e->flags) < 0)
+		return -1;
 	if (tb[NFTA_LOG_GROUP]) {
 		log->group = ntohs(mnl_attr_get_u16(tb[NFTA_LOG_GROUP]));
 		e->flags |= (1 << NFTNL_EXPR_LOG_GROUP);
diff --git a/src/expr/lookup.c b/src/expr/lookup.c
index 21a7fcef40413..07c1539f45517 100644
--- a/src/expr/lookup.c
+++ b/src/expr/lookup.c
@@ -145,13 +145,11 @@ nftnl_expr_lookup_parse(struct nftnl_expr *e, struct nlattr *attr)
 		lookup->dreg = ntohl(mnl_attr_get_u32(tb[NFTA_LOOKUP_DREG]));
 		e->flags |= (1 << NFTNL_EXPR_LOOKUP_DREG);
 	}
-	if (tb[NFTA_LOOKUP_SET]) {
-		lookup->set_name =
-			strdup(mnl_attr_get_str(tb[NFTA_LOOKUP_SET]));
-		if (!lookup->set_name)
-			return -1;
-		e->flags |= (1 << NFTNL_EXPR_LOOKUP_SET);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_LOOKUP_SET],
+				 NFTNL_EXPR_LOOKUP_SET,
+				 (const char **)&lookup->set_name,
+				 &e->flags) < 0)
+		return -1;
 	if (tb[NFTA_LOOKUP_SET_ID]) {
 		lookup->set_id =
 			ntohl(mnl_attr_get_u32(tb[NFTA_LOOKUP_SET_ID]));
diff --git a/src/expr/objref.c b/src/expr/objref.c
index 00538057222b5..76916f53c8202 100644
--- a/src/expr/objref.c
+++ b/src/expr/objref.c
@@ -148,21 +148,19 @@ static int nftnl_expr_objref_parse(struct nftnl_expr *e, struct nlattr *attr)
 			ntohl(mnl_attr_get_u32(tb[NFTA_OBJREF_IMM_TYPE]));
 		e->flags |= (1 << NFTNL_EXPR_OBJREF_IMM_TYPE);
 	}
-	if (tb[NFTA_OBJREF_IMM_NAME]) {
-		objref->imm.name =
-			strdup(mnl_attr_get_str(tb[NFTA_OBJREF_IMM_NAME]));
-		e->flags |= (1 << NFTNL_EXPR_OBJREF_IMM_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_OBJREF_IMM_NAME],
+				 NFTNL_EXPR_OBJREF_IMM_NAME,
+				 &objref->imm.name, &e->flags) < 0)
+		return -1;
 	if (tb[NFTA_OBJREF_SET_SREG]) {
 		objref->set.sreg =
 			ntohl(mnl_attr_get_u32(tb[NFTA_OBJREF_SET_SREG]));
 		e->flags |= (1 << NFTNL_EXPR_OBJREF_SET_SREG);
 	}
-	if (tb[NFTA_OBJREF_SET_NAME]) {
-		objref->set.name =
-			strdup(mnl_attr_get_str(tb[NFTA_OBJREF_SET_NAME]));
-		e->flags |= (1 << NFTNL_EXPR_OBJREF_SET_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_OBJREF_SET_NAME],
+				 NFTNL_EXPR_OBJREF_SET_NAME,
+				 &objref->set.name, &e->flags) < 0)
+		return -1;
 	if (tb[NFTA_OBJREF_SET_ID]) {
 		objref->set.id =
 			ntohl(mnl_attr_get_u32(tb[NFTA_OBJREF_SET_ID]));
diff --git a/src/flowtable.c b/src/flowtable.c
index 74cffc812996c..d907f40a70089 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -477,22 +477,14 @@ int nftnl_flowtable_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_flowtab
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_flowtable_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_FLOWTABLE_NAME]) {
-		if (c->flags & (1 << NFTNL_FLOWTABLE_NAME))
-			xfree(c->name);
-		c->name = strdup(mnl_attr_get_str(tb[NFTA_FLOWTABLE_NAME]));
-		if (!c->name)
-			return -1;
-		c->flags |= (1 << NFTNL_FLOWTABLE_NAME);
-	}
-	if (tb[NFTA_FLOWTABLE_TABLE]) {
-		if (c->flags & (1 << NFTNL_FLOWTABLE_TABLE))
-			xfree(c->table);
-		c->table = strdup(mnl_attr_get_str(tb[NFTA_FLOWTABLE_TABLE]));
-		if (!c->table)
-			return -1;
-		c->flags |= (1 << NFTNL_FLOWTABLE_TABLE);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_FLOWTABLE_NAME],
+				 NFTNL_FLOWTABLE_NAME,
+				 &c->name, &c->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_FLOWTABLE_TABLE],
+				 NFTNL_FLOWTABLE_TABLE,
+				 &c->table, &c->flags) < 0)
+		return -1;
 	if (tb[NFTA_FLOWTABLE_HOOK]) {
 		ret = nftnl_flowtable_parse_hook(tb[NFTA_FLOWTABLE_HOOK], c);
 		if (ret < 0)
diff --git a/src/object.c b/src/object.c
index 9d150315d487d..1935879fdaa24 100644
--- a/src/object.c
+++ b/src/object.c
@@ -344,14 +344,12 @@ int nftnl_obj_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_obj *obj)
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_obj_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_OBJ_TABLE]) {
-		obj->table = strdup(mnl_attr_get_str(tb[NFTA_OBJ_TABLE]));
-		obj->flags |= (1 << NFTNL_OBJ_TABLE);
-	}
-	if (tb[NFTA_OBJ_NAME]) {
-		obj->name = strdup(mnl_attr_get_str(tb[NFTA_OBJ_NAME]));
-		obj->flags |= (1 << NFTNL_OBJ_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_OBJ_TABLE], NFTNL_OBJ_TABLE,
+				 &obj->table, &obj->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_OBJ_NAME], NFTNL_OBJ_NAME,
+				 &obj->name, &obj->flags) < 0)
+		return -1;
 	if (tb[NFTA_OBJ_TYPE]) {
 		uint32_t type = ntohl(mnl_attr_get_u32(tb[NFTA_OBJ_TYPE]));
 
diff --git a/src/rule.c b/src/rule.c
index c22918a8f3527..07ca3227fac4d 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -435,22 +435,12 @@ int nftnl_rule_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_rule *r)
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_rule_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_RULE_TABLE]) {
-		if (r->flags & (1 << NFTNL_RULE_TABLE))
-			xfree(r->table);
-		r->table = strdup(mnl_attr_get_str(tb[NFTA_RULE_TABLE]));
-		if (!r->table)
-			return -1;
-		r->flags |= (1 << NFTNL_RULE_TABLE);
-	}
-	if (tb[NFTA_RULE_CHAIN]) {
-		if (r->flags & (1 << NFTNL_RULE_CHAIN))
-			xfree(r->chain);
-		r->chain = strdup(mnl_attr_get_str(tb[NFTA_RULE_CHAIN]));
-		if (!r->chain)
-			return -1;
-		r->flags |= (1 << NFTNL_RULE_CHAIN);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_RULE_TABLE], NFTNL_RULE_TABLE,
+				 &r->table, &r->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_RULE_CHAIN], NFTNL_RULE_CHAIN,
+				 &r->chain, &r->flags) < 0)
+		return -1;
 	if (tb[NFTA_RULE_HANDLE]) {
 		r->handle = be64toh(mnl_attr_get_u64(tb[NFTA_RULE_HANDLE]));
 		r->flags |= (1 << NFTNL_RULE_HANDLE);
diff --git a/src/set.c b/src/set.c
index 75ad64e038502..f3a1dd188246a 100644
--- a/src/set.c
+++ b/src/set.c
@@ -645,22 +645,12 @@ int nftnl_set_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_set *s)
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_set_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_SET_TABLE]) {
-		if (s->flags & (1 << NFTNL_SET_TABLE))
-			xfree(s->table);
-		s->table = strdup(mnl_attr_get_str(tb[NFTA_SET_TABLE]));
-		if (!s->table)
-			return -1;
-		s->flags |= (1 << NFTNL_SET_TABLE);
-	}
-	if (tb[NFTA_SET_NAME]) {
-		if (s->flags & (1 << NFTNL_SET_NAME))
-			xfree(s->name);
-		s->name = strdup(mnl_attr_get_str(tb[NFTA_SET_NAME]));
-		if (!s->name)
-			return -1;
-		s->flags |= (1 << NFTNL_SET_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_SET_TABLE], NFTNL_SET_TABLE,
+				 &s->table, &s->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_SET_NAME], NFTNL_SET_NAME,
+				 &s->name, &s->flags) < 0)
+		return -1;
 	if (tb[NFTA_SET_HANDLE]) {
 		s->handle = be64toh(mnl_attr_get_u64(tb[NFTA_SET_HANDLE]));
 		s->flags |= (1 << NFTNL_SET_HANDLE);
diff --git a/src/set_elem.c b/src/set_elem.c
index 9207a0dbd6899..7b3c01701aaee 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -580,13 +580,11 @@ static int nftnl_set_elems_parse2(struct nftnl_set *s, const struct nlattr *nest
 		memcpy(e->user.data, udata, e->user.len);
 		e->flags |= (1 << NFTNL_RULE_USERDATA);
 	}
-	if (tb[NFTA_SET_ELEM_OBJREF]) {
-		e->objref = strdup(mnl_attr_get_str(tb[NFTA_SET_ELEM_OBJREF]));
-		if (e->objref == NULL) {
-			ret = -1;
-			goto out_set_elem;
-		}
-		e->flags |= (1 << NFTNL_SET_ELEM_OBJREF);
+	if (nftnl_parse_str_attr(tb[NFTA_SET_ELEM_OBJREF],
+				 NFTNL_SET_ELEM_OBJREF,
+				 &e->objref, &e->flags) < 0) {
+		ret = -1;
+		goto out_set_elem;
 	}
 
 	/* Add this new element to this set */
@@ -650,24 +648,14 @@ int nftnl_set_elems_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_set *s)
 			   nftnl_set_elem_list_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_SET_ELEM_LIST_TABLE]) {
-		if (s->flags & (1 << NFTNL_SET_TABLE))
-			xfree(s->table);
-		s->table =
-			strdup(mnl_attr_get_str(tb[NFTA_SET_ELEM_LIST_TABLE]));
-		if (!s->table)
-			return -1;
-		s->flags |= (1 << NFTNL_SET_TABLE);
-	}
-	if (tb[NFTA_SET_ELEM_LIST_SET]) {
-		if (s->flags & (1 << NFTNL_SET_NAME))
-			xfree(s->name);
-		s->name =
-			strdup(mnl_attr_get_str(tb[NFTA_SET_ELEM_LIST_SET]));
-		if (!s->name)
-			return -1;
-		s->flags |= (1 << NFTNL_SET_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_SET_ELEM_LIST_TABLE],
+				 NFTNL_SET_TABLE,
+				 &s->table, &s->flags) < 0)
+		return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_SET_ELEM_LIST_SET],
+				 NFTNL_SET_NAME,
+				 &s->name, &s->flags) < 0)
+		return -1;
 	if (tb[NFTA_SET_ELEM_LIST_SET_ID]) {
 		s->id = ntohl(mnl_attr_get_u32(tb[NFTA_SET_ELEM_LIST_SET_ID]));
 		s->flags |= (1 << NFTNL_SET_ID);
diff --git a/src/table.c b/src/table.c
index b1b164cbbcedc..c0566b242cacf 100644
--- a/src/table.c
+++ b/src/table.c
@@ -289,14 +289,9 @@ int nftnl_table_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_table *t)
 	if (mnl_attr_parse(nlh, sizeof(*nfg), nftnl_table_parse_attr_cb, tb) < 0)
 		return -1;
 
-	if (tb[NFTA_TABLE_NAME]) {
-		if (t->flags & (1 << NFTNL_TABLE_NAME))
-			xfree(t->name);
-		t->name = strdup(mnl_attr_get_str(tb[NFTA_TABLE_NAME]));
-		if (!t->name)
-			return -1;
-		t->flags |= (1 << NFTNL_TABLE_NAME);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_TABLE_NAME], NFTNL_TABLE_NAME,
+				 &t->name, &t->flags) < 0)
+		return -1;
 	if (tb[NFTA_TABLE_FLAGS]) {
 		t->table_flags = ntohl(mnl_attr_get_u32(tb[NFTA_TABLE_FLAGS]));
 		t->flags |= (1 << NFTNL_TABLE_FLAGS);
diff --git a/src/trace.c b/src/trace.c
index f4264377508e8..5accf12a542d5 100644
--- a/src/trace.c
+++ b/src/trace.c
@@ -315,11 +315,11 @@ static int nftnl_trace_parse_verdict(const struct nlattr *attr,
 	case NFT_JUMP:
 		if (!tb[NFTA_VERDICT_CHAIN])
 			abi_breakage();
-		t->jump_target = strdup(mnl_attr_get_str(tb[NFTA_VERDICT_CHAIN]));
-		if (!t->jump_target)
+		if (nftnl_parse_str_attr(tb[NFTA_VERDICT_CHAIN],
+					 NFTNL_TRACE_JUMP_TARGET,
+					 (const char **)&t->jump_target,
+					 &t->flags) < 0)
 			return -1;
-
-		t->flags |= (1 << NFTNL_TRACE_JUMP_TARGET);
 		break;
 	}
 	return 0;
@@ -349,21 +349,13 @@ int nftnl_trace_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_trace *t)
 	t->id = ntohl(mnl_attr_get_u32(tb[NFTA_TRACE_ID]));
 	t->flags |= (1 << NFTNL_TRACE_ID);
 
-	if (tb[NFTA_TRACE_TABLE]) {
-		t->table = strdup(mnl_attr_get_str(tb[NFTA_TRACE_TABLE]));
-		if (!t->table)
-			return -1;
-
-		t->flags |= (1 << NFTNL_TRACE_TABLE);
-	}
-
-	if (tb[NFTA_TRACE_CHAIN]) {
-		t->chain = strdup(mnl_attr_get_str(tb[NFTA_TRACE_CHAIN]));
-		if (!t->chain)
-			return -1;
+	if (nftnl_parse_str_attr(tb[NFTA_TRACE_TABLE], NFTNL_TRACE_TABLE,
+				 (const char **)&t->table, &t->flags) < 0)
+		return -1;
 
-		t->flags |= (1 << NFTNL_TRACE_CHAIN);
-	}
+	if (nftnl_parse_str_attr(tb[NFTA_TRACE_CHAIN], NFTNL_TRACE_CHAIN,
+				 (const char **)&t->chain, &t->flags) < 0)
+		return -1;
 
 	if (tb[NFTA_TRACE_IIFTYPE]) {
 		t->iiftype = ntohs(mnl_attr_get_u16(tb[NFTA_TRACE_IIFTYPE]));
diff --git a/src/utils.c b/src/utils.c
index df00ce04b32ea..fdf662778e826 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -180,3 +180,18 @@ const char *mnl_attr_get_ifname(struct nlattr *attr)
 	memcpy(buf + slen, "*\0", 2);
 	return buf;
 }
+
+int nftnl_parse_str_attr(const struct nlattr *tb, int attr,
+			 const char **field, uint32_t *flags)
+{
+	if (!tb)
+		return 0;
+
+	if (*flags & (1 << attr))
+		xfree(*field);
+	*field = strdup(mnl_attr_get_str(tb));
+	if (!*field)
+		return -1;
+	*flags |= (1 << attr);
+	return 0;
+}
-- 
2.43.0


