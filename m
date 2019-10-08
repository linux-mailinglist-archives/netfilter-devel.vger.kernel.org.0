Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28973D023A
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 22:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbfJHUiC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Oct 2019 16:38:02 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:48978 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730523AbfJHUiC (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Oct 2019 16:38:02 -0400
Received: from localhost ([::1]:33836 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iHwF6-0007l5-H8; Tue, 08 Oct 2019 22:38:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH v2] set: Export nftnl_set_list_lookup_byname()
Date:   Tue,  8 Oct 2019 22:37:51 +0200
Message-Id: <20191008203751.1529-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Rename and optimize internal function nftnl_set_lookup() for external
use. Just like with nftnl_chain_list, use a hash table for fast set name
lookups.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v1:
- Adjust LIBVERSION according to libtool documentation.
---
 Make_global.am         |  2 +-
 include/libnftnl/set.h |  2 ++
 include/set.h          |  1 +
 src/libnftnl.map       |  4 ++++
 src/set.c              | 53 +++++++++++++++++++++++++++---------------
 5 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/Make_global.am b/Make_global.am
index d0394b3700671..ea848fdabae7c 100644
--- a/Make_global.am
+++ b/Make_global.am
@@ -18,7 +18,7 @@
 # set age to 0.
 # </snippet>
 #
-LIBVERSION=12:0:1
+LIBVERSION=13:0:2
 
 AM_CPPFLAGS = ${regular_CPPFLAGS} -I${top_srcdir}/include ${LIBMNL_CFLAGS} ${LIBMXML_CFLAGS}
 AM_CFLAGS = ${regular_CFLAGS} ${GCC_FVISIBILITY_HIDDEN}
diff --git a/include/libnftnl/set.h b/include/libnftnl/set.h
index 67c54e9ae12c6..6640ad929f346 100644
--- a/include/libnftnl/set.h
+++ b/include/libnftnl/set.h
@@ -75,6 +75,8 @@ void nftnl_set_list_add(struct nftnl_set *s, struct nftnl_set_list *list);
 void nftnl_set_list_add_tail(struct nftnl_set *s, struct nftnl_set_list *list);
 void nftnl_set_list_del(struct nftnl_set *s);
 int nftnl_set_list_foreach(struct nftnl_set_list *set_list, int (*cb)(struct nftnl_set *t, void *data), void *data);
+struct nftnl_set *nftnl_set_list_lookup_byname(struct nftnl_set_list *set_list,
+					       const char *set);
 
 struct nftnl_set_list_iter;
 struct nftnl_set_list_iter *nftnl_set_list_iter_create(const struct nftnl_set_list *l);
diff --git a/include/set.h b/include/set.h
index 3bcec7c8c1b39..446acd24ca7cc 100644
--- a/include/set.h
+++ b/include/set.h
@@ -5,6 +5,7 @@
 
 struct nftnl_set {
 	struct list_head	head;
+	struct hlist_node	hnode;
 
 	uint32_t		family;
 	uint32_t		set_flags;
diff --git a/src/libnftnl.map b/src/libnftnl.map
index 3c6f8631c1e60..3ddb9468c96c3 100644
--- a/src/libnftnl.map
+++ b/src/libnftnl.map
@@ -351,3 +351,7 @@ LIBNFTNL_12 {
   nftnl_chain_list_lookup_byname;
   nftnl_rule_lookup_byindex;
 } LIBNFTNL_11;
+
+LIBNFTNL_13 {
+  nftnl_set_list_lookup_byname;
+} LIBNFTNL_12;
diff --git a/src/set.c b/src/set.c
index d1bdb165ab4b1..e6db7258cc224 100644
--- a/src/set.c
+++ b/src/set.c
@@ -715,20 +715,26 @@ void nftnl_set_elem_add(struct nftnl_set *s, struct nftnl_set_elem *elem)
 	list_add_tail(&elem->head, &s->element_list);
 }
 
+#define SET_NAME_HSIZE		512
+
 struct nftnl_set_list {
 	struct list_head list;
+	struct hlist_head name_hash[SET_NAME_HSIZE];
 };
 
 EXPORT_SYMBOL(nftnl_set_list_alloc);
 struct nftnl_set_list *nftnl_set_list_alloc(void)
 {
 	struct nftnl_set_list *list;
+	int i;
 
 	list = calloc(1, sizeof(struct nftnl_set_list));
 	if (list == NULL)
 		return NULL;
 
 	INIT_LIST_HEAD(&list->list);
+	for (i = 0; i < SET_NAME_HSIZE; i++)
+		INIT_HLIST_HEAD(&list->name_hash[i]);
 
 	return list;
 }
@@ -740,6 +746,7 @@ void nftnl_set_list_free(struct nftnl_set_list *list)
 
 	list_for_each_entry_safe(s, tmp, &list->list, head) {
 		list_del(&s->head);
+		hlist_del(&s->hnode);
 		nftnl_set_free(s);
 	}
 	xfree(list);
@@ -751,15 +758,31 @@ int nftnl_set_list_is_empty(const struct nftnl_set_list *list)
 	return list_empty(&list->list);
 }
 
