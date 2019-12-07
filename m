Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68DC115FBA
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 23:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfLGWv4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Dec 2019 17:51:56 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52845 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbfLGWv4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:51:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575759114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUoqabyPTcKxXfdxWy0jDzLGbGHivMM7pVGebaWlEtQ=;
        b=LYaHp5hm/eAR4kp+huzFncYEz6ji8Vz3qUNTqwJ7XYMnwTcxCxqDHUVIt4cjdgX4857IPN
        x0iE7fXS5o5FDVClIXE5WNm5+EE9T63puu3dWh+b21R3N4MdYR7djYf6kfQW29xbFEzHre
        idceOXzWB5Ll/VT4rnV2+AoiIITu30Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-133-wImlMClvMamKE_k1nz6djg-1; Sat, 07 Dec 2019 17:51:53 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 808011005512;
        Sat,  7 Dec 2019 22:51:52 +0000 (UTC)
Received: from elisabeth (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2ED08A4B8F;
        Sat,  7 Dec 2019 22:51:50 +0000 (UTC)
Date:   Sat, 7 Dec 2019 23:51:38 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH,nf-next RFC 1/2] netfilter: nf_tables: add
 nft_setelem_parse_key()
Message-ID: <20191207235138.393d306c@elisabeth>
In-Reply-To: <20191206194517.gg6e34uekje647sn@salvia>
References: <20191202131407.500999-1-pablo@netfilter.org>
 <20191202131407.500999-2-pablo@netfilter.org>
 <20191205234350.3dd81c1c@elisabeth>
 <20191206194517.gg6e34uekje647sn@salvia>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: wImlMClvMamKE_k1nz6djg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 6 Dec 2019 20:45:17 +0100
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Thu, Dec 05, 2019 at 11:43:50PM +0100, Stefano Brivio wrote:
> > Hi Pablo,
> > 
> > Just two nits:
> > 
> > On Mon,  2 Dec 2019 14:14:06 +0100
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >   
> > > Add helper function to parse the set element key netlink attribute.
> > > 
> > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > ---
> > >  net/netfilter/nf_tables_api.c | 56 ++++++++++++++++++++++++-------------------
> > >  1 file changed, 32 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > > index 0db2784fee9a..13e291fac26f 100644
> > > --- a/net/netfilter/nf_tables_api.c
> > > +++ b/net/netfilter/nf_tables_api.c
> > > @@ -4490,11 +4490,31 @@ static int nft_setelem_parse_flags(const struct nft_set *set,
> > >  	return 0;
> > >  }
> > >  
> > > +static int nft_setelem_parse_key(struct nft_ctx *ctx, struct nft_set *set,
> > > +				 struct nft_data *key, struct nlattr *attr)
> > > +{
> > > +	struct nft_data_desc desc;
> > > +	int err;
> > > +
> > > +	err = nft_data_init(ctx, key, sizeof(*key), &desc, attr);
> > > +	if (err < 0)
> > > +		goto err1;
> > > +
> > > +	err = -EINVAL;
> > > +	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
> > > +		goto err2;
> > > +
> > > +	return 0;
> > > +err2:
> > > +	nft_data_release(key, desc.type);
> > > +err1:
> > > +	return err;
> > > +}
> > > +
> > >  static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  			    const struct nlattr *attr)
> > >  {
> > >  	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
> > > -	struct nft_data_desc desc;
> > >  	struct nft_set_elem elem;
> > >  	struct sk_buff *skb;
> > >  	uint32_t flags = 0;
> > > @@ -4513,15 +4533,11 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > -	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
> > > -			    nla[NFTA_SET_ELEM_KEY]);
> > > +	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
> > > +				    nla[NFTA_SET_ELEM_KEY]);
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > -	err = -EINVAL;
> > > -	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
> > > -		return err;
> > > -
> > >  	priv = set->ops->get(ctx->net, set, &elem, flags);
> > >  	if (IS_ERR(priv))
> > >  		return PTR_ERR(priv);
> > > @@ -4720,13 +4736,13 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  {
> > >  	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
> > >  	u8 genmask = nft_genmask_next(ctx->net);
> > > -	struct nft_data_desc d1, d2;
> > >  	struct nft_set_ext_tmpl tmpl;
> > >  	struct nft_set_ext *ext, *ext2;
> > >  	struct nft_set_elem elem;
> > >  	struct nft_set_binding *binding;
> > >  	struct nft_object *obj = NULL;
> > >  	struct nft_userdata *udata;
> > > +	struct nft_data_desc d2;  
> > 
> > At this point, this could simply be desc, or data_desc.
> >   
> > >  	struct nft_data data;
> > >  	enum nft_registers dreg;
> > >  	struct nft_trans *trans;
> > > @@ -4792,15 +4808,12 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  			return err;
> > >  	}
> > >  
> > > -	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &d1,
> > > -			    nla[NFTA_SET_ELEM_KEY]);
> > > +	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
> > > +				    nla[NFTA_SET_ELEM_KEY]);
> > >  	if (err < 0)
> > >  		goto err1;
> > > -	err = -EINVAL;
> > > -	if (d1.type != NFT_DATA_VALUE || d1.len != set->klen)
> > > -		goto err2;
> > >  
> > > -	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, d1.len);
> > > +	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
> > >  	if (timeout > 0) {
> > >  		nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
> > >  		if (timeout != set->timeout)
> > > @@ -4942,7 +4955,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	if (nla[NFTA_SET_ELEM_DATA] != NULL)
> > >  		nft_data_release(&data, d2.type);
> > >  err2:
> > > -	nft_data_release(&elem.key.val, d1.type);
> > > +	nft_data_release(&elem.key.val, NFT_DATA_VALUE);
> > >  err1:
> > >  	return err;
> > >  }
> > > @@ -5038,7 +5051,6 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
> > >  {
> > >  	struct nlattr *nla[NFTA_SET_ELEM_MAX + 1];
> > >  	struct nft_set_ext_tmpl tmpl;
> > > -	struct nft_data_desc desc;
> > >  	struct nft_set_elem elem;
> > >  	struct nft_set_ext *ext;
> > >  	struct nft_trans *trans;
> > > @@ -5063,16 +5075,12 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	if (flags != 0)
> > >  		nft_set_ext_add(&tmpl, NFT_SET_EXT_FLAGS);
> > >  
> > > -	err = nft_data_init(ctx, &elem.key.val, sizeof(elem.key), &desc,
> > > -			    nla[NFTA_SET_ELEM_KEY]);
> > > +	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
> > > +				    nla[NFTA_SET_ELEM_KEY]);
> > >  	if (err < 0)
> > >  		goto err1;
> > >  
> > > -	err = -EINVAL;
> > > -	if (desc.type != NFT_DATA_VALUE || desc.len != set->klen)
> > > -		goto err2;
> > > -
> > > -	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, desc.len);
> > > +	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
> > >  
> > >  	err = -ENOMEM;
> > >  	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, NULL, 0,
> > > @@ -5109,7 +5117,7 @@ static int nft_del_setelem(struct nft_ctx *ctx, struct nft_set *set,
> > >  err3:
> > >  	kfree(elem.priv);
> > >  err2:
> > > -	nft_data_release(&elem.key.val, desc.type);
> > > +	nft_data_release(&elem.key.val, NFT_DATA_VALUE);  
> > 
> > I'm not sure if this can actually happen, but in
> > nft_setelem_parse_key() you are checking that the type is
> > NFT_DATA_VALUE, and returning error if it's not.  
> 
> Exactly.
> 
> > If the type is not NFT_DATA_VALUE, I guess we shouldn't pass
> > NFT_DATA_VALUE to nft_data_release() here.  
> 
> The new nft_setelem_parse_key() function makes sure that the key is
> NFT_DATA_VALUE, otherwise bails out and calls nft_data_release() with
> desc.type.
> 
> Then, moving forward in nft_add_set_elem() after the
> nft_setelem_parse_key(), if an error occurs, nft_data_release() can be
> called with NFT_DATA_VALUE, because that was already validated by
> nft_setelem_parse_key().
> 
> > Maybe nft_setelem_parse_key() could clean up after itself on error.  
> 
> It's doing so already, right? See err2: label.

Right you are, my bad, I mixed up err2: and err1: in nft_set_delelem()
and then forgot about err2: in nft_setelem_parse_key().

Well, on the other hand, 'return err;" and 'goto fail_elem;" would have
been easier to follow, but maybe it's just my taste. :)

-- 
Stefano

