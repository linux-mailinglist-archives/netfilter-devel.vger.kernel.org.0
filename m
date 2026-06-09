Return-Path: <netfilter-devel+bounces-13171-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id eF1hEnqQKGpHGQMAu9opvQ
	(envelope-from <netfilter-devel+bounces-13171-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 00:15:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD57D6647CF
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jun 2026 00:15:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G4QbA69r;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13171-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13171-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2C7530488E7
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2026 22:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A33DCDBB;
	Tue,  9 Jun 2026 22:15:19 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF923DEAD1;
	Tue,  9 Jun 2026 22:15:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781043319; cv=none; b=nmgQ03nLsu6G/y+Ak0Ucp1p/Yhldk3l/fcpXBGxO/NdRjMjsI02CcJgvfZ5Ppf5aKYbt+IDnOwSqtlULBXGeKfNZc39s48NtArIoRtno8nIdpzTS5DRAu6WX40tGFB8P5noG9ZWWkEEDPhN/2wPxHHAfotjM4Ml8yxCaB74DXxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781043319; c=relaxed/simple;
	bh=Tsi7Eid3oYjZKZqrrt1SsBzu3O+/ppa0eG8VXuOYUF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d9ElgJ0Iusskkzq5FIJfEl4kHX86P73dOal3OGVdf16cOyyJmKIlYLeldUrb7d+bnFtWd+WrCXTDV5rgjVUXs2gmzi29Ea6CZGr2ftVtZg1BrabQ0O+quMs/OfPUP+jSzQbe/DlVsFeW+vArQYieoEBVlBraS2951Dhn+9Ajey4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G4QbA69r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0C4A1F00893;
	Tue,  9 Jun 2026 22:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781043318;
	bh=JXc/IJa6zvTygittkeGvqwNmBwKvXXAouvf+JVGAfyg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G4QbA69rI5lRSCdbDw5QhxqsrSjAYiIA2HzYucRY03h3wAdKXvs10wUAxnVzAemWZ
	 faSXkd7+He/8XislWC2uUj/wBwGFv5I1tqVSVtjjobW9OyEcNGCVxC6GrmRvtkFbBx
	 R8T1tI+ZlwlyDc473reKeLKkWICGRrLKXjjg8Be4/8FdzHLRGUpuS89dd2RD+pRePM
	 R1sLmJ4W89g7T3bUGsYUxvLtptSNvSheFNH6tjsIiEFs+bvb9N1xr5DkJPxTdk1oiT
	 1sf30I0iDA9pUSo+pP99RES01IzoD5ehi5al7Tmk4I9ydjfP3mKY2BZ5BtT0nI53M6
	 FKwx1W1bBfBMg==
Date: Tue, 9 Jun 2026 15:15:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: dummy: add phony ndo_setup_tc stub
Message-ID: <20260609151517.186b1cac@kernel.org>
In-Reply-To: <20260609142813.9197-1-fw@strlen.de>
References: <20260609142813.9197-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13171-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CD57D6647CF

On Tue,  9 Jun 2026 16:28:09 +0200 Florian Westphal wrote:
> Unlike netdevsim, dummy is a data sink so no capabilities (e.g.
> u32-style matcher, vport device redirects, PPPoE header push/pop etc).
> have to be implemented.

If no "peer" is configured netdevsim is also a data sink.

We added netdevsim because dummy and veth started accumulating
"features" which were clearly just for test harnesses. Would be
great if we could stay the course and put whatever changes you
need in netdevsim, even if it requires some hacks.

Is there anything fundamentally blocking the use of netdevsim?
Or is it just convenience (since netdevsim is a bit of a PITA
to create and establish the name of)?