+static uint32_t djb_hash(const char *key)
+{
+	uint32_t i, hash = 5381;
+
+	for (i = 0; i < strlen(key); i++)
+		hash = ((hash << 5) + hash) + key[i];
+
+	return hash;
+}
+
 EXPORT_SYMBOL(nftnl_set_list_add);
 void nftnl_set_list_add(struct nftnl_set *s, struct nftnl_set_list *list)
 {
+	int key = djb_hash(s->name) % SET_NAME_HSIZE;
+
+	hlist_add_head(&s->hnode, &list->name_hash[key]);
 	list_add(&s->head, &list->list);
 }
 
 EXPORT_SYMBOL(nftnl_set_list_add_tail);
 void nftnl_set_list_add_tail(struct nftnl_set *s, struct nftnl_set_list *list)
 {
+	int key = djb_hash(s->name) % SET_NAME_HSIZE;
+
+	hlist_add_head(&s->hnode, &list->name_hash[key]);
 	list_add_tail(&s->head, &list->list);
 }
 
@@ -767,6 +790,7 @@ EXPORT_SYMBOL(nftnl_set_list_del);
 void nftnl_set_list_del(struct nftnl_set *s)
 {
 	list_del(&s->head);
+	hlist_del(&s->hnode);
 }
 
 EXPORT_SYMBOL(nftnl_set_list_foreach);
@@ -837,28 +861,19 @@ void nftnl_set_list_iter_destroy(const struct nftnl_set_list_iter *iter)
 	xfree(iter);
 }
 
-static struct nftnl_set *nftnl_set_lookup(const char *this_set_name,
-				      struct nftnl_set_list *set_list)
+EXPORT_SYMBOL(nftnl_set_list_lookup_byname);
+struct nftnl_set *
+nftnl_set_list_lookup_byname(struct nftnl_set_list *set_list, const char *set)
 {
-	struct nftnl_set_list_iter *iter;
+	int key = djb_hash(set) % SET_NAME_HSIZE;
+	struct hlist_node *n;
 	struct nftnl_set *s;
-	const char *set_name;
-
-	iter = nftnl_set_list_iter_create(set_list);
-	if (iter == NULL)
-		return NULL;
 
-	s = nftnl_set_list_iter_cur(iter);
-	while (s != NULL) {
-		set_name  = nftnl_set_get_str(s, NFTNL_SET_NAME);
-		if (strcmp(this_set_name, set_name) == 0)
-			break;
-
-		s = nftnl_set_list_iter_next(iter);
+	hlist_for_each_entry(s, n, &set_list->name_hash[key], hnode) {
+		if (!strcmp(set, s->name))
+			return s;
 	}
-	nftnl_set_list_iter_destroy(iter);
-
-	return s;
+	return NULL;
 }
 
 int nftnl_set_lookup_id(struct nftnl_expr *e,
@@ -871,7 +886,7 @@ int nftnl_set_lookup_id(struct nftnl_expr *e,
 	if (set_name == NULL)
 		return 0;
 
-	s = nftnl_set_lookup(set_name, set_list);
+	s = nftnl_set_list_lookup_byname(set_list, set_name);
 	if (s == NULL)
 		return 0;
 
-- 
2.23.0

