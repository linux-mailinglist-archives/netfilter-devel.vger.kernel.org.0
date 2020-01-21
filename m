Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E8A2144827
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jan 2020 00:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgAUXSO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jan 2020 18:18:14 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:29932 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726605AbgAUXSO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jan 2020 18:18:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579648692;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PV+ThQb7tH2Ya0OchSLV2KJQuqpQpVMfeIf0KqiZRes=;
        b=g2TRwUN+EcxVZL3CGpE4sU0h7IcPWaBrEg+3F5kgMoxKXgaqR8kJg3lFHPBHxdEmtQUvsh
        ANExnljWu3w8p6ckNT1jtP12B3KM/lpCzPAp0hDzPbTdeW+RYUnCkyhP75w+ah1wYdu1SV
        1Mha4/Lj+IwCMGJeh3hnh05AkSau7HM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-h1ik41--PS-efOZWF7-OAA-1; Tue, 21 Jan 2020 18:18:07 -0500
X-MC-Unique: h1ik41--PS-efOZWF7-OAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41B331005514;
        Tue, 21 Jan 2020 23:18:06 +0000 (UTC)
Received: from epycfail.redhat.com (ovpn-112-49.ams2.redhat.com [10.36.112.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BFCD05C1BB;
        Tue, 21 Jan 2020 23:18:03 +0000 (UTC)
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>,
        =?UTF-8?q?Kadlecsik=20J=C3=B3zsef?= <kadlec@blackhole.kfki.hu>,
        Eric Garver <eric@garver.life>, Phil Sutter <phil@nwl.cc>
Subject: [PATCH nf-next v4 1/9] netfilter: nf_tables: add nft_setelem_parse_key()
Date:   Wed, 22 Jan 2020 00:17:51 +0100
Message-Id: <cd16c6687bdf9616110f769b83933988a7078f0f.1579647351.git.sbrivio@redhat.com>
In-Reply-To: <cover.1579647351.git.sbrivio@redhat.com>
References: <cover.1579647351.git.sbrivio@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Content-Transfer-Encoding: quoted-printable
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Pablo Neira Ayuso <pablo@netfilter.org>

Add helper function to parse the set element key netlink attribute.

v4: No changes
v3: New patch

[sbrivio: refactor error paths and labels; use NFT_DATA_VALUE_MAXLEN
  instead of sizeof(*key) in helper, value can be longer than that;
  rebase]
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 91 +++++++++++++++++------------------
 1 file changed, 45 insertions(+), 46 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.=
c
index 43f05b3acd60..0628b9ad7aa4 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -4490,11 +4490,28 @@ static int nft_setelem_parse_flags(const struct n=
ft_set *set,
 	return 0;
 }
=20
+static int nft_setelem_parse_key(struct nft_ctx *ctx, struct nft_set *se=
t,
+				 struct nft_data *key, struct nlattr *attr)
+{
+	struct nft_data_desc desc;
+	int err;
+
+	err =3D nft_data_init(ctx, key, NFT_DATA_VALUE_MAXLEN, &desc, attr);
+	if (err < 0)
+		return err;
+
+	if (desc.type !=3D NFT_DATA_VALUE || desc.len !=3D set->klen) {
+		nft_data_release(key, desc.type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
 			    const struct nlattr *attr)
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
-	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct sk_buff *skb;
 	uint32_t flags =3D 0;
@@ -4513,17 +4530,11 @@ static int nft_get_set_elem(struct nft_ctx *ctx, =
struct nft_set *set,
 	if (err < 0)
 		return err;
=20
-	err =3D nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err =3D nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
 		return err;
=20
-	err =3D -EINVAL;
-	if (desc.type !=3D NFT_DATA_VALUE || desc.len !=3D set->klen) {
-		nft_data_release(&elem.key.val, desc.type);
-		return err;
-	}
-
 	priv =3D set->ops->get(ctx->net, set, &elem, flags);
 	if (IS_ERR(priv))
 		return PTR_ERR(priv);
@@ -4722,13 +4733,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, =
struct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	u8 genmask =3D nft_genmask_next(ctx->net);
-	struct nft_data_desc d1, d2;
 	struct nft_set_ext_tmpl tmpl;
 	struct nft_set_ext *ext, *ext2;
 	struct nft_set_elem elem;
 	struct nft_set_binding *binding;
 	struct nft_object *obj =3D NULL;
 	struct nft_userdata *udata;
+	struct nft_data_desc desc;
 	struct nft_data data;
 	enum nft_registers dreg;
 	struct nft_trans *trans;
@@ -4794,15 +4805,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, =
struct nft_set *set,
 			return err;
 	}
=20
-	err =3D nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &d1,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err =3D nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
 		goto err1;
-	err =3D -EINVAL;
-	if (d1.type !=3D NFT_DATA_VALUE || d1.len !=3D set->klen)
-		goto err2;
=20
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, d1.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
 	if (timeout > 0) {
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
 		if (timeout !=3D set->timeout)
@@ -4825,13 +4833,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, =
struct nft_set *set,
 	}
=20
 	if (nla[NFTA_SET_ELEM_DATA] !=3D NULL) {
-		err =3D nft_data_init(ctx, &data, sizeof(data), &d2,
+		err =3D nft_data_init(ctx, &data, sizeof(data), &desc,
 				    nla[NFTA_SET_ELEM_DATA]);
 		if (err < 0)
 			goto err2;
=20
 		err =3D -EINVAL;
-		if (set->dtype !=3D NFT_DATA_VERDICT && d2.len !=3D set->dlen)
+		if (set->dtype !=3D NFT_DATA_VERDICT && desc.len !=3D set->dlen)
 			goto err3;
=20
 		dreg =3D nft_type_to_reg(set->dtype);
@@ -4848,18 +4856,18 @@ static int nft_add_set_elem(struct nft_ctx *ctx, =
struct nft_set *set,
=20
 			err =3D nft_validate_register_store(&bind_ctx, dreg,
 							  &data,
-							  d2.type, d2.len);
+							  desc.type, desc.len);
 			if (err < 0)
 				goto err3;
=20
-			if (d2.type =3D=3D NFT_DATA_VERDICT &&
+			if (desc.type =3D=3D NFT_DATA_VERDICT &&
 			    (data.verdict.code =3D=3D NFT_GOTO ||
 			     data.verdict.code =3D=3D NFT_JUMP))
 				nft_validate_state_update(ctx->net,
 							  NFT_VALIDATE_NEED);
 		}
=20
-		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, d2.len);
+		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_DATA, desc.len);
 	}
=20
 	/* The full maximum length of userdata can exceed the maximum
@@ -4942,9 +4950,9 @@ static int nft_add_set_elem(struct nft_ctx *ctx, st=
ruct nft_set *set,
 	kfree(elem.priv);
 err3:
 	if (nla[NFTA_SET_ELEM_DATA] !=3D NULL)
-		nft_data_release(&data, d2.type);
+		nft_data_release(&data, desc.type);
 err2:
-	nft_data_release(&elem.key.val, d1.type);
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 err1:
 	return err;
 }
@@ -5040,7 +5048,6 @@ static int nft_del_setelem(struct nft_ctx *ctx, str=
uct nft_set *set,
 {
 	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
 	struct nft_set_ext_tmpl tmpl;
-	struct nft_data_desc desc;
 	struct nft_set_elem elem;
 	struct nft_set_ext *ext;
 	struct nft_trans *trans;
@@ -5051,11 +5058,10 @@ static int nft_del_setelem(struct nft_ctx *ctx, s=
truct nft_set *set,
 	err =3D nla_parse_nested_deprecated(nla, NFTA_SET_ELEM_MAX, attr,
 					  nft_set_elem_policy, NULL);
 	if (err < 0)
-		goto err1;
+		return err;
=20
-	err =3D -EINVAL;
 	if (nla[NFTA_SET_ELEM_KEY] =3D=3D NULL)
-		goto err1;
+		return -EINVAL;
=20
 	nft_set_ext_prepare(&tmpl);
=20
@@ -5065,37 +5071,31 @@ static int nft_del_setelem(struct nft_ctx *ctx, s=
truct nft_set *set,
 	if (flags !=3D 0)
 		nft_set_ext_add(&tmpl, NFT_SET_EXT_FLAGS);
=20
-	err =3D nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
-			    nla[NFTA_SET_ELEM_KEY]);
+	err =3D nft_setelem_parse_key(ctx, set, &elem.key.val,
+				    nla[NFTA_SET_ELEM_KEY]);
 	if (err < 0)
-		goto err1;
-
-	err =3D -EINVAL;
-	if (desc.type !=3D NFT_DATA_VALUE || desc.len !=3D set->klen)
-		goto err2;
+		return err;
=20
-	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, desc.len);
+	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
=20
 	err =3D -ENOMEM;
 	elem.priv =3D nft_set_elem_init(set, &tmpl, elem.key.val.data, NULL, 0,
 				      0, GFP_KERNEL);
 	if (elem.priv =3D=3D NULL)
-		goto err2;
+		goto fail_elem;
=20
 	ext =3D nft_set_elem_ext(set, elem.priv);
 	if (flags)
 		*nft_set_ext_flags(ext) =3D flags;
=20
 	trans =3D nft_trans_elem_alloc(ctx, NFT_MSG_DELSETELEM, set);
-	if (trans =3D=3D NULL) {
-		err =3D -ENOMEM;
-		goto err3;
-	}
+	if (trans =3D=3D NULL)
+		goto fail_trans;
=20
 	priv =3D set->ops->deactivate(ctx->net, set, &elem);
 	if (priv =3D=3D NULL) {
 		err =3D -ENOENT;
-		goto err4;
+		goto fail_ops;
 	}
 	kfree(elem.priv);
 	elem.priv =3D priv;
@@ -5106,13 +5106,12 @@ static int nft_del_setelem(struct nft_ctx *ctx, s=
truct nft_set *set,
 	list_add_tail(&trans->list, &ctx->net->nft.commit_list);
 	return 0;
=20
-err4:
+fail_ops:
 	kfree(trans);
-err3:
+fail_trans:
 	kfree(elem.priv);
-err2:
-	nft_data_release(&elem.key.val, desc.type);
-err1:
+fail_elem:
+	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
 	return err;
 }
=20
--=20
2.24.1

