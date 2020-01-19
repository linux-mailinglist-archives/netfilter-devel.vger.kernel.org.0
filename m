Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5D88141E42
	for <lists+netfilter-devel@lfdr.de>; Sun, 19 Jan 2020 14:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgASNfO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 19 Jan 2020 08:35:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31341 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726816AbgASNfO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579440912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSsV4kzncHwxP2Z1ewhjdxSZxXF/1/fH+SlrZj15yQA=;
        b=dJ+Ti5z8Jsj9gey8QwxprrwnNIS7iQMBoF4I9JHk+qi7BuZr1fkKxGFnb6QLqBvaSkC2KF
        yPNqHDyJ2v1akB5zgakfpgzgUPYKzd5nXqZWurlz9nTE1COgKnOQwCkEsm/K5doBnK6mDc
        eajKYNMDCEA0PDqfMfGdBEhdZvIzYAE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-e6Nh_wDJNA25ejQCawmYlw-1; Sun, 19 Jan 2020 08:35:09 -0500
X-MC-Unique: e6Nh_wDJNA25ejQCawmYlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18896107ACC7;
        Sun, 19 Jan 2020 13:35:08 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-112-51.ams2.redhat.com [10.36.112.51])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CF59128D19;
        Sun, 19 Jan 2020 13:35:05 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nft v3 1/3] src: Add support for NFTNL_SET_DESC_CONCAT
Date:   Sun, 19 Jan 2020 14:34:54 +0100
Message-Id: <99924cfb6e472ee5da9d29e6ee23949cd361c729.1579434179.git.sbrivio@redhat.com>
In-Reply-To: <cover.1579434179.git.sbrivio@redhat.com>
References: <cover.1579434179.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

To support arbitrary range concatenations, the kernel needs to know
how long each field in the concatenation is. The new libnftnl
NFTNL_SET_DESC_CONCAT set attribute describes this as an array of
lengths, in bytes, of concatenated fields.

While evaluating concatenated expressions, export the datatype size
into the new field_len array, and hand the data over via libnftnl.

Similarly, when data is passed back from libnftnl, parse it into
the set description.

When set data is cloned, we now need to copy the additional fields
in set_clone(), too.

This change depends on the libnftnl patch with title:
  set: Add support for NFTA_SET_DESC_CONCAT attributes

v3: Rework to use set description data instead of a stand-alone
    attribute
v2: No changes

Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
---
 include/expression.h |  2 ++
 include/rule.h       |  6 +++++-
 src/evaluate.c       | 14 +++++++++++---
 src/mnl.c            |  7 +++++++
 src/netlink.c        | 11 +++++++++++
 src/rule.c           |  2 +-
 6 files changed, 37 insertions(+), 5 deletions(-)

