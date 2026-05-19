Return-Path: <netfilter-devel+bounces-12706-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UO+YHdjRDGrImQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-12706-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 23:10:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E9472585027
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 23:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D78C23036F82
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 May 2026 21:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003FB3E2ADD;
	Tue, 19 May 2026 21:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="XD7PwdoF"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB40A3DCD94;
	Tue, 19 May 2026 21:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779225035; cv=none; b=UuZ24K1VVSkMAOesQRlgLsHXZIRMpK7+FTxT/FTJRqxssQDPZUY3d9ftBWhZSYDKoCFRadwRKCtFDlNHzupmKRVTM6SOJw0RvqcEH0B5tvQg1PAVr826ZarSU4VkhYnereAO1qvP0DenfmAIp9b0r9TvCkKPfLlUE4FkFLlsTrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779225035; c=relaxed/simple;
	bh=nzEGScfWNf0R2M0QS4gGZ1kxLs/u77Kd3Kz4ZIK5NSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hhbjCpn+KFdGG1B/ZFntk4VCablmNmXn4FP26DBtIt6/f3YMxk0vDMdAioDYVeEyDa2bfe22Z+T9OfR1KD3SkB/gI6MKY9485ATjOzMZLNuiumDhMI8KBWS/j+aLpan93JX3e1/UCe1G9DyM+atf1WIdqD5cRpNBQaVjW0FjUdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=XD7PwdoF; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5AD9E601B3;
	Tue, 19 May 2026 23:10:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1779225031;
	bh=OUTzr1IFS2bDUk5iMxsxfp+LOZ9OTmDj5OSUK0QK+RA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XD7PwdoFOtKp9ObW+xW/lbVcSG3WptJoejPk1vFSRaH1YKyV4Elvg77LDom6TTlSL
	 2p6eogVcCoSxuabBwt0cnhN8EZ//Br5PBr/Qv9mBqVZFS4fV17B17ryL9VPK11zv7/
	 d+4vPlq19jWfQh2VI1VkTrf+BOnxTe/TtskfOM8HmRO0nd2yCyWsbJj0FwJk/cRg4H
	 Yss3aa6I7yRS56nUFLEJSuboAT/0KB6P/xc3h4E7jxVxgJ3WLCZtjlli7DKIjT5A6P
	 IUsApR61lQOmKWreLhTz+lHkjmVq9lCF63koHtwoNbHChI3iD+1OLj6xpMsNsuBtYG
	 KVkRLRR3jGlQA==
Date: Tue, 19 May 2026 23:10:27 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	fw@strlen.de, horms@kernel.org
Subject: Re: [PATCH net 12/12] netfilter: nf_queue: hold bridge skb->dev
 while queued
Message-ID: <agzRw16rOjemQX7H@chamomile>
References: <20260516115627.967773-1-pablo@netfilter.org>
 <20260516115627.967773-13-pablo@netfilter.org>
 <20260518170150.06a575c3@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260518170150.06a575c3@kernel.org>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12706-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,netfilter.org:dkim]
X-Rspamd-Queue-Id: E9472585027
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 18, 2026 at 05:01:50PM -0700, Jakub Kicinski wrote:
> On Sat, 16 May 2026 13:56:27 +0200 Pablo Neira Ayuso wrote:
> > diff --git a/include/net/netfilter/nf_queue.h b/include/net/netfilter/nf_queue.h
> > index d17035d14d96..3978c3174cdb 100644
> > --- a/include/net/netfilter/nf_queue.h
> > +++ b/include/net/netfilter/nf_queue.h
> > @@ -14,6 +14,7 @@ struct nf_queue_entry {
> >  	struct list_head	list;
> >  	struct rhash_head	hash_node;
> >  	struct sk_buff		*skb;
> > +	struct net_device	*skb_dev;
> >  	unsigned int		id;
> >  	unsigned int		hook_index;	/* index in hook_entries->hook[] */
> >  #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
> > diff --git a/net/netfilter/nf_queue.c b/net/netfilter/nf_queue.c
> > index a6c81c04b3a5..57b450024a99 100644
> > --- a/net/netfilter/nf_queue.c
> > +++ b/net/netfilter/nf_queue.c
> > @@ -61,6 +61,7 @@ static void nf_queue_entry_release_refs(struct nf_queue_entry *entry)
> >  	struct nf_hook_state *state = &entry->state;
> >  
> >  	/* Release those devices we held, or Alexey will kill me. */
> > +	dev_put(entry->skb_dev);
> >  	dev_put(state->in);
> >  	dev_put(state->out);
> >  	if (state->sk)
> > @@ -102,6 +103,7 @@ bool nf_queue_entry_get_refs(struct nf_queue_entry *entry)
> >  	if (state->sk && !refcount_inc_not_zero(&state->sk->sk_refcnt))
> >  		return false;
> >  
> > +	dev_hold(entry->skb_dev);
> >  	dev_hold(state->in);
> >  	dev_hold(state->out);
> 
> Please follow up and add a ref tracker to this?

I'll do net-next.

