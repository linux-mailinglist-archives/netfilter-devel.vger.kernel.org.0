Return-Path: <netfilter-devel+bounces-12465-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCJBIo5V+2n+ZQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12465-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 16:51:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 244434DCA14
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 16:51:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E4AA303A23B
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 14:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A5E3E3165;
	Wed,  6 May 2026 14:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Yh0tpHbN"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5E83ED136;
	Wed,  6 May 2026 14:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079032; cv=none; b=KNViahMTZVEOPkLWv+VGoj1htB8U1Q5naqs7xnBbRiqcbzgQvHyQJotQLHmqcoyfsepyuCUPDEZRR+Q2Gus3SRtYlJoymhqXQDo1kPCM/McT4pLfwSs5jGXcZLrcIDD200r8WNh3brtP6nhWK9p8V5HNTHvX+TGbCzkPCii224k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079032; c=relaxed/simple;
	bh=W+9Ru/IuhnHtcQ/oRl0JM8hKC7zwPnW0F4Cm8mhy0AQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=srOZvYcUe28Y2HwaarnkiEDEimujIgFo8LcJc1N1nYtbD20vp6ciEb9I6UCchYCSdQshZxzuj4HKyK+ZRq+xkEAZwGz/3ZqQTohaKUO13GS9Ktb5GNo/86zjIMJXJqLwchpTIVj+lIgSCAE2ybzl7dOKA2YLO7d1gRa9ByxGk2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Yh0tpHbN; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 330D5600B9;
	Wed,  6 May 2026 16:50:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1778079022;
	bh=PczqAw9xXZ3Qvz9x7qOo46E3XhPTFDgKNAs0QUzEXig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yh0tpHbNHFcf/rdQwcLJcIjz2hbd0kCJTj4EO/rO/1nUf52FsE+GiYXO8tSCFD83H
	 rTEQzq0bq/ZW2lAkrR7KqAcuwBGBjq3Uw4B/THTGkt9Yb9ivw0InHZZYamPGNllDC1
	 DmqIXS+nivUJNm9J/EUVQpFM3qWXrgd5z4VqnmG86iZPyOyzBpYvWJ/VvUnQupLOGP
	 fjfTO6EzxnE1c7vX74zoZDLV1ncX8rILLrYabnNfPrXnQigZ+9DGhlr/0IROD7DNJ9
	 SaCcOVj/1RNAUjUfpuptsH0ciZSfh9HkjMy8uaiEwjvdvJN3sjey3frb23TDA1LiDy
	 arRf1kl/dK/xg==
Date: Wed, 6 May 2026 16:50:19 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: Li Xiasong <lixiasong1@huawei.com>, netfilter-devel@vger.kernel.org,
	stable@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
	coreteam@netfilter.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH nft 1/2] netfilter: nf_conntrack_sip: fix missing expect
 put in REGISTER path
Message-ID: <aftVK8KkCzQrsiAD@chamomile>
References: <20260506121618.578443-1-lixiasong1@huawei.com>
 <20260506121618.578443-2-lixiasong1@huawei.com>
 <aftDGCXcI45PdHQc@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aftDGCXcI45PdHQc@strlen.de>
X-Rspamd-Queue-Id: 244434DCA14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12465-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]

On Wed, May 06, 2026 at 03:33:12PM +0200, Florian Westphal wrote:
> Li Xiasong <lixiasong1@huawei.com> wrote:
> > process_register_request() allocates an expectation, but the !helper
> > error path returns NF_DROP without nf_ct_expect_put(exp).
> > 
> > Add the missing put to balance nf_ct_expect_alloc() on this path.
> > 
> > Fixes: e14575fa7529 ("netfilter: nf_conntrack: use rcu accessors where needed")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> > ---
> >  net/netfilter/nf_conntrack_sip.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
> > index 1eb55907d470..a895bc836e1b 100644
> > --- a/net/netfilter/nf_conntrack_sip.c
> > +++ b/net/netfilter/nf_conntrack_sip.c
> > @@ -1377,8 +1377,10 @@ static int process_register_request(struct sk_buff *skb, unsigned int protoff,
> >  		saddr = &ct->tuplehash[!dir].tuple.src.u3;
> >  
> >  	helper = rcu_dereference(nfct_help(ct)->helper);
> > -	if (!helper)
> > +	if (!helper) {
> > +		nf_ct_expect_put(exp);
> >  		return NF_DROP;
> > +	}
> 
> I think it would be simpler to move the rcu defer to before
> exp allocation instead.

Agreed.