diff --git a/include/expression.h b/include/expression.h
index b3e79c490b1a..6196be58c2a6 100644
--- a/include/expression.h
+++ b/include/expression.h
@@ -261,6 +261,8 @@ struct expr {
 			struct list_head	expressions;
 			unsigned int		size;
 			uint32_t		set_flags;
+			uint8_t			field_len[NFT_REG32_COUNT];
+			uint8_t			field_count;
 		};
 		struct {
 			/* EXPR_SET_REF */
diff --git a/include/rule.h b/include/rule.h
index d5b31765612e..a7f106f715cf 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -289,7 +289,9 @@ extern struct rule *rule_lookup_by_index(const struct=
 chain *chain,
  * @rg_cache:	cached range element (left)
  * @policy:	set mechanism policy
  * @automerge:	merge adjacents and overlapping elements, if possible
- * @desc:	set mechanism desc
+ * @desc.size:		count of set elements
+ * @desc.field_len:	length of single concatenated fields, bytes
+ * @desc.field_count:	count of concatenated fields
  */
 struct set {
 	struct list_head	list;
@@ -310,6 +312,8 @@ struct set {
 	bool			key_typeof_valid;
 	struct {
 		uint32_t	size;
+		uint8_t		field_len[NFT_REG32_COUNT];
+		uint8_t		field_count;
 	} desc;
 };
=20
diff --git a/src/evaluate.c b/src/evaluate.c
index e7881543d2de..52b8a154d24d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -1217,6 +1217,8 @@ static int expr_evaluate_concat(struct eval_ctx *ct=
x, struct expr **expr,
 	struct expr *i, *next;
=20
 	list_for_each_entry_safe(i, next, &(*expr)->expressions, list) {
+		unsigned dsize_bytes;
+
 		if (expr_is_constant(*expr) && dtype && off =3D=3D 0)
 			return expr_binary_error(ctx->msgs, i, *expr,
 						 "unexpected concat component, "
@@ -1241,6 +1243,9 @@ static int expr_evaluate_concat(struct eval_ctx *ct=
x, struct expr **expr,
 						 i->dtype->name);
=20
 		ntype =3D concat_subtype_add(ntype, i->dtype->type);
+
+		dsize_bytes =3D div_round_up(i->dtype->size, BITS_PER_BYTE);
+		(*expr)->field_len[(*expr)->field_count++] =3D dsize_bytes;
 	}
=20
 	(*expr)->flags |=3D flags;
@@ -3346,9 +3351,12 @@ static int set_evaluate(struct eval_ctx *ctx, stru=
ct set *set)
 			return set_key_data_error(ctx, set,
 						  set->key->dtype, type);
 	}
-	if (set->flags & NFT_SET_INTERVAL &&
-	    set->key->etype =3D=3D EXPR_CONCAT)
-		return set_error(ctx, set, "concatenated types not supported in interv=
al sets");
+
+	if (set->flags & NFT_SET_INTERVAL && set->key->etype =3D=3D EXPR_CONCAT=
) {
+		memcpy(&set->desc.field_len, &set->key->field_len,
+		       sizeof(set->desc.field_len));
+		set->desc.field_count =3D set->key->field_count;
+	}
=20
 	if (set_is_datamap(set->flags)) {
 		if (set->data =3D=3D NULL)
diff --git a/src/mnl.c b/src/mnl.c
index d5bdff293c61..340380ba6fef 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -905,6 +905,13 @@ int mnl_nft_set_add(struct netlink_ctx *ctx, const s=
truct cmd *cmd,
 	if (set->data)
 		set_key_expression(ctx, set->data, set->flags, udbuf, NFTNL_UDATA_SET_=
DATA_TYPEOF);
=20
+	if (set->desc.field_len[0]) {
+		nftnl_set_set_data(nls, NFTNL_SET_DESC_CONCAT,
+				   set->desc.field_len,
+				   set->desc.field_count *
+				   sizeof(set->desc.field_len[0]));
+	}
+
 	nftnl_set_set_data(nls, NFTNL_SET_USERDATA, nftnl_udata_buf_data(udbuf)=
,
 			   nftnl_udata_buf_len(udbuf));
 	nftnl_udata_buf_free(udbuf);
diff --git a/src/netlink.c b/src/netlink.c
index a9ccebaf8efd..791943b4d926 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -773,6 +773,17 @@ struct set *netlink_delinearize_set(struct netlink_c=
tx *ctx,
 	if (nftnl_set_is_set(nls, NFTNL_SET_DESC_SIZE))
 		set->desc.size =3D nftnl_set_get_u32(nls, NFTNL_SET_DESC_SIZE);
=20
+	if (nftnl_set_is_set(nls, NFTNL_SET_DESC_CONCAT)) {
+		uint32_t len =3D NFT_REG32_COUNT;
+		const uint8_t *data;
+
+		data =3D nftnl_set_get_data(nls, NFTNL_SET_DESC_CONCAT, &len);
+		if (data) {
+			memcpy(set->desc.field_len, data, len);
+			set->desc.field_count =3D len;
+		}
+	}
+
 	return set;
 }
=20
diff --git a/src/rule.c b/src/rule.c
index 883b07072025..4853c4f302ee 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -337,7 +337,7 @@ struct set *set_clone(const struct set *set)
 	new_set->objtype	=3D set->objtype;
 	new_set->policy		=3D set->policy;
 	new_set->automerge	=3D set->automerge;
-	new_set->desc.size	=3D set->desc.size;
+	new_set->desc		=3D set->desc;
=20
 	return new_set;
 }
--=20
2.24.1

