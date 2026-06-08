Return-Path: <netfilter-devel+bounces-13129-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b9uUHCQ0J2oVtQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13129-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 23:29:08 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E757965AABB
	for <lists+netfilter-devel@lfdr.de>; Mon, 08 Jun 2026 23:29:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13129-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13129-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 97083304346B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 21:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D38F397339;
	Mon,  8 Jun 2026 21:26:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CABC3A874B
	for <netfilter-devel@vger.kernel.org>; Mon,  8 Jun 2026 21:26:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954000; cv=none; b=oYLj8J7ewJcbQbmb0cbYxm84LNX8Tn5YiqhLsuJqN/GBd1ugJ4LHTYYFfRfTRqQlJJTrC6egOln5P+cfQgqmjJmJLUivAju5UoBWuBJBIIjyJ/DebKMnSUCTBnZ97w1r8/SOVH8RshmDBODE/QCUp1decUi7Qj66XXkVHoAJUSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954000; c=relaxed/simple;
	bh=9jXVmbTKI0DeepACbzER2I3tWzHht9uHkxlOZtOentY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pX11UbJYcPUNaBGZNq1ZLhh8091qcn8N4GT3n7oQjB4IDojy2M5CJR2igHVvcmVU/Twy012dZC7/sj/F0EjiakmzWp34cciAoAe383disQ7Hw45ztSFew00fJMOjJ+2+74Y4wUiWQOZPxKEU5r+irjWgl/GjZmbzONA0rsgrXb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B67CF6047A; Mon, 08 Jun 2026 23:26:35 +0200 (CEST)
Date: Mon, 8 Jun 2026 23:26:29 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: conntrack: check NULL when calling
 nf_ct_ext_find()
Message-ID: <aiczgrv5J-m-7jo8@strlen.de>
References: <20260608212120.68828-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608212120.68828-1-pablo@netfilter.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-13129-lists,netfilter-devel=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E757965AABB

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> nf_ct_ext_find() might return NULL since ct extensions may be declared
> stale because of object dependencies or modules that are going away.
> 
> When helper is removed, nf_ct_iterate_destroy() unhelps the conntrack
> entries. Then, the nf_ct_ext_find() might return NULL if the extension
> is stale for unconfirmed conntracks if the genid validation fails.
> 
> Add the null check to:
> 
> - nfct_help()
> - nfct_help_data()
> - nfct_seqadj()
> 
> that call this function since packet path could be walking over helper
> while it is being removed.
> 
> While at it, fetch ct helper area in nf_ct_expect_related_report() only
> once and pass it on to other ancilliary functions. Replace WARN_ON()
> by WARN_ON_ONCE() in nf_ct_unlink_expect_report().
> 
> Fixes: c56716c69ce1 ("netfilter: extensions: introduce extension genid count")

I'm not sure this tag is correct.

The genid checks are only for unconfirmed entries, not in hash.

nfct_help() and nfct_help_data() can return NULL as you say, but
I don't see how this relates to the above commit either.

That said, I agree with the patch.

