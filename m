Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DEC115FBD
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Dec 2019 23:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfLGWyK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 Dec 2019 17:54:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23186 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726480AbfLGWyK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 Dec 2019 17:54:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1575759248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sq/RBSh7+DcjElAROzy9OzbtleRwGGF5HVgzBdmSOfE=;
        b=c4shX/AqxygD9TNvseYR5smkcE0WPOg8E/f+orjUbbBRsNg7OL46M8W0eASwxgNfMACSrG
        dKqydu4q3zWFrUYGeKq2s2h19WFebMkM+ZPozAsaDtAFd1C0i8KEtxCHyaoAotkajTqc5q
        5f1Q3Lt86SgKYW+mhg/bP4iLz3cAYEc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341--o7suS0jOTK1fm-RsQlfFg-1; Sat, 07 Dec 2019 17:54:06 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE38B1005514;
        Sat,  7 Dec 2019 22:54:05 +0000 (UTC)
Received: from elisabeth (ovpn-200-27.brq.redhat.com [10.40.200.27])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 66CA85C1D4;
        Sat,  7 Dec 2019 22:54:04 +0000 (UTC)
Date:   Sat, 7 Dec 2019 23:52:15 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH,nf-next RFC 2/2] netfilter: nf_tables: add
 NFTA_SET_ELEM_KEY_END attribute
Message-ID: <20191207235215.361e66fc@elisabeth>
In-Reply-To: <20191206195255.t3jxumfdi2dc6mts@salvia>
References: <20191202131407.500999-1-pablo@netfilter.org>
        <20191202131407.500999-3-pablo@netfilter.org>
        <20191205234421.19d78cd8@elisabeth>
        <20191206195255.t3jxumfdi2dc6mts@salvia>
Organization: Red Hat
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: -o7suS0jOTK1fm-RsQlfFg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 6 Dec 2019 20:52:55 +0100
Pablo Neira Ayuso <pablo@netfilter.org> wrote:

> On Thu, Dec 05, 2019 at 11:44:21PM +0100, Stefano Brivio wrote:
> > On Mon,  2 Dec 2019 14:14:07 +0100
> > Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >   
> > > Add NFTA_SET_ELEM_KEY_END attribute to convey the closing element of the
> > > interval between kernel and userspace.
> > > 
> > > This patch also adds the NFT_SET_EXT_KEY_END extension to store the
> > > closing element value in this interval.
> > > 
> > > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > > ---
> > >  include/net/netfilter/nf_tables.h        | 14 +++++-
> > >  include/uapi/linux/netfilter/nf_tables.h |  2 +
> > >  net/netfilter/nf_tables_api.c            | 82 +++++++++++++++++++++++---------
> > >  net/netfilter/nft_dynset.c               |  2 +-
> > >  4 files changed, 76 insertions(+), 24 deletions(-)
> > > 
> > > diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
> > > index fe7c50acc681..2252a3892124 100644
> > > --- a/include/net/netfilter/nf_tables.h
> > > +++ b/include/net/netfilter/nf_tables.h
> > > @@ -231,6 +231,7 @@ struct nft_userdata {
> > >   *	struct nft_set_elem - generic representation of set elements
> > >   *
> > >   *	@key: element key
> > > + *	@key_end: closing element key  
> > 
> > The "closing" here takes for granted that we're talking about ranges,
> > but perhaps it's not obvious from the context. Maybe something on the
> > lines of "upper bound element key, for ranges" would be more
> > explanatory.  
> 
> You mean to update the comment? That's fine indeed.

Yes, that.

> > >   *	@priv: element private data and extensions
> > >   */
> > >  struct nft_set_elem {
> > > @@ -238,6 +239,10 @@ struct nft_set_elem {
> > >  		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
> > >  		struct nft_data	val;
> > >  	} key;
> > > +	union {
> > > +		u32		buf[NFT_DATA_VALUE_MAXLEN / sizeof(u32)];
> > > +		struct nft_data	val;
> > > +	} key_end;
> > >  	void			*priv;
> > >  };  
> > 
> > I wonder if this special need justifies almost doubling the size (for
> > other set types) here.  
> 
> IIRC, this nft_set_elem structure is only used from the control plane.

Ah, yes, I got confused by the fact that nft_set_elem_init() allocates
'elem', but it's not the same thing as 'elem' in nft_add_set_elem().
Please discard my comment.

> > As far as I can tell, *priv doesn't need to be at the end, so we might
> > even consider to have key[0] at the end, with 1 to 2 elements, and I
> > guess nft_set_elem_init() has the information needed to allocate the
> > right size.  
> 
> The priv pointer stores data in a linear area through the extension
> infrastructure. I think the layout of this elem.priv pointer (actually
> the nft_set_ext object) is what matters in terms of memory efficiency,
> since it is used from the packet path.

Right, and I had tried to play with it already, dropping the offset[]
field and using fixed offsets instead, but I couldn't see a significant
improvement (at least on aarch64 and x86_64).

I would rather invest time later in trying to avoid dereferencing it
altogether in the packet path (at least for sets without timeout). As I
was mentioning in my other email, that would be possible by modifying
the transaction model, but it's not exactly straightforward, and I have
no clue how it affect existing set implementations.

> We can probably simplify this set extension infrastructure later. At
> least one key is always guaranteed to be in place.

It already looks simple enough to me -- I just missed the fact this is
only used from the control path.

> > > @@ -502,6 +507,7 @@ void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set);
> > >   *	enum nft_set_extensions - set extension type IDs
> > >   *
> > >   *	@NFT_SET_EXT_KEY: element key
> > > + *	@NFT_SET_EXT_KEY_END: closing element key
> > >   *	@NFT_SET_EXT_DATA: mapping data
> > >   *	@NFT_SET_EXT_FLAGS: element flags
> > >   *	@NFT_SET_EXT_TIMEOUT: element timeout
> > > @@ -513,6 +519,7 @@ void nf_tables_destroy_set(const struct nft_ctx *ctx, struct nft_set *set);
> > >   */
> > >  enum nft_set_extensions {
> > >  	NFT_SET_EXT_KEY,
> > > +	NFT_SET_EXT_KEY_END,
> > >  	NFT_SET_EXT_DATA,
> > >  	NFT_SET_EXT_FLAGS,
> > >  	NFT_SET_EXT_TIMEOUT,
> > > @@ -606,6 +613,11 @@ static inline struct nft_data *nft_set_ext_key(const struct nft_set_ext *ext)
> > >  	return nft_set_ext(ext, NFT_SET_EXT_KEY);
> > >  }
> > >  
> > > +static inline struct nft_data *nft_set_ext_key_end(const struct nft_set_ext *ext)
> > > +{
> > > +	return nft_set_ext(ext, NFT_SET_EXT_KEY_END);
> > > +}
> > > +
> > >  static inline struct nft_data *nft_set_ext_data(const struct nft_set_ext *ext)
> > >  {
> > >  	return nft_set_ext(ext, NFT_SET_EXT_DATA);
> > > @@ -655,7 +667,7 @@ static inline struct nft_object **nft_set_ext_obj(const struct nft_set_ext *ext)
> > >  
> > >  void *nft_set_elem_init(const struct nft_set *set,
> > >  			const struct nft_set_ext_tmpl *tmpl,
> > > -			const u32 *key, const u32 *data,
> > > +			const u32 *key, const u32 *key_end, const u32 *data,
> > >  			u64 timeout, u64 expiration, gfp_t gfp);
> > >  void nft_set_elem_destroy(const struct nft_set *set, void *elem,
> > >  			  bool destroy_expr);
> > > diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
> > > index bb9b049310df..1d62552a12a7 100644
> > > --- a/include/uapi/linux/netfilter/nf_tables.h
> > > +++ b/include/uapi/linux/netfilter/nf_tables.h
> > > @@ -370,6 +370,7 @@ enum nft_set_elem_flags {
> > >   * @NFTA_SET_ELEM_USERDATA: user data (NLA_BINARY)
> > >   * @NFTA_SET_ELEM_EXPR: expression (NLA_NESTED: nft_expr_attributes)
> > >   * @NFTA_SET_ELEM_OBJREF: stateful object reference (NLA_STRING)
> > > + * @NFTA_SET_ELEM_KEY_END: closing key value (NLA_STRING)  
> > 
> > s/NLA_STRING/NLA_NESTED/
> >   
> > >   */
> > >  enum nft_set_elem_attributes {
> > >  	NFTA_SET_ELEM_UNSPEC,
> > > @@ -382,6 +383,7 @@ enum nft_set_elem_attributes {
> > >  	NFTA_SET_ELEM_EXPR,
> > >  	NFTA_SET_ELEM_PAD,
> > >  	NFTA_SET_ELEM_OBJREF,
> > > +	NFTA_SET_ELEM_KEY_END,
> > >  	__NFTA_SET_ELEM_MAX
> > >  };
> > >  #define NFTA_SET_ELEM_MAX	(__NFTA_SET_ELEM_MAX - 1)
> > > diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
> > > index 13e291fac26f..927f6de5f65c 100644
> > > --- a/net/netfilter/nf_tables_api.c
> > > +++ b/net/netfilter/nf_tables_api.c
> > > @@ -4199,6 +4199,7 @@ static const struct nla_policy nft_set_elem_policy[NFTA_SET_ELEM_MAX + 1] = {
> > >  					    .len = NFT_USERDATA_MAXLEN },
> > >  	[NFTA_SET_ELEM_EXPR]		= { .type = NLA_NESTED },
> > >  	[NFTA_SET_ELEM_OBJREF]		= { .type = NLA_STRING },
> > > +	[NFTA_SET_ELEM_KEY_END]		= { .type = NLA_NESTED },
> > >  };
> > >  
> > >  static const struct nla_policy nft_set_elem_list_policy[NFTA_SET_ELEM_LIST_MAX + 1] = {
> > > @@ -4248,6 +4249,11 @@ static int nf_tables_fill_setelem(struct sk_buff *skb,
> > >  			  NFT_DATA_VALUE, set->klen) < 0)
> > >  		goto nla_put_failure;
> > >  
> > > +	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END) &&
> > > +	    nft_data_dump(skb, NFTA_SET_ELEM_KEY_END, nft_set_ext_key_end(ext),
> > > +			  NFT_DATA_VALUE, set->klen) < 0)
> > > +		goto nla_put_failure;
> > > +
> > >  	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
> > >  	    nft_data_dump(skb, NFTA_SET_ELEM_DATA, nft_set_ext_data(ext),
> > >  			  set->dtype == NFT_DATA_VERDICT ? NFT_DATA_VERDICT : NFT_DATA_VALUE,
> > > @@ -4538,6 +4544,13 @@ static int nft_get_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	if (err < 0)
> > >  		return err;
> > >  
> > > +	if (nla[NFTA_SET_ELEM_KEY_END]) {
> > > +		err = nft_setelem_parse_key(ctx, set, &elem.key_end.val,
> > > +					    nla[NFTA_SET_ELEM_KEY_END]);
> > > +		if (err < 0)
> > > +			return err;
> > > +	}
> > > +
> > >  	priv = set->ops->get(ctx->net, set, &elem, flags);
> > >  	if (IS_ERR(priv))
> > >  		return PTR_ERR(priv);
> > > @@ -4663,8 +4676,8 @@ static struct nft_trans *nft_trans_elem_alloc(struct nft_ctx *ctx,
> > >  
> > >  void *nft_set_elem_init(const struct nft_set *set,
> > >  			const struct nft_set_ext_tmpl *tmpl,
> > > -			const u32 *key, const u32 *data,
> > > -			u64 timeout, u64 expiration, gfp_t gfp)
> > > +			const u32 *key, const u32 *key_end,
> > > +			const u32 *data, u64 timeout, u64 expiration, gfp_t gfp)
> > >  {
> > >  	struct nft_set_ext *ext;
> > >  	void *elem;
> > > @@ -4677,6 +4690,8 @@ void *nft_set_elem_init(const struct nft_set *set,
> > >  	nft_set_ext_init(ext, tmpl);
> > >  
> > >  	memcpy(nft_set_ext_key(ext), key, set->klen);
> > > +	if (nft_set_ext_exists(ext, NFT_SET_EXT_KEY_END))
> > > +		memcpy(nft_set_ext_key_end(ext), key_end, set->klen);
> > >  	if (nft_set_ext_exists(ext, NFT_SET_EXT_DATA))
> > >  		memcpy(nft_set_ext_data(ext), data, set->dlen);
> > >  	if (nft_set_ext_exists(ext, NFT_SET_EXT_EXPIRATION)) {
> > > @@ -4811,9 +4826,19 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	err = nft_setelem_parse_key(ctx, set, &elem.key.val,
> > >  				    nla[NFTA_SET_ELEM_KEY]);
> > >  	if (err < 0)
> > > -		goto err1;
> > > +		return err;  
> > 
> > I think this makes sense as labels get meaningful names with this
> > patch, but I wonder if this change is actually intended.
> >   
> > >  
> > >  	nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY, set->klen);
> > > +
> > > +	if (nla[NFTA_SET_ELEM_KEY_END]) {
> > > +		err = nft_setelem_parse_key(ctx, set, &elem.key_end.val,
> > > +					    nla[NFTA_SET_ELEM_KEY_END]);
> > > +		if (err < 0)
> > > +			goto err_parse_key;  
> > 
> > Same comment as patch 1/2, this would be more straightforward if
> > nft_setelem_parse_key() cleaned up after itself (only on error).
> >   
> > > +
> > > +		nft_set_ext_add_length(&tmpl, NFT_SET_EXT_KEY_END, set->klen);
> > > +	}
> > > +
> > >  	if (timeout > 0) {
> > >  		nft_set_ext_add(&tmpl, NFT_SET_EXT_EXPIRATION);
> > >  		if (timeout != set->timeout)
> > > @@ -4823,14 +4848,14 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	if (nla[NFTA_SET_ELEM_OBJREF] != NULL) {
> > >  		if (!(set->flags & NFT_SET_OBJECT)) {
> > >  			err = -EINVAL;
> > > -			goto err2;
> > > +			goto err_parse_key_end;
> > >  		}
> > >  		obj = nft_obj_lookup(ctx->net, ctx->table,
> > >  				     nla[NFTA_SET_ELEM_OBJREF],
> > >  				     set->objtype, genmask);
> > >  		if (IS_ERR(obj)) {
> > >  			err = PTR_ERR(obj);
> > > -			goto err2;
> > > +			goto err_parse_key_end;
> > >  		}
> > >  		nft_set_ext_add(&tmpl, NFT_SET_EXT_OBJREF);
> > >  	}
> > > @@ -4839,11 +4864,11 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  		err = nft_data_init(ctx, &data, sizeof(data), &d2,
> > >  				    nla[NFTA_SET_ELEM_DATA]);
> > >  		if (err < 0)
> > > -			goto err2;
> > > +			goto err_parse_key_end;
> > >  
> > >  		err = -EINVAL;
> > >  		if (set->dtype != NFT_DATA_VERDICT && d2.len != set->dlen)
> > > -			goto err3;
> > > +			goto err_parse_data;
> > >  
> > >  		dreg = nft_type_to_reg(set->dtype);
> > >  		list_for_each_entry(binding, &set->bindings, list) {
> > > @@ -4861,7 +4886,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  							  &data,
> > >  							  d2.type, d2.len);
> > >  			if (err < 0)
> > > -				goto err3;
> > > +				goto err_parse_data;
> > >  
> > >  			if (d2.type == NFT_DATA_VERDICT &&
> > >  			    (data.verdict.code == NFT_GOTO ||
> > > @@ -4886,10 +4911,11 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  	}
> > >  
> > >  	err = -ENOMEM;
> > > -	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data, data.data,
> > > +	elem.priv = nft_set_elem_init(set, &tmpl, elem.key.val.data,
> > > +				      elem.key_end.val.data, data.data,
> > >  				      timeout, expiration, GFP_KERNEL);
> > >  	if (elem.priv == NULL)
> > > -		goto err3;
> > > +		goto err_parse_data;
> > >  
> > >  	ext = nft_set_elem_ext(set, elem.priv);
> > >  	if (flags)
> > > @@ -4906,7 +4932,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  
> > >  	trans = nft_trans_elem_alloc(ctx, NFT_MSG_NEWSETELEM, set);
> > >  	if (trans == NULL)
> > > -		goto err4;
> > > +		goto err_trans;
> > >  
> > >  	ext->genmask = nft_genmask_cur(ctx->net) | NFT_SET_ELEM_BUSY_MASK;
> > >  	err = set->ops->insert(ctx->net, set, &elem, &ext2);
> > > @@ -4917,7 +4943,7 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  			    nft_set_ext_exists(ext, NFT_SET_EXT_OBJREF) ^
> > >  			    nft_set_ext_exists(ext2, NFT_SET_EXT_OBJREF)) {
> > >  				err = -EBUSY;
> > > -				goto err5;
> > > +				goto err_element_clash;
> > >  			}
> > >  			if ((nft_set_ext_exists(ext, NFT_SET_EXT_DATA) &&
> > >  			     nft_set_ext_exists(ext2, NFT_SET_EXT_DATA) &&
> > > @@ -4930,33 +4956,35 @@ static int nft_add_set_elem(struct nft_ctx *ctx, struct nft_set *set,
> > >  			else if (!(nlmsg_flags & NLM_F_EXCL))
> > >  				err = 0;
> > >  		}
> > > -		goto err5;
> > > +		goto err_element_clash;
> > >  	}
> > >  
> > >  	if (set->size &&
> > >  	    !atomic_add_unless(&set->nelems, 1, set->size + set->ndeact)) {
> > >  		err = -ENFILE;  
> > 
> > Unrelated: I think -ENFILE is abused here, and -ENOSPC would be a
> > better fit.  
> 
> Yes ENOSPC is better indeed, 3dd0673ac3 added introduced this
> misleading error reporting.
> 
> From a uAPI perspective, we should not update errors that are exposed
> to the user, but this one is so wrong that I would take a patch for
> this.

Okay, I'll send a patch once we're done with this.

-- 
Stefano

