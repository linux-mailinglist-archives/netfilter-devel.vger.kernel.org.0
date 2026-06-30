Return-Path: <netfilter-devel+bounces-13544-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PpUOAmKWQ2r5cgoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13544-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 12:11:46 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1EA6E2A97
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 12:11:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=tadnm3PM;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13544-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13544-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9489930A2FCE
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Jun 2026 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5FA3EC2CB;
	Tue, 30 Jun 2026 10:08:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA673ED3A4
	for <netfilter-devel@vger.kernel.org>; Tue, 30 Jun 2026 10:08:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814132; cv=none; b=iB+62EGanEv9smecK8HYD5LVG85pYg+POBZAzBlDkLxNr2pbL8lvDNp7WcPTJ7BlvA8KpG8TSRB5gT1MJeLpSeAyyLV5mpsXJy5PbuLSDmlt4ngQsKivs7FlosmfpLEXC/9rVjCMMyDLtGaD/3Qnac+2kTfx+wSKYMMskxv8Rao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814132; c=relaxed/simple;
	bh=YOaTKIAt7c8ib3KyFOrwFkiQGo4tn1hV2XYBlHvJ+tQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5Nwn9UiRhEMfsXApq202cey334unnCuTwwR9vwqo6LSyiZY3/g96mwtUrJxfVu3uhYQk2KF1PKyPvasDzJ7PjhBS8wD0vVXa+SIplwy9Ip9rNmLggnYtKAYXOfnW6dfK9p+uW2nRy3dEJEolFFjC7d7z9Gt9qNiaImg2BEZmfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=tadnm3PM; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id D39CC60195;
	Tue, 30 Jun 2026 12:08:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782814125;
	bh=UV32uy2Us9zyLbHGjctpfYyGmT3J8pMg7/+akr7tWHI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tadnm3PMubTl+4/TNRmRM0rKIxoYltYT7/g8Y64Np3RpQYDTGOK1V2GObTlfAQAm0
	 NfvC1ECAiVzuvTFceVpZJk+P9L8nDjNg/U56q7nnccTZgb9J8lQQ65u5g8q6/WJPYE
	 to3+D2EMK+f47PqnBHMm0IeZMJSMy7X7EFVXf3QBXrFkWVXfcZMkxEFFyRGlqx1E+f
	 i3AEYFHSgXPOthIY7Ocqz9oBOclv3Ck2NZ/V5p22pp8WJILD/zkaI+EwdNIdmA7Ayn
	 Gp1lhcZ3X7E7y0IFzCqCCexbEI7cwQd5SLnXoEcUeJkFSqLEwf992xxe2QXFyQWWD6
	 RT+t85QQdQbvw==
Date: Tue, 30 Jun 2026 12:08:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2] netfilter: nft_ct: support expectation
 creation for natted flows
Message-ID: <akOVqk9WOTpIKCss@chamomile>
References: <20260630060311.2504-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260630060311.2504-1-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13544-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,chamomile:mid,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F1EA6E2A97

Hi Florian,

On Tue, Jun 30, 2026 at 08:03:08AM +0200, Florian Westphal wrote:
> This feature only works for connections originating from the host
> and only if there no source address rewrite.
> 
> Add the needed nat glue to have the expectation follow the original
> nat binding.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>
> ---
>  v2:
>  add missing nf_ct_expect_iterate_destroy() in exit handler
>  fix buld with CONFIG_NF_NAT=n
> 
>  net/netfilter/nft_ct.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
> index 03a88c77e0f0..95fc3d7c1edb 100644
> --- a/net/netfilter/nft_ct.c
> +++ b/net/netfilter/nft_ct.c
> @@ -1297,6 +1297,17 @@ static int nft_ct_expect_obj_dump(struct sk_buff *skb,
>  	return 0;
>  }
>  
> +#if IS_ENABLED(CONFIG_NF_NAT)
> +static void nft_ct_nat_follow_master(struct nf_conn *ct, struct nf_conntrack_expect *this)
> +{
> +	const struct nf_ct_helper_expectfn *expfn;
> +
> +	expfn = nf_ct_helper_expectfn_find_by_name("nat-follow-master");
> +	if (expfn)
> +		expfn->expectfn(ct, this);
> +}
> +#endif
> +
>  static void nft_ct_expect_obj_eval(struct nft_object *obj,
>  				   struct nft_regs *regs,
>  				   const struct nft_pktinfo *pkt)
> @@ -1342,6 +1353,13 @@ static void nft_ct_expect_obj_eval(struct nft_object *obj,
>  		          priv->l4proto, NULL, &priv->dport);
>  	exp->timeout += priv->timeout;
>  
> +#if IS_ENABLED(CONFIG_NF_NAT)
> +	if (ct->status & IPS_NAT_MASK) {
> +		exp->saved_proto.tcp.port = priv->dport;
> +		exp->dir = !dir;
> +		exp->expectfn = nft_ct_nat_follow_master;
> +	}
> +#endif
>  	if (nf_ct_expect_related(exp, 0) != 0)
>  		regs->verdict.code = NF_DROP;
>  
> @@ -1416,6 +1434,13 @@ static int __init nft_ct_module_init(void)
>  	return err;
>  }
>  
> +#if IS_ENABLED(CONFIG_NF_NAT)
> +static bool __exit expect_iter_nat(struct nf_conntrack_expect *exp, void *data)
> +{
> +	return exp->expectfn == nft_ct_nat_follow_master;
> +}
> +#endif
> +
>  static void __exit nft_ct_module_exit(void)
>  {
>  #ifdef CONFIG_NF_CONNTRACK_TIMEOUT
> @@ -1425,6 +1450,11 @@ static void __exit nft_ct_module_exit(void)
>  	nft_unregister_obj(&nft_ct_helper_obj_type);
>  	nft_unregister_expr(&nft_notrack_type);
>  	nft_unregister_expr(&nft_ct_type);
> +
> +#if IS_ENABLED(CONFIG_NF_NAT)
> +	nf_ct_expect_iterate_destroy(expect_iter_nat, NULL);
> +	synchronize_rcu();
> +#endif

Not sure sashiko is signalling a real issue here.

static void __exit nf_nat_cleanup(void) 
{
        struct nf_nat_proto_clean clean = {}; 
            
        nf_ct_iterate_destroy(nf_nat_proto_clean, &clean);

all NATted master conntracks are destroyed here, including their
expectations, which might have the expectations using
nat_follow_master.

nf_ct_iterate_cleanup()
  nf_ct_delete()
    clean_from_lists()
      nf_ct_remove_expectation()

And nf_nat_cleanup() can only be called if all there is no more nat
chains in place, correct?

If so, no new expectations can be created using nat_follow_master and
this nf_ct_iterate_destroy() is implicitly removing the remaining
expectations using nat_follow_master.

Sorry for the long writing, I don't see it where the issue is.

>  }
>  
>  module_init(nft_ct_module_init);
> -- 
> 2.53.0
> 
> 

