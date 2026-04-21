Return-Path: <netfilter-devel+bounces-12109-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJb8Hh9n52ld7wEAu9opvQ
	(envelope-from <netfilter-devel+bounces-12109-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 14:01:35 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2142F43A627
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 14:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 948C93047040
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Apr 2026 11:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4C0038C2AE;
	Tue, 21 Apr 2026 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="qF96Y7Vr"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C52F3845D8;
	Tue, 21 Apr 2026 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776772588; cv=none; b=Ptq+uiqBvB2hO9tknkNVJmidOWzqwAW4/HI1e10KS2j2yP71QsFq/lHrWaLIGTIB4XihlkO2VHBCnIh1ss2t1ekE0A1V2+zpcYjNTG7J0Hq9bGZwbBloxTD+ssVE3akMNy7Yf9Y54N7Eceihekp9nc0aDz2j3glp97hoKaN+fzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776772588; c=relaxed/simple;
	bh=pQOQW0F37RiB3H/Va07FzlVZh/8VsGGpDYSzXTQ/d5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q3XDqNJFJYq/c8iK9XPDgYNNkRxX6fATCnc8Ojqkoe/JdylGBEl1DV1qBySUwY+2T2hMW6BA48cau/PfehxYEv1/DKac4f+wKkza+Bs7Ge4Ru0SWlkjY7FnXxqwnrirPDxp31+EQXIETJbG5xxOacGKhas2p2Us+D43dVGZhZS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=qF96Y7Vr; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 805D2600B5;
	Tue, 21 Apr 2026 13:56:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776772584;
	bh=phTSxWHX76RLznCdquM07h7FzBmO2ORr8wdwNAd/4Gk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qF96Y7VrJHSPJduyqVsLtC/vW8wMD/ILOSroqM4ptqFg0kVJRiogQFCGtkfjridwb
	 diuI915zzp+VidQQc1HN0kCVNFkFfpAv4O+UdVZuK/LPWExzOk50TDNs8EnW4Op7Ij
	 O7B+lYHN4Vd6Le+rKiQ7IBLcohomH6/Ovgeg9T6HFfbd/dz97WUtD20Zc23/9KOVzP
	 0z3be00o1R2XCLFNmgeyrujSJyzn1wbUMocdWmiDtwVcPfmUDVXGCTXYe0OslVF3OK
	 jqkoKq2gzA4c+aLjBUqS4WkFCuOAGSk3Ebgwbpm90C4sHgTRoL/MLCrAhZr32hW16i
	 iJ87ljw1zIunw==
Date: Tue, 21 Apr 2026 13:56:21 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Marino Dzalto <marino.dzalto@gmail.com>
Cc: fw@strlen.de, jacob.e.keller@intel.com, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] netfilter: xt_HL: add pr_fmt and checkentry validation
Message-ID: <aedl5SY8M6LtFxa2@chamomile>
References: <20260403205907.92749-1-marino.dzalto@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403205907.92749-1-marino.dzalto@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	RSPAMD_URIBL_FAIL(0.00)[toxicfilms.tv:query timed out];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12109-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,toxicfilms.tv:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2142F43A627
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 10:59:07PM +0200, Marino Dzalto wrote:
> Add pr_fmt to prefix log messages with the module name for
> easier debugging in dmesg.
> 
> Add checkentry functions for IPv4 (ttl_mt_check) and IPv6
> (hl_mt6_check) to validate the match mode at rule registration
> time, rejecting invalid modes with -EINVAL.
> 
> Signed-off-by: Marino Dzalto <marino.dzalto@gmail.com>
> ---

BTW, please use "nf-next" as target tree for this.

And use _ratelimited as suggested by the AI reviewer.

Send us a v4, thanks

> v3: Remove mention of NULL checks from commit message, as they
>     were never part of the original code.
> v2: Remove NULL checks for skb as suggested by Florian Westphal
>     (skb is guaranteed non-NULL by netfilter core). Move mode
>     validation to checkentry functions instead of match function,
>     also as suggested by Florian Westphal.
> ---
>  net/netfilter/xt_hl.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/net/netfilter/xt_hl.c b/net/netfilter/xt_hl.c
> index c1a70f8f0441..4a12a757ecbf 100644
> --- a/net/netfilter/xt_hl.c
> +++ b/net/netfilter/xt_hl.c
> @@ -6,6 +6,7 @@
>   * Hop Limit matching module
>   * (C) 2001-2002 Maciej Soltysiak <solt@dns.toxicfilms.tv>
>   */
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>  
>  #include <linux/ip.h>
>  #include <linux/ipv6.h>
> @@ -22,6 +23,18 @@ MODULE_LICENSE("GPL");
>  MODULE_ALIAS("ipt_ttl");
>  MODULE_ALIAS("ip6t_hl");
>  
> +static int ttl_mt_check(const struct xt_mtchk_param *par)
> +{
> +	const struct ipt_ttl_info *info = par->matchinfo;
> +
> +	if (info->mode > IPT_TTL_GT) {
> +		pr_err("Unknown TTL match mode: %d\n", info->mode);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
>  {
>  	const struct ipt_ttl_info *info = par->matchinfo;
> @@ -41,6 +54,18 @@ static bool ttl_mt(const struct sk_buff *skb, struct xt_action_param *par)
>  	return false;
>  }
>  
> +static int hl_mt6_check(const struct xt_mtchk_param *par)
> +{
> +	const struct ip6t_hl_info *info = par->matchinfo;
> +
> +	if (info->mode > IP6T_HL_GT) {
> +		pr_err("Unknown Hop Limit match mode: %d\n", info->mode);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
>  {
>  	const struct ip6t_hl_info *info = par->matchinfo;
> @@ -65,6 +90,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
>  		.name       = "ttl",
>  		.revision   = 0,
>  		.family     = NFPROTO_IPV4,
> +		.checkentry = ttl_mt_check,
>  		.match      = ttl_mt,
>  		.matchsize  = sizeof(struct ipt_ttl_info),
>  		.me         = THIS_MODULE,
> @@ -73,6 +99,7 @@ static struct xt_match hl_mt_reg[] __read_mostly = {
>  		.name       = "hl",
>  		.revision   = 0,
>  		.family     = NFPROTO_IPV6,
> +		.checkentry = hl_mt6_check,
>  		.match      = hl_mt6,
>  		.matchsize  = sizeof(struct ip6t_hl_info),
>  		.me         = THIS_MODULE,
> -- 
> 2.50.1 (Apple Git-155)
> 

