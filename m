Return-Path: <netfilter-devel+bounces-13790-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ICvKCTqQT2oMjwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13790-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 14:12:42 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF31730DBC
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 14:12:41 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=jvVajiyG;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13790-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13790-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D26C30234D8
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 12:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB623CC9EA;
	Thu,  9 Jul 2026 12:07:51 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6642C3F12C0
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 12:07:49 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598871; cv=none; b=n0Lsd/+bF0Gu1iBFpETP5dEeO4bieLCK4NNR4qwg7i6pL8fzL0WyLzX4NeplZwvFdmQjUsM8+aqa0mLucXf2JtVyaHCHiINHo54OSltMJ3mDVUtVfU5bpIZkvH+xcY/z1m4LGfX7LJfQ91UsLTnK+ipkctzptY0jmUQj78lw2Cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598871; c=relaxed/simple;
	bh=AEtaYjSyy7olDDklVZkjz3SnIdx7AKNrU+lwkyKt804=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PtUYeifBrllLCUnqZixFKhx71w95ciiJMakzEmP7TQ9WWmoSY0LkkZjixMsZyhdToblLPfnZo2dafk8YCFh+kUG3t4Ag7CWkAwWClovnleNH7tJNOALrWjyz7kWbB7WcPZQibi0MB65jcmKfpO7zaKs0TSunCN709hYoRZQ7QDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jvVajiyG; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 8493D6017D;
	Thu,  9 Jul 2026 14:07:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783598867;
	bh=v6XenYw0+edQlMjw7w56Pa2npxuOpJniBNcAKfqN8Tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvVajiyGtjYKfLqW24gDl1z72NTIPcjyKwijlwcB+VYP1Gb97jLQBoDZbDmkUEx0V
	 tjK2mUV1XIlWsLI1WwBtCZBGfyLZJQtRSbpeEiB0lHx/UUqjBgKjfvZG8dSEPj52ac
	 QLhFSpdrfahX5vfqr4WM/l0A50M38lxg6EduRyx3jtY7+TERK+u4kDd7Ckb+aMrS66
	 vmMOsHB0kN3jQgBSc43j/Xjmuqemw8wGdTmPB83q5IrKmoYyvVUyrKomywT9ZOOPcH
	 EprMo4jhKQR8ZQ+6K4RXSRfQm3SmORx2bekWmlX0tml6kqzvGF+12+uJU3zquhIanC
	 2pSfMHM72vubw==
Date: Thu, 9 Jul 2026 14:07:44 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [nf-next PATCH 2/4] netfilter: nfnetlink_hook: Deref hook entry
 using READ_ONCE()
Message-ID: <ak-PECbcevqjy91_@chamomile>
References: <20260708161940.1477671-1-phil@nwl.cc>
 <20260708161940.1477671-3-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708161940.1477671-3-phil@nwl.cc>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:phil@nwl.cc,m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13790-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BF31730DBC

Hi Phil,

On Wed, Jul 08, 2026 at 06:19:38PM +0200, Phil Sutter wrote:
> Writer (nf_remove_net_hook) assigns to the field value using
> WRITE_ONCE(), appropriately call READ_ONCE() to make sure reader
> (nfnl_hook_dump) sees either the old or new value, not both.

A bit broader question here:

Are we sure net/netfilter/core.c is safe to be walked over rcu in its
current state? Could the dummy_ops be exposed through nfnetlink_hook?

Maybe net/netfilter/core.c needs a revisited to use
rcu_assign_pointer() to assign the hook_ops to the blob, then
nfnetlink_hook uses rcu_dereference() instead of READ_ONCE.
Then the RCU semantics of the hooks would exposed in a better way?

That would made double use of RCU, one from the blob and then for the
hook_ops.

The hooks are now released using kfree_rcu(), at least in the recent
nf_nat core updates they are.

> Fixes: b010e2a4a9ac ("netfilter: nfnetlink_hook: Dump nat type chains")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
>  net/netfilter/nfnetlink_hook.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_hook.c b/net/netfilter/nfnetlink_hook.c
> index e47a2add4d5b..efc674fc5adf 100644
> --- a/net/netfilter/nfnetlink_hook.c
> +++ b/net/netfilter/nfnetlink_hook.c
> @@ -390,10 +390,12 @@ static int nfnl_hook_dump(struct sk_buff *nlskb,
>  	ops = nf_hook_entries_get_hook_ops(e);
>  
>  	for (; i < e->num_hook_entries; i++) {
> -		if (ops[i]->hook_ops_type == NF_HOOK_OP_NAT)
> -			err = nfnl_hook_dump_nat(nlskb, cb, ops[i], family);
> +		struct nf_hook_ops *cur = READ_ONCE(ops[i]);
> +
> +		if (cur->hook_ops_type == NF_HOOK_OP_NAT)
> +			err = nfnl_hook_dump_nat(nlskb, cb, cur, family);
>  		else
> -			err = nfnl_hook_dump_one(nlskb, ctx, ops[i],
> +			err = nfnl_hook_dump_one(nlskb, ctx, cur,
>  						 ops[i]->priority, family,
>  						 cb->nlh->nlmsg_seq);
>  		if (err)
> -- 
> 2.54.0
> 

