Return-Path: <netfilter-devel+bounces-11622-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FHhJ0sr0GkH4QYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11622-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 23:04:11 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AF7D398558
	for <lists+netfilter-devel@lfdr.de>; Fri, 03 Apr 2026 23:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8DC3F303A12E
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Apr 2026 21:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918923D8105;
	Fri,  3 Apr 2026 21:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Ra07SwbT"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60F53D5656;
	Fri,  3 Apr 2026 21:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775250122; cv=none; b=EL+z8SaStZauvA6u/vp2Ryrxkw1ff4u4TT9e9bsslSp1ob0lP29G+3vlsC5Cx4lnKCqfxGLqD/LHuevo8ECWyiWdXQ7C9IuL+wU3dHCYYyJKWzNZVoPjwNkMsamwxD8LNuPghpTiruz4uOz4AxV+WsxAlP3bs04GLNUJ1Pc1wmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775250122; c=relaxed/simple;
	bh=OiLcugNzhOcn3+ZqTqNHyFc+1w+Of5vLCmgFDm/2EwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpTug87Wa+viwaWm6eYNSMcVxeulCfOU7dx9fcjIwWDMS+s82xRGKhi0LSeYJ9lmfJapkei6kg3ixivUh0WfJVtzfr2JJxHw85C5NhXW6TPPi/gM7eujeDM1owuhkRlIl9egT4iqZrTtTmleoy1Rm+60Hv+i9wwsN+CghUyooB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Ra07SwbT; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 5489E60251;
	Fri,  3 Apr 2026 23:01:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1775250118;
	bh=Bik4T78PiVQ6FVf5qYxp+z3Qx6Y8fK8iKEYDKmRuU0M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ra07SwbTcDgF/6SfYn5ARiLngAbIomIrg2hBExbZ4dCq4Uzicc6O/8/uNSC7Iggt1
	 n/Bhk9YW76SH8Y/u7OgT4cef50decbZTX9TPO8Ip9VcpUW6kD5/06c68CIjpyHiQjx
	 0Rzn4YRuCIAyxI6QV21u4ESbR5KXvQEIYMe8nNN0LmkPlIEYwcPK+BWaea0NycR0WE
	 Ggn3COvQnDjF0M884nJwJwp9zhBGadJEpGeDyAC+P5M7+x+W6/tWwHHvcSFd9UIliO
	 uKpJNByxgjBQHUDZINiLt+vCCSQfe/kZYccGXqKztkpoZjXhriGNEdLs6uEh7FtwUC
	 5r/bXzaV0pQwQ==
Date: Fri, 3 Apr 2026 23:01:55 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Marino Dzalto <marino.dzalto@gmail.com>
Cc: fw@strlen.de, netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: xt_HL: add pr_fmt, default case and NULL
 checks
Message-ID: <adAqw08ImMk32r5h@lemonverbena>
References: <20260403193929.89449-1-marino.dzalto@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260403193929.89449-1-marino.dzalto@gmail.com>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11622-lists,netfilter-devel=lfdr.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AF7D398558
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 03, 2026 at 09:39:29PM +0200, Marino Dzalto wrote:
> diff --git a/net/netfilter/xt_hl.c b/net/netfilter/xt_hl.c
> index c1a70f8f0..9434d5ca8 100644
> --- a/net/netfilter/xt_hl.c
> +++ b/net/netfilter/xt_hl.c
[...]
>  static bool hl_mt6(const struct sk_buff *skb, struct xt_action_param *par)
>  {
>  	const struct ip6t_hl_info *info = par->matchinfo;
> -	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
> +	const struct ipv6hdr *ip6h;
> +
> +	if (!skb)
> +		return false;

No skb !?

This codebase is frozen, I don't see any benefit in this update.

