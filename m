Return-Path: <netfilter-devel+bounces-13569-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8VSYMJT0RGrq3woAu9opvQ
	(envelope-from <netfilter-devel+bounces-13569-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 13:05:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F6B6EC8B1
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 13:05:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=o8lzDtNE;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13569-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13569-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 489173027DB3
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 11:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77BA42B738;
	Wed,  1 Jul 2026 11:02:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E539F4219FF;
	Wed,  1 Jul 2026 11:01:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903721; cv=none; b=p3KCgX7uhSU5+FSLDmO+KT/ewXhK/yJY8qW3w7eepvoKTcX0EIhhN0d/5EkPXSDQORpiqwWhExMZKIbiZQX1/76FRYbhsMxmaUuu1ompeOsqP2jdGVZ2rz4SZ8KDtKb0G9mMGSKA7qPMIifrUoHliHx5YjC23M7ypf/yFXAgdEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903721; c=relaxed/simple;
	bh=XaYWtMGNgt5FOX7HON74P5yka1JQED5HVnel31HcEoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Da1VhmmHGg/lHK5MEmyPTTkrwJI3f4XJSy9U+LYD/5FlUB38xeFFqx8FlBho83TeE44WGC53EBtqc2eeT957Bb2RdMKUpZg4gjhthxJKpLsi4457oXNUq/1RrRZWCdWqtfDLTDsi91qfAXG3Ql1IDmttfaSmDW7ZJmQ3JM6uWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=o8lzDtNE; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 3C62760588;
	Wed,  1 Jul 2026 13:01:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782903717;
	bh=QxPuanMrXViRFbZ/7f1IxjQONUCuWhm+IzkoyoL4DB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o8lzDtNER8nYIuqXeHHb6FJZAoZ1lRZirWcx1tp/q8AMbha2SITBChlZS4ziyGKGp
	 aqyqES01Q5lveMQMsxf4YHS3Jw4XdlktfQ3j17pwDqM2nPk7cr5bvecsQsd3NNOsqP
	 iz8d1J+IPCrfZpe5tOdE9UDvq0MwE6pXnZWeEIWmT57Os/m3p9ac0rGqZakxpfhLys
	 tho6eubVUprj5Xy5SGQ/HzT6bZuzLvwFzkPwq03TYb8B3yu506Y8uyyCxQday+PDO1
	 q7E2kxxxLQEBAwDXnmMTy4mGOit3bbXxPqiKSaCE6aX/aH5VkbzxZ5WHl+yyBp/BBy
	 F7vCwrNfn/QlQ==
Date: Wed, 1 Jul 2026 13:01:54 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net 4/9] netfilter: nf_conntrack_sip: validate skb_dst()
 before accessing it
Message-ID: <akTzomC4Qz8u8teJ@chamomile>
References: <20260630045243.2657-1-fw@strlen.de>
 <20260630045243.2657-5-fw@strlen.de>
 <akS1W7XGQ3LiP0LC@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akS1W7XGQ3LiP0LC@strlen.de>
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
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13569-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,chamomile:mid,strlen.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 22F6B6EC8B1

On Wed, Jul 01, 2026 at 08:36:11AM +0200, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > From: Pablo Neira Ayuso <pablo@netfilter.org>
> > 
> > tc ingress and openvswitch do not guarantee routing information to be
> > available. These subsystems use the conntrack helper infrastructure, and
> > the SIP helper relies on the skb_dst() to be present if
> > sip_external_media is set to 1 (which is disabled by default as a module
> > parameter).
> 
> The sashiko drive-by appears real, I submitted a patch for it.
> Its not a regression added by this patch but a unrelated issue.
> 
> https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260701062922.9660-1-fw@strlen.de/

Is skb_ensure_writable() bogus here?

As you said, skb is already linearized. As for clones, they should
only happen in br_netfilter? In such case, it should be br_netfilter
that should be audited not to pass cloned skbuffs before calling the
inet hooks.

