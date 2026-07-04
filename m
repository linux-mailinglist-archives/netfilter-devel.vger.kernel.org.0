Return-Path: <netfilter-devel+bounces-13650-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UgqlKxXTSGrduAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13650-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Jul 2026 11:32:05 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D967073F9
	for <lists+netfilter-devel@lfdr.de>; Sat, 04 Jul 2026 11:32:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13650-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13650-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236BE3016EE6
	for <lists+netfilter-devel@lfdr.de>; Sat,  4 Jul 2026 09:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD54399361;
	Sat,  4 Jul 2026 09:31:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5662314D15
	for <netfilter-devel@vger.kernel.org>; Sat,  4 Jul 2026 09:31:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783157514; cv=none; b=kRJrpQ/BwJ3Qu7UoFZZrt6xbixSbyDUtRDFf8NGkKZpEbbvX3Op82tP+mjPMHbJRxziNd9OhcWIHD1/va7G8wFK1ZvhEW8+w1HJe18xJ4BrUFuCtAOLNhKj0s1CLiqMuH3Vt6+SpVJzice+A0GMPuX+p6jhqMJZVXD5RYWstEcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783157514; c=relaxed/simple;
	bh=UeuMHe1e6fYelWnjGhltLGSr3YLP4D1aphM7j3xz/oM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AOAdDoxy9JrGDf6UrmU39zPM8nBEQPGekhhsIsg/etZ0PCu6jWWrqCZF8UHKn3yWkLZzh8VOv+crBY6UpwmK/wX/JzL/brO7vVwCz0BPjb407XulXwQFlQH1unme4s1OcTHOuC9rGtbz6QuQNmXdenqFOhQdBmCfsI+eTll2QxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id BD47F60491; Sat, 04 Jul 2026 11:31:50 +0200 (CEST)
Date: Sat, 4 Jul 2026 11:31:50 +0200
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/3] netfilter: ebtables: shashiko nitpicks
Message-ID: <akjTBkrO5mGCecFS@strlen.de>
References: <20260704084811.27355-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260704084811.27355-1-fw@strlen.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13650-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:from_mime,strlen.de:email,strlen.de:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31D967073F9

Florian Westphal <fw@strlen.de> wrote:
> Three academic bug fixes for ebtables, based on sashiko
> drive-by reviews.
> 
> All of these "bugs" have existed forever, kets treat this
> as cleanups.
> 
> Florian Westphal (3):
>   netfilter: ebtables: zero chainstack array
>   netfilter: ebtables: account compat ebt_table_info to kmemcg
>   netfilter: ebtables: bound num_counters in do_update_counters()

Many more drive-bys here.  I don't think this is worth our time.

I propose to axe arptables CONFIG_COMPAT in nf-next
now.

Then, axe ebtables-compat next querter and finally rest of xt-32bit compat
after that.

All the xt COMPAT flavours are already restricted to the initial
namespace.

