Return-Path: <netfilter-devel+bounces-12464-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHDsGyFD+2mzYgMAu9opvQ
	(envelope-from <netfilter-devel+bounces-12464-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 15:33:21 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C39964DB037
	for <lists+netfilter-devel@lfdr.de>; Wed, 06 May 2026 15:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D6D53011A56
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2026 13:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A0F477983;
	Wed,  6 May 2026 13:33:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AE2477E27;
	Wed,  6 May 2026 13:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778074398; cv=none; b=kvXVaTmxGjKswDMbTnkwsWKUlEeJhlKQC4kfkvkTOXCtAV7FWnuC/mCJuK7fb/uXMb7FOYtaa465UM/G6//LTOVSY4LSp1KEjRCn8mkt79ENv7pIOSy1yzrWQK1CMTC21aH3ihcHi1x3apWiIG4+NqGn6wjVuEayB4LlnI4BFrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778074398; c=relaxed/simple;
	bh=W1DFYoi6sjGC3+Gfijj1/NkkzbGt4m6uC5ESu7JaEDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mGbVVz3odDmYQx8SRR/OLAk5K6miOsqHs1O16B0oDDcMVR+7LwKAdOk/bzRnka6bIXBPhKKfUtJqHB+Hkq/Gjl6TdcLKC4xFLODgt5YDAHsT3Uneh03J/TnoO9dh8q03twEhFgu05VrXlt7GuK44MplYtkJF+wFIQpbnfpyS8/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 41F6D605F3; Wed, 06 May 2026 15:33:13 +0200 (CEST)
Date: Wed, 6 May 2026 15:33:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Li Xiasong <lixiasong1@huawei.com>
Cc: netfilter-devel@vger.kernel.org, stable@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	coreteam@netfilter.org, yuehaibing@huawei.com,
	zhangchangzhong@huawei.com, weiyongjun1@huawei.com
Subject: Re: [PATCH nft 1/2] netfilter: nf_conntrack_sip: fix missing expect
 put in REGISTER path
Message-ID: <aftDGCXcI45PdHQc@strlen.de>
References: <20260506121618.578443-1-lixiasong1@huawei.com>
 <20260506121618.578443-2-lixiasong1@huawei.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506121618.578443-2-lixiasong1@huawei.com>
X-Rspamd-Queue-Id: C39964DB037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12464-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Li Xiasong <lixiasong1@huawei.com> wrote:
> process_register_request() allocates an expectation, but the !helper
> error path returns NF_DROP without nf_ct_expect_put(exp).
> 
> Add the missing put to balance nf_ct_expect_alloc() on this path.
> 
> Fixes: e14575fa7529 ("netfilter: nf_conntrack: use rcu accessors where needed")
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Xiasong <lixiasong1@huawei.com>
> ---
>  net/netfilter/nf_conntrack_sip.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_conntrack_sip.c b/net/netfilter/nf_conntrack_sip.c
> index 1eb55907d470..a895bc836e1b 100644
> --- a/net/netfilter/nf_conntrack_sip.c
> +++ b/net/netfilter/nf_conntrack_sip.c
> @@ -1377,8 +1377,10 @@ static int process_register_request(struct sk_buff *skb, unsigned int protoff,
>  		saddr = &ct->tuplehash[!dir].tuple.src.u3;
>  
>  	helper = rcu_dereference(nfct_help(ct)->helper);
> -	if (!helper)
> +	if (!helper) {
> +		nf_ct_expect_put(exp);
>  		return NF_DROP;
> +	}

I think it would be simpler to move the rcu defer to before
exp allocation instead.

