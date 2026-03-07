Return-Path: <netfilter-devel+bounces-11035-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGwmINR2rGl1pwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-11035-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 20:04:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE21622D519
	for <lists+netfilter-devel@lfdr.de>; Sat, 07 Mar 2026 20:04:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A4F663009F2C
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 Mar 2026 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C7B36E484;
	Sat,  7 Mar 2026 19:04:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B210A4A02;
	Sat,  7 Mar 2026 19:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772910285; cv=none; b=C8HOXkzv7uy5CHZgnV/MIhjCEYUkTWb2FGZaysq15GmkyNkDFpEWb/ajQIMcUEasRxN+ngf7m4TQPqkr2dE1opC8hxRXamehrLNkIhhFsaW47TxQsGQ35gTxXnMQN27o+Lcu86yvWjYVrQdZUAp/INML4mrhVKPoUI0/6YKGkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772910285; c=relaxed/simple;
	bh=isRIRvojdCPEIN1P0UCOUyVaqbphb78UW84CAW2Jm7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxG2gFp2YuY7iGiismyQG4c9wIoclORC/uvO3oGijQiyQgMgb+g0Re+yxT3+8SgJFdJnuKIjFIxGALTVZaMhMi9EEOLenNeBFh6zX7A3JmZOHfDa9lBVTMWiTvqsSI1HALz149t6F269ZesEpMJpi0jeB7F7G+TR8hPE7sgOYE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id CDFA06077F; Sat, 07 Mar 2026 20:04:41 +0100 (CET)
Date: Sat, 7 Mar 2026 20:04:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow
 in flow_action_entry_next()
Message-ID: <aax2yZtJce0d19gd@strlen.de>
References: <aaxe-uH2Qr6qM4E9@v4bel>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaxe-uH2Qr6qM4E9@v4bel>
X-Rspamd-Queue-Id: CE21622D519
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-11035-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.326];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Hyunwoo Kim <imv4bel@gmail.com> wrote:
> flow_action_entry_next() increments num_entries and returns a pointer
> into the flow_action_entry array without any bounds checking.  The array
> is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
> but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
> require 17 or more entries, causing a slab-out-of-bounds write in the
> kmalloc-4k slab.
> 
> The maximum possible entry count is:
>   tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21
> 
> Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
>  
> -#define NF_FLOW_RULE_ACTION_MAX	16
> +#define NF_FLOW_RULE_ACTION_MAX	24

This fix looks rather fragile.

What guarantees that this stays right-sized?

Can you add a BUILD_BUG_ON or if needed, run-time check?

