Return-Path: <netfilter-devel+bounces-13454-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MC4nAoREPGqnlwgAu9opvQ
	(envelope-from <netfilter-devel+bounces-13454-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 22:56:36 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ADBE6C14C4
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 22:56:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13454-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13454-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C753C30038F7
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 20:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883D3CEBB1;
	Wed, 24 Jun 2026 20:56:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83170367B8A
	for <netfilter-devel@vger.kernel.org>; Wed, 24 Jun 2026 20:56:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782334576; cv=none; b=OUkyPaZBXToGgUBLETEXBntgiwqW07NCnkIg9cZQ+SeDlKHtgqu7GjY8h3si7DcwVAa2UdMdFMThycGkUMgC4PReYnPXmKGYeZjjruB0jQesqTZn+jzuX3RRF2WA+w6thE+b6Yc/eMKUyqOa52X8nNY385/izeZl8Ndi18HzSkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782334576; c=relaxed/simple;
	bh=1MWgyQSySZdIpwgNL+3QyVKh4glQePN6hXtuhn2QmYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dQbw6f/4hKCNF1lylrBgLi0KhIUL5OhGWObiswfXJpcuIXYm7feIdNkTdCQMpW51Sh/H2n8yWyVZrB/SNDapAHN5X3fjJBrQFBYEupONNA6MAI1Xsja/GuZWyoEq4Dq3Vhh4TcD7sxw0OLJDiTrgmeYuSe0sVGB/2x9wDgTh/8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A117560491; Wed, 24 Jun 2026 22:56:12 +0200 (CEST)
Date: Wed, 24 Jun 2026 22:56:12 +0200
From: Florian Westphal <fw@strlen.de>
To: Stefano Brivio <sbrivio@redhat.com>
Cc: netfilter-devel@vger.kernel.org, Seesee <cjc000013@gmail.com>
Subject: Re: [PATCH nf] netfilter: nft_set_pipapo: don't leak bad clone into
 future transaction
Message-ID: <ajxEbCY0yNsrsxx6@strlen.de>
References: <20260616191938.2875-1-fw@strlen.de>
 <20260617075123.7a62e22c@elisabeth>
 <ajJUklUUmvafRVi9@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajJUklUUmvafRVi9@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13454-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sbrivio@redhat.com,m:netfilter-devel@vger.kernel.org,m:cjc000013@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,strlen.de:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7ADBE6C14C4

Florian Westphal <fw@strlen.de> wrote:
> Stefano Brivio <sbrivio@redhat.com> wrote:
> > I can try to get to this in the next few days (I would have some ideas
> > about testing, see below), but I suppose we want a fix quickly if that's
> > really the case so I'm actually fine with this, with one nit, also
> > reported below.
> 
> I don't mind, this can wait if you prefer to undo the state.

Ping.  Are you working on an alternative patch or should I send a v2?

