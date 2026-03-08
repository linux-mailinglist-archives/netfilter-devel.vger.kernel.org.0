Return-Path: <netfilter-devel+bounces-11038-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0D09HpVSrWnN1QEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11038-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 11:42:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B54E22F5A5
	for <lists+netfilter-devel@lfdr.de>; Sun, 08 Mar 2026 11:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF2C230180BD
	for <lists+netfilter-devel@lfdr.de>; Sun,  8 Mar 2026 10:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EE536CE02;
	Sun,  8 Mar 2026 10:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="cTbB+nKV"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E8C32573F;
	Sun,  8 Mar 2026 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772966510; cv=none; b=fb0PnCUw5A2sIX70Hei1ep23nP9hoZ5AZKYlkE0ryzbJXlfVbKIpMOUyD20iXYsSFg0ezx2dvIfDi1MeY14vR/tG8VLE1sit8eMb9uvpWfxqBOhyuzJMDnUV22T6pQm9g2wRrSofmiuBA8q4wru93rJEZGgbUuErBxRedqF+AOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772966510; c=relaxed/simple;
	bh=ortrsBw1OkgZU3vWIo5P30ZCjQ2u4dJ36pPvVXaw1lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rrAxKKX2/TM26zLLpAQ2SYnxhRFy7px2eG8Vos1JDxt3HY4wxkcvqaXdqqGy7sgwJ3GuB35RZlypaDJ0dhkaRYeU28dPThHXRc0thVpYjJm6gN6IHtPl+wqf5xe3YH4nbiBbo7gMpxxF8yvwJSeJc5t10289Ho4UaBL1hTSwOqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=cTbB+nKV; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id AC510603A7;
	Sun,  8 Mar 2026 11:41:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1772966505;
	bh=ZCra7hLXVN4S+alXxXHaAOV1+1z40y47V8bccJwtIkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cTbB+nKVOA3a9eFgAFYI990Rj9iIZaFci2259Y4bPunHgS3roWucUpt+0GJpTc6lG
	 Xx9b7lJ1K5KUSH3WJKJk2HCDKpCuEW52SkfBY78VmLhKrkqfwq+YSUmhCv1K91emjD
	 xc2B5vgavatU443H2t+ysgsjHISr/L0hJc+EL0PtEuseNpG0n7v6Fw0whNkI8aLXwh
	 ORm2o+9IeNAy/YxKmQrac131N+LeglZOQIMLLp4Kk9KNeCp7Yl8j9hzuhQ9o7porNr
	 8WoRRdDRDlBFpRH10oXN7zHS2jolgBLx8DThJj51xnDuWiFNrPuYXZjt14UrzVMbTJ
	 ZmJRNH+AqtjAA==
Date: Sun, 8 Mar 2026 11:41:43 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: fw@strlen.de, phil@nwl.cc, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <aa1SZwjQZ1Fbsj_e@chamomile>
References: <aaxe-uH2Qr6qM4E9@v4bel>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaxe-uH2Qr6qM4E9@v4bel>
X-Rspamd-Queue-Id: 1B54E22F5A5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11038-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.933];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Sun, Mar 08, 2026 at 02:23:06AM +0900, Hyunwoo Kim wrote:
> flow_action_entry_next() increments num_entries and returns a pointer
> into the flow_action_entry array without any bounds checking.  The array
> is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
> but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
> require 17 or more entries, causing a slab-out-of-bounds write in the
> kmalloc-4k slab.
> 
> The maximum possible entry count is:
>   tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21

There is no hardware offload for the:

- tunnel support
- IPv6 NAT

This is all very hypothetical.

> Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
> worst case.
> 
> Fixes: efce49dfe6a8 ("netfilter: flowtable: add vlan pop action offload support")
> Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> ---
>  net/netfilter/nf_flow_table_offload.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
> index 9b677e116487..e843f6d0355e 100644
> --- a/net/netfilter/nf_flow_table_offload.c
> +++ b/net/netfilter/nf_flow_table_offload.c
> @@ -727,7 +727,7 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
>  }
>  EXPORT_SYMBOL_GPL(nf_flow_rule_route_ipv6);
>  
> -#define NF_FLOW_RULE_ACTION_MAX	16
> +#define NF_FLOW_RULE_ACTION_MAX	24
>  
>  static struct nf_flow_rule *
>  nf_flow_offload_rule_alloc(struct net *net,
> -- 
> 2.43.0
> 

