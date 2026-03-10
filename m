Return-Path: <netfilter-devel+bounces-11073-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEp+BzT6r2mmdwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11073-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 12:02:12 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FCC249E46
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 12:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A690631BD0CB
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 10:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F6A3803CD;
	Tue, 10 Mar 2026 10:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="lPBC1fQg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB213359A79;
	Tue, 10 Mar 2026 10:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140169; cv=none; b=UbnhTfXPoC3XaBOenuefHONORP6+leRPdOUw9zQxcxfI9C3kr71fdwJJYrM68P5Fx5a+W8MGrCsAoOJxXiOpIFpqh+mYGoXrcRZ8onwwtETRhzoahsWcIS0eBQIXcu64juffbDZIvsWoM/YQH9hKM/XokX5s3GOZ6oSFN447q5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140169; c=relaxed/simple;
	bh=/lBp6VYdN5//ASX335M1MUGys4vfqnqUP+nzk5ncJ/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=msfvjMYcCVJvE4lmqS5F3iK2mNJLIl9XqFqQs5DyUfR2KtkQlhlC3hLLTIk2t+YcnU1k2F/uc0Og1/vG5P15j/RMxfQvHeH6KkgWVdbYFMEW3Kq4hmDmwnf+Rk/GIuuQoEKyt7MpsBVekf8Mr8Hj2iCMIHBurj52uJWu2bIGp1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=lPBC1fQg; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C2D6060255;
	Tue, 10 Mar 2026 11:56:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773140165;
	bh=gRalR8Zg/RbrupyebA9Kwn+XfaMCu2L3sLMk2ry3pJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lPBC1fQgTIwCuapu0V0jZoSorbgExKkfGhaVPiuHXPLenS8g4G/814+35N+hW4UmM
	 yYGXO4p4KHxokKTDEF+DHqSnxy6SApdtVN374dlL+gsxMjZKeGr7mAtohiGx+u8b2Q
	 bBU9XQbNtwj1ItTqQZxzrfXMGR8hGmHMFCawIOpInZZ7bE7Xwj5mrnbcFnFohFK73S
	 HwPXdqPRb9NhQee8gKbkK0fjMrnwGbObg1izP2J8odUlwqr0pHsMehN9IUKkS6z3AV
	 6HmBO7389lA+GMVNNavgyrmQsWrHHP+jugKyrxYF8fCRDllQgwxu/jYQyTE0QAI8EH
	 RtI2DQ6utuzSw==
Date: Tue, 10 Mar 2026 11:56:03 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net 00/10] netfilter: updates for net
Message-ID: <aa_4w9gXCkzQ06Nk@chamomile>
References: <20260309210845.15657-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260309210845.15657-1-fw@strlen.de>
X-Rspamd-Queue-Id: A7FCC249E46
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	RSPAMD_URIBL_FAIL(0.00)[netfilter.org:query timed out];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11073-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim]
X-Rspamd-Action: no action

Hi,

On Mon, Mar 09, 2026 at 10:08:35PM +0100, Florian Westphal wrote:
> 7-9) fix access bugs in the ctnetlink expectation handling.
>      Problem is that while RCU prevents the referenced nf_conn entry
>      from going way, nf_conn entries have an extension area that can
>      only be safely accessed if the cpu holds a reference to the
>      conntrack.  Else the extension area can be free'd at any time.
>      Fix is to grab references before the accesses happen.
>      These bugs are old, v3.10 resp. even pre-git days.
>      All fixes from Hyunwoo Kim.

I am not sure 7-9 are correct.

nfct_help() is accessed via exp->master in other existing paths,
I think these fixes are papering an underlying problem since the
typesafe rcu infrastructure was introduced in nf_conntrack.

