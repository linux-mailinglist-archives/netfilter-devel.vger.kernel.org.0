Return-Path: <netfilter-devel+bounces-13034-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6tfpJdquIGqW6gAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13034-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 00:46:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBAB63BA56
	for <lists+netfilter-devel@lfdr.de>; Thu, 04 Jun 2026 00:46:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=jRQNGYpY;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13034-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13034-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20035300A3AB
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2026 22:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F13447D940;
	Wed,  3 Jun 2026 22:42:28 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82B63AB285
	for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2026 22:42:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526548; cv=none; b=kN1BKE3on90P5i31gjU8f7r3FGK5zdi6wHLr1/7uEyKikh+SRH5jod5hClKam8CTLOCrUCnI8XjFZzatb9SRvoQNkCjmqGG/xgHc3NKzF+RXwCBUuNYDo8m2cl94e6JA9t25XQeuRkzNTS6pQ7XdsJq4SVHletYdOAtM0hAG69A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526548; c=relaxed/simple;
	bh=r2qko1F5CB4MzOVwnUDXthYXOLxZxqwZlqSWOfo9ODk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RxSon0XL5XMMwHCdIiVFbObrjmajJFLUW1bbEjwkHKHgotA8iTZP7aRXPkQqUQRVMzybs5UhOoe7P+gS3dzlCZRANbLbUQeJwYsszRf941BI0OKgW3AzvKV0m/24QDGuJ38fk17UgdzFFkmgx2UQaENT+SmjKraeqyefTmioaI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=jRQNGYpY; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 3831460196;
	Thu,  4 Jun 2026 00:42:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780526545;
	bh=EVyiLxhmvZ+09lcI5j7UQn72plaYWRUFZf+ZOxE5MUQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jRQNGYpYQVSP8vSVyiuf1O6mruJuE6jHr9U6+gtgG0pNrlM3zNcHNMDJk0qUYut59
	 98dJLmwMVsxHiFZZa3XCUefSkjalIpycMnWItEFkdUPG+jOrCbmqRrgGW3+G69XvgV
	 4OqvbfkucQLFLynIIJDIiZoFH4PRmB2XKhnEr5XYwjoM+rar/F9k8OC2KaYHfq4ksi
	 hm+F+zOLkExegPrSKyo8o6e5VqlgceAb8TJGQKViHS+MINbBIm7F+Qo/5uE7m//D8c
	 gsPUSH9NUQh+A0Z5V7ys44jkAfF3DFfwYbFUO+hFk/1aQ/hJRU9jyepknckgQ9zfT/
	 wzQwZLzi0AswQ==
Date: Thu, 4 Jun 2026 00:42:23 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [RFC nf 0/2] netfilter: add restrictions/validations for packet
 rewrites
Message-ID: <aiCtz2nBZL1Q-gmL@chamomile>
References: <20260527121147.22076-1-fw@strlen.de>
 <aiCrpdgRNCC7LkaA@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiCrpdgRNCC7LkaA@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13034-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:from_mime,netfilter.org:dkim,vger.kernel.org:from_smtp,chamomile:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCBAB63BA56

On Thu, Jun 04, 2026 at 12:33:13AM +0200, Pablo Neira Ayuso wrote:
> Hi Florian,
> 
> On Wed, May 27, 2026 at 02:11:42PM +0200, Florian Westphal wrote:
> > This is a followup to the recent patch that disabled packet manipulation
> > via nfqueue or nft_payload in user namespaces.
> > 
> > This adds additional *restrictions*.
> > For nfqueue, do minimal header checks in case userspace provides payload
> > replacement data.
> > 
> > For nft_payload, restrict the offset/length combinations.
> > 
> > Several of these checks could be done at rule insertion time (i.e.
> > control plane).
> > Risk is that this may cause ruleset load failures for existing rulesets.
> > With this change such writes are silently skipped and packet passes
> > unchanged.
> > 
> > Restriction is added for link and network bases only.
> > 
> > Open questions:
> > - target tree: nf or nf-next?
> >
> > - should there be an immediate followup ('patch 3') that reverts
> >   the userns restrictions again?
> >
> > - should nft_payload reject those requests it can validate there from
> >   the control plane?
> 
> Ideally, better from control plane.
> 
> If anyone is breaking with ilegals field, they should come here to
> explain? Data plane validation might look safer ... but it will just
> drop packets and it will take a bit more time to the user to debug.
> 
> But your approach is more conservative, it just leave the packet
> untouch, so it is basically ignoring the invalid mangling.

Hm. Actually, it is harder than it seems to do this from control plane
because dscp needs to deal with bitwise to ensure that ihl and version
are not modified.

