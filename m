Return-Path: <netfilter-devel+bounces-12660-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMYOGqwWC2o5/wQAu9opvQ
	(envelope-from <netfilter-devel+bounces-12660-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 15:39:56 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F3EF456DCB8
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 15:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 724A23038D2D
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 May 2026 13:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BF043D50F;
	Mon, 18 May 2026 13:39:31 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DCF3F44CF;
	Mon, 18 May 2026 13:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111571; cv=none; b=qwkWBWeEMXfCTz9ppGjx11IKRMBeVo8KuOfCVpBeOS+PjliQmGmIUYyqHZUricKaD1uuNFnwyNVR2SZlg8wVENc6IpMV4bZyci818yZZ7lI52AggZei7IPMqKXjxdttpQtlBxd1ad81VjO8rBNWizlZFbQaqglaLERxTvPsXAAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111571; c=relaxed/simple;
	bh=Hir8hmBKYGNMjJzZBtqB1RYzJK/DlWgUxnz/DMurzv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tVnNC6ITRyHibQq8iP59F6DkREgVvcOjCE/ZjJFfqUYppbUb0LF+d9lSirajduj28PKIiOXtoSdcFOojQxO8kUjbmOrbKuU2iYJfyq/LkAK1JzdoLAMOlzQ6dfoaYqKB0kq+6p7hWz8+VZ850Lss7g08rY7MQcC+QMD5W2dvLIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 8E56B607E9; Mon, 18 May 2026 15:39:21 +0200 (CEST)
Date: Mon, 18 May 2026 15:39:18 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Qi Tang <tpluszz77@gmail.com>, netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org, herbert@gondor.apana.org.au,
	michael.bommarito@gmail.com, lyutoon@gmail.com
Subject: Re: [RFC] netfilter: disable payload mangling in userns
Message-ID: <agsWhgktcApPkJY7@strlen.de>
References: <20260515100411.3141-1-fw@strlen.de>
 <20260515114848.1105927-1-tpluszz77@gmail.com>
 <agcWBZNugohelNp6@strlen.de>
 <agr9ry_EKdTfgoaj@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agr9ry_EKdTfgoaj@chamomile>
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-12660-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F3EF456DCB8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > I think we have to update nfqueue to do rudimentary header revalidation
> > and drop the packet on failure, e.g. at least making sure tot_len is not
> > past skb->len.
> 
> Agreed, nfqueue has been there for long time and such parser would
> validate the packet is correct from stack POV.
> 
> But if a new function to validate that the IP header mangling is not
> valid is feasible, then why not simply apply the same sanitization
> from inet hooks to nft_payload/nft_exthdr?

Ok, I will have a look.  Thanks for the feedback.

