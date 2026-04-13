Return-Path: <netfilter-devel+bounces-11848-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GK8lImAq3WmVaQkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11848-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 19:39:44 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4123F1984
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 19:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3A443107D2D
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Apr 2026 17:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1487C3559E1;
	Mon, 13 Apr 2026 17:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="j4xX5vwB"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F8D348875
	for <netfilter-devel@vger.kernel.org>; Mon, 13 Apr 2026 17:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776101286; cv=none; b=XwlR62lSPLKMZ201zc+NyXj3Vset/ojFpzjk3B40HXLWWKVuQW25wJJ7PowhI4H6FJcZfmtWO+Jp6Lkz+d9ymoDx4XHp2UYMZrmlvNeJlbbIrqPyxWIM8IOgvNakPpsep2ZFuC1mRWsGf3hsz8qjW38XNuw6udyU8MS5y2Tq9Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776101286; c=relaxed/simple;
	bh=dJFYfkQqVGwuwxX3yZYI4Tni7a4AG3e3yXre3dXWabI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dT54Iypddy1nR4gfkAsJjbsnOa1Zr8uRlD69dy5VwTJ1yivKSi/uNdIW8upcGKHWhXMwICDm96YYLDCLzjQBH17xTswV895jlAaxF8Du0kAOHeNw0xc9KTdZqgF3UVPNR+KOMmrFUUWCQcLdnbXrXWB0/WDQhVLb5d+dS+BBPA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=j4xX5vwB; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id BBABA6031A;
	Mon, 13 Apr 2026 19:28:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776101281;
	bh=EwaUd21I0dYv0NALe43F7GOToWI4Vk+T3pbJApr0yGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j4xX5vwBHBnIc6PqLF2KsM0ik8eb0jZoTAlH+n3ngPYYIbLVCGXeUByqiramt10Xm
	 TKYdq6j74H9eJIzXx5ZjVo3Gcwog7ltUNBwJ5y8Z/kgokOChIQon45FoxG8xCgfDWm
	 mQfXYKFNkRPZ7Oe6jQ/ljWR1p94lP00du1uaHhshJIIZqFtKvifvEchohDamuaqukF
	 awDbrvJerqoVOhUiHPvCeLLfWfH4oYCAz8WbNiqs62rExE22OZGTwme9yIHi43RCkA
	 9dF2DKul/IkoffpzGNW9MsDkySMtN7KMUS9PYqc4H4hxbfHMxuxG7KDfsz7Bym5DZY
	 +4bafrUGNF7DA==
Date: Mon, 13 Apr 2026 19:27:58 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH] netfilter: nfnetlink_cthelper: fix expect policy update
 copying only first class values to all classes
Message-ID: <ad0ncfqrrUWrYOmo@chamomile>
References: <20260413084822.70754-1-phx0fer@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260413084822.70754-1-phx0fer@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11848-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DB4123F1984
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 04:48:22PM +0800, Dudu Lu wrote:
> In nfnl_cthelper_update_policy_all(), when updating the expect policies
> of a multi-class conntrack helper, the loop iterates over all expect
> classes but always reads from new_policy[0] instead of new_policy[i]:
> 
>     for (i = 0; i < helper->expect_class_max + 1; i++) {
>         policy = &helper->expect_policy[i];
>         policy->max_expected = new_policy->max_expected;  /* always [0] */
>         policy->timeout      = new_policy->timeout;       /* always [0] */
>     }
> 
> The new_policy array was correctly parsed per-class by
> nfnl_cthelper_update_policy_one() in the validation loop above (line
> 336-342), with each new_policy[i] holding its respective class values.
> However, the copy loop dereferences new_policy as a pointer
> (new_policy->x) rather than indexing it as an array
> (new_policy[i].x), creating a security vulnerability.
> 
> As a result, all expect classes of a multi-class helper get overwritten
> with the values of class 0, discarding the per-class differentiation.
> 
> This affects helpers like H.323 which use multiple expect classes
> (RTP, RTCP, T.120) with different max_expected and timeout values.
> After a policy update, all classes get identical limits, breaking the
> per-class expect enforcement.

Not really. Such helpers do not exists in userspace, and this is fully
userspace conntrack helper infrastructure.

This is nf-next material: I think no userspace helper is using more
than one single expectation class at this stage.

> Fix by indexing new_policy with the loop variable.
> 
> Fixes: 2c422257550f ("netfilter: nfnl_cthelper: fix runtime expectation policy updates")
> Signed-off-by: Dudu Lu <phx0fer@gmail.com>
> ---
>  net/netfilter/nfnetlink_cthelper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/netfilter/nfnetlink_cthelper.c b/net/netfilter/nfnetlink_cthelper.c
> index d545fa459455..1e605d77796d 100644
> --- a/net/netfilter/nfnetlink_cthelper.c
> +++ b/net/netfilter/nfnetlink_cthelper.c
> @@ -346,8 +346,8 @@ static int nfnl_cthelper_update_policy_all(struct nlattr *tb[],
>  	for (i = 0; i < helper->expect_class_max + 1; i++) {
>  		policy = (struct nf_conntrack_expect_policy *)
>  				&helper->expect_policy[i];
> -		policy->max_expected = new_policy->max_expected;
> -		policy->timeout	= new_policy->timeout;
> +		policy->max_expected = new_policy[i].max_expected;
> +		policy->timeout	= new_policy[i].timeout;
>  	}
>  
>  err:
> -- 
> 2.39.3 (Apple Git-145)
> 

