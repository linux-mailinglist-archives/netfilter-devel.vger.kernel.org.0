Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9EE52D899F
	for <lists+netfilter-devel@lfdr.de>; Sat, 12 Dec 2020 20:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439820AbgLLTTW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 12 Dec 2020 14:19:22 -0500
Received: from correo.us.es ([193.147.175.20]:46192 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439811AbgLLTTV (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 12 Dec 2020 14:19:21 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id C9B671C4385
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 20:18:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B817EDA722
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 20:18:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id AD896DA72F; Sat, 12 Dec 2020 20:18:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 41087DA722
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 20:18:23 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 12 Dec 2020 20:18:23 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 2B01242EE38E
        for <netfilter-devel@vger.kernel.org>; Sat, 12 Dec 2020 20:18:23 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl 1/3] src: add NFTNL_SET_ELEM_EXPRESSIONS
Date:   Sat, 12 Dec 2020 20:18:30 +0100
Message-Id: <20201212191832.27781-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

NFTNL_SET_ELEM_EXPR defines the stateful expression type that this
element stores. This is useful to restore runtime set element stateful
expressions (when saving, then reboot and restore).

This patch adds support for the set element expression list, which
generalizes NFTNL_SET_ELEM_EXPR.

This patch also adds nftnl_set_elem_add_expr() to add new expressions to
set elements and nftnl_set_elem_expr_foreach() to iterate over the list
of expressions.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/libnftnl/set.h              |   7 ++
 include/linux/netfilter/nf_tables.h |   3 +
 include/set_elem.h                  |   2 +-
 src/libnftnl.map                    |   5 ++
 src/set_elem.c                      | 111 +++++++++++++++++++++++-----
 5 files changed, 110 insertions(+), 18 deletions(-)

diff --git a/include/libnftnl/set.h b/include/libnftnl/set.h
index 961ce5d7d71d..1804850dc92b 100644
--- a/include/libnftnl/set.h
+++ b/include/libnftnl/set.h
@@ -107,6 +107,7 @@ enum {
 	NFTNL_SET_ELEM_EXPR,
 	NFTNL_SET_ELEM_OBJREF,
 	NFTNL_SET_ELEM_KEY_END,
+	NFTNL_SET_ELEM_EXPRESSIONS,
 	__NFTNL_SET_ELEM_MAX
 };
 #define NFTNL_SET_ELEM_MAX (__NFTNL_SET_ELEM_MAX - 1)
@@ -144,6 +145,12 @@ int nftnl_set_elem_parse_file(struct nftnl_set_elem *e, enum nftnl_parse_type ty
 int nftnl_set_elem_snprintf(char *buf, size_t size, const struct nftnl_set_elem *s, uint32_t type, uint32_t flags);
 int nftnl_set_elem_fprintf(FILE *fp, const struct nftnl_set_elem *se, uint32_t type, uint32_t flags);
 
+struct nftnl_expr;
+void nftnl_set_elem_add_expr(struct nftnl_set_elem *e, struct nftnl_expr *expr);
+int nftnl_set_elem_expr_foreach(struct nftnl_set_elem *e,
+				int (*cb)(struct nftnl_expr *e, void *data),
+				void *data);
+
 int nftnl_set_elem_foreach(struct nftnl_set *s, int (*cb)(struct nftnl_set_elem *e, void *data), void *data);
 
 struct nftnl_set_elems_iter;
diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index e4cdf78f25e2..5cf3faf4b66f 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -367,6 +367,7 @@ enum nft_set_attributes {
 	NFTA_SET_OBJ_TYPE,
 	NFTA_SET_HANDLE,
 	NFTA_SET_EXPR,
+	NFTA_SET_EXPRESSIONS,
 	__NFTA_SET_MAX
 };
 #define NFTA_SET_MAX		(__NFTA_SET_MAX - 1)
@@ -405,6 +406,7 @@ enum nft_set_elem_attributes {
 	NFTA_SET_ELEM_PAD,
 	NFTA_SET_ELEM_OBJREF,
 	NFTA_SET_ELEM_KEY_END,
+	NFTA_SET_ELEM_EXPRESSIONS,
 	__NFTA_SET_ELEM_MAX
 };
 #define NFTA_SET_ELEM_MAX	(__NFTA_SET_ELEM_MAX - 1)
@@ -712,6 +714,7 @@ enum nft_dynset_attributes {
 	NFTA_DYNSET_EXPR,
 	NFTA_DYNSET_PAD,
 	NFTA_DYNSET_FLAGS,
+	NFTA_DYNSET_EXPRESSIONS,
 	__NFTA_DYNSET_MAX,
 };
 #define NFTA_DYNSET_MAX		(__NFTA_DYNSET_MAX - 1)
diff --git a/include/set_elem.h b/include/set_elem.h
index 52f185aa11be..9239557469fe 100644
--- a/include/set_elem.h
+++ b/include/set_elem.h
@@ -10,7 +10,7 @@ struct nftnl_set_elem {
 	union nftnl_data_reg	key;
 	union nftnl_data_reg	key_end;
 	union nftnl_data_reg	data;
-	struct nftnl_expr	*expr;
+	struct list_head	expr_list;
 	uint64_t		timeout;
 	uint64_t		expiration;
 	const char		*objref;
diff --git a/src/libnftnl.map b/src/libnftnl.map
index 2d35ace0355b..ce1c0820de2d 100644
--- a/src/libnftnl.map
+++ b/src/libnftnl.map
@@ -374,3 +374,8 @@ LIBNFTNL_15 {
   nftnl_expr_build_payload;
   nftnl_rule_del_expr;
 } LIBNFTNL_14;
+
+LIBNFTNL_16 {
+  nftnl_set_elem_add_expr;
+  nftnl_set_elem_expr_foreach;
+} LIBNFTNL_15;
diff --git a/src/set_elem.c b/src/set_elem.c
index e82684bc1c53..811a724f3aca 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -36,17 +36,21 @@ struct nftnl_set_elem *nftnl_set_elem_alloc(void)
 	if (s == NULL)
 		return NULL;
 
+	INIT_LIST_HEAD(&s->expr_list);
+
 	return s;
 }
 
 EXPORT_SYMBOL(nftnl_set_elem_free);
 void nftnl_set_elem_free(struct nftnl_set_elem *s)
 {
+	struct nftnl_expr *e, *tmp;
+
 	if (s->flags & (1 << NFTNL_SET_ELEM_CHAIN))
 		xfree(s->data.chain);
 
-	if (s->flags & (1 << NFTNL_SET_ELEM_EXPR))
-		nftnl_expr_free(s->expr);
+	list_for_each_entry_safe(e, tmp, &s->expr_list, head)
+		nftnl_expr_free(e);
 
 	if (s->flags & (1 << NFTNL_SET_ELEM_USERDATA))
 		xfree(s->user.data);
@@ -66,6 +70,8 @@ bool nftnl_set_elem_is_set(const struct nftnl_set_elem *s, uint16_t attr)
 EXPORT_SYMBOL(nftnl_set_elem_unset);
 void nftnl_set_elem_unset(struct nftnl_set_elem *s, uint16_t attr)
 {
+	struct nftnl_expr *expr, *tmp;
+
 	if (!(s->flags & (1 << attr)))
 		return;
 
@@ -85,7 +91,9 @@ void nftnl_set_elem_unset(struct nftnl_set_elem *s, uint16_t attr)
 		xfree(s->user.data);
 		break;
 	case NFTNL_SET_ELEM_EXPR:
-		nftnl_expr_free(s->expr);
+	case NFTNL_SET_ELEM_EXPRESSIONS:
+		list_for_each_entry_safe(expr, tmp, &s->expr_list, head)
+			nftnl_expr_free(expr);
 		break;
 	case NFTNL_SET_ELEM_OBJREF:
 		xfree(s->objref);
@@ -108,6 +116,8 @@ EXPORT_SYMBOL(nftnl_set_elem_set);
 int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 		       const void *data, uint32_t data_len)
 {
+	struct nftnl_expr *expr, *tmp;
+
 	nftnl_assert_attr_exists(attr, NFTNL_SET_ELEM_MAX);
 	nftnl_assert_validate(data, nftnl_set_elem_validate, attr, data_len);
 
@@ -163,10 +173,11 @@ int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 			return -1;
 		break;
 	case NFTNL_SET_ELEM_EXPR:
-		if (s->flags & (1 << NFTNL_SET_ELEM_EXPR))
-			nftnl_expr_free(s->expr);
+		list_for_each_entry_safe(expr, tmp, &s->expr_list, head)
+			nftnl_expr_free(expr);
 
-		s->expr = (void *)data;
+		expr = (void *)data;
+		list_add(&expr->head, &s->expr_list);
 		break;
 	}
 	s->flags |= (1 << attr);
@@ -194,6 +205,8 @@ int nftnl_set_elem_set_str(struct nftnl_set_elem *s, uint16_t attr, const char *
 EXPORT_SYMBOL(nftnl_set_elem_get);
 const void *nftnl_set_elem_get(struct nftnl_set_elem *s, uint16_t attr, uint32_t *data_len)
 {
+	struct nftnl_expr *expr;
+
 	if (!(s->flags & (1 << attr)))
 		return NULL;
 
@@ -226,7 +239,9 @@ const void *nftnl_set_elem_get(struct nftnl_set_elem *s, uint16_t attr, uint32_t
 		*data_len = s->user.len;
 		return s->user.data;
 	case NFTNL_SET_ELEM_EXPR:
-		return s->expr;
+		list_for_each_entry(expr, &s->expr_list, head)
+			break;
+		return expr;
 	case NFTNL_SET_ELEM_OBJREF:
 		*data_len = strlen(s->objref) + 1;
 		return s->objref;
@@ -288,6 +303,9 @@ err:
 void nftnl_set_elem_nlmsg_build_payload(struct nlmsghdr *nlh,
 				      struct nftnl_set_elem *e)
 {
+	struct nftnl_expr *expr;
+	int num_exprs = 0;
+
 	if (e->flags & (1 << NFTNL_SET_ELEM_FLAGS))
 		mnl_attr_put_u32(nlh, NFTA_SET_ELEM_FLAGS, htonl(e->set_elem_flags));
 	if (e->flags & (1 << NFTNL_SET_ELEM_TIMEOUT))
@@ -332,12 +350,30 @@ void nftnl_set_elem_nlmsg_build_payload(struct nlmsghdr *nlh,
 		mnl_attr_put(nlh, NFTA_SET_ELEM_USERDATA, e->user.len, e->user.data);
 	if (e->flags & (1 << NFTNL_SET_ELEM_OBJREF))
 		mnl_attr_put_strz(nlh, NFTA_SET_ELEM_OBJREF, e->objref);
-	if (e->flags & (1 << NFTNL_SET_ELEM_EXPR)) {
-		struct nlattr *nest1;
 
-		nest1 = mnl_attr_nest_start(nlh, NFTA_SET_ELEM_EXPR);
-		nftnl_expr_build_payload(nlh, e->expr);
-		mnl_attr_nest_end(nlh, nest1);
+	if (!list_empty(&e->expr_list)) {
+		list_for_each_entry(expr, &e->expr_list, head)
+			num_exprs++;
+
+		if (num_exprs == 1) {
+			struct nlattr *nest1;
+
+			nest1 = mnl_attr_nest_start(nlh, NFTA_SET_ELEM_EXPR);
+			list_for_each_entry(expr, &e->expr_list, head)
+				nftnl_expr_build_payload(nlh, expr);
+
+			mnl_attr_nest_end(nlh, nest1);
+		} else if (num_exprs > 1) {
+			struct nlattr *nest1, *nest2;
+
+			nest1 = mnl_attr_nest_start(nlh, NFTA_SET_ELEM_EXPRESSIONS);
+			list_for_each_entry(expr, &e->expr_list, head) {
+				nest2 = mnl_attr_nest_start(nlh, NFTA_LIST_ELEM);
+				nftnl_expr_build_payload(nlh, expr);
+				mnl_attr_nest_end(nlh, nest2);
+			}
+			mnl_attr_nest_end(nlh, nest1);
+		}
 	}
 }
 
@@ -383,6 +419,28 @@ void nftnl_set_elems_nlmsg_build_payload(struct nlmsghdr *nlh, struct nftnl_set
 	mnl_attr_nest_end(nlh, nest1);
 }
 
+EXPORT_SYMBOL(nftnl_set_elem_add_expr);
+void nftnl_set_elem_add_expr(struct nftnl_set_elem *e, struct nftnl_expr *expr)
+{
+	list_add_tail(&expr->head, &e->expr_list);
+}
+
+EXPORT_SYMBOL(nftnl_set_elem_expr_foreach);
+int nftnl_set_elem_expr_foreach(struct nftnl_set_elem *e,
+				int (*cb)(struct nftnl_expr *e, void *data),
+				void *data)
+{
+       struct nftnl_expr *cur, *tmp;
+       int ret;
+
+	list_for_each_entry_safe(cur, tmp, &e->expr_list, head) {
+		ret = cb(cur, data);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
 static int nftnl_set_elem_parse_attr_cb(const struct nlattr *attr, void *data)
 {
 	const struct nlattr **tb = data;
@@ -405,6 +463,7 @@ static int nftnl_set_elem_parse_attr_cb(const struct nlattr *attr, void *data)
 	case NFTA_SET_ELEM_KEY_END:
 	case NFTA_SET_ELEM_DATA:
 	case NFTA_SET_ELEM_EXPR:
+	case NFTA_SET_ELEM_EXPRESSIONS:
 		if (mnl_attr_validate(attr, MNL_TYPE_NESTED) < 0)
 			abi_breakage();
 		break;
@@ -476,12 +535,32 @@ static int nftnl_set_elems_parse2(struct nftnl_set *s, const struct nlattr *nest
 		}
         }
 	if (tb[NFTA_SET_ELEM_EXPR]) {
-		e->expr = nftnl_expr_parse(tb[NFTA_SET_ELEM_EXPR]);
-		if (e->expr == NULL) {
+		struct nftnl_expr *expr;
+
+		expr = nftnl_expr_parse(tb[NFTA_SET_ELEM_EXPR]);
+		if (expr == NULL) {
 			ret = -1;
 			goto out_set_elem;
 		}
+		list_add_tail(&expr->head, &e->expr_list);
 		e->flags |= (1 << NFTNL_SET_ELEM_EXPR);
+	} else if (tb[NFTA_SET_ELEM_EXPRESSIONS]) {
+		struct nftnl_expr *expr;
+		struct nlattr *attr;
+
+		mnl_attr_for_each_nested(attr, tb[NFTA_SET_ELEM_EXPRESSIONS]) {
+			if (mnl_attr_get_type(attr) != NFTA_LIST_ELEM) {
+				ret = -1;
+				goto out_set_elem;
+			}
+			expr = nftnl_expr_parse(attr);
+			if (expr == NULL) {
+				ret = -1;
+				goto out_set_elem;
+			}
+			list_add_tail(&expr->head, &e->expr_list);
+		}
+		e->flags |= (1 << NFTNL_SET_ELEM_EXPRESSIONS);
 	}
 	if (tb[NFTA_SET_ELEM_USERDATA]) {
 		const void *udata =
@@ -494,7 +573,7 @@ static int nftnl_set_elems_parse2(struct nftnl_set *s, const struct nlattr *nest
 		e->user.data = malloc(e->user.len);
 		if (e->user.data == NULL) {
 			ret = -1;
-			goto out_expr;
+			goto out_set_elem;
 		}
 		memcpy(e->user.data, udata, e->user.len);
 		e->flags |= (1 << NFTNL_RULE_USERDATA);
@@ -512,8 +591,6 @@ static int nftnl_set_elems_parse2(struct nftnl_set *s, const struct nlattr *nest
 	list_add_tail(&e->head, &s->element_list);
 
 	return 0;
-out_expr:
-	nftnl_expr_free(e->expr);
 out_set_elem:
 	nftnl_set_elem_free(e);
 	return ret;
-- 
2.20.1

