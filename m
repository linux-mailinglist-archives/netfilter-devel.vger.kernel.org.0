Return-Path: <netfilter-devel+bounces-10847-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCqYFsb0nWk2SwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10847-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 19:58:14 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD9118B9EB
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 19:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAEE3307CE82
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 18:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09092DB7BF;
	Tue, 24 Feb 2026 18:55:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0EA2DB791
	for <netfilter-devel@vger.kernel.org>; Tue, 24 Feb 2026 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771959330; cv=none; b=BzakQkrRsWuKgzjAVCetbUpg3EYpMJiVYiXlzMofYqGoviPl4sQ0XVspIbnnK9igjssmMfWcsxPFs1TmOMiz07vyX1h21WJR27z9XTjdWCzpoGQP19FAFMgyuqKNmKUsNHhveiuioQ+LWfsT2hxT8ZjyPaQAwciT1uJliFA26Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771959330; c=relaxed/simple;
	bh=a7rQLxnfUj//FeE++ZWlDaDuPL5XQLjSb4B0GthV4HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VEbn9m+QbXb24y6wU+TXzjcqkpS9v4W9I3mWWPCB4VJuwB7vwU+2FQWAv0vm2o9KT0EneAZSn3uSBfLNeeH4fn8N1LDFb3y5TIdpOAM+JQh38Y8qixMVt0KDZXV/7KjAIibpYcnjdmMn1XVEyeYfjhRcGYjQAuswOkxVpWKwVqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 93EF0604AA; Tue, 24 Feb 2026 19:55:26 +0100 (CET)
Date: Tue, 24 Feb 2026 19:55:26 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: inconditionally bump
 set->nelems before insertion
Message-ID: <aZ30HscJe0XroBtg@strlen.de>
References: <20260224182247.2343607-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224182247.2343607-1-pablo@netfilter.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10847-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,strlen.de:mid]
X-Rspamd-Queue-Id: CFD9118B9EB
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> In case that the set is full, a new element gets published then removed
> without waiting for the RCU grace period, while RCU reader can be
> walking over it already.
> 
> To address this issue, add the element transaction even if set is full,
> but toggle the set_full flag to report -ENFILE so the abort path safely
> unwinds the set to its previous state.
> 
> As for element updates, decrement set->nelems to restore it.

While I think this patch is correct and fixes the bug, I would
prefer the one-liner from Inseo An, it will be easier to backport it.
I propose we do this:

I do a nf pull request now, with Inseos version.

Then, after that has been merged back into nf-next, rebase this patch
on top of it and apply it.

Then, in 2nd step, also rework 71e99ee20fc3 ("netfilter: nf_tables: fix use-after-free in nf_tables_addchain()")
to follow same pattern as in your patch, i.e. defer the release to the
abort path instead.  This way we have easier to backport fixes while we
establish this new pattern of adding to-be-aborted transaction objects to
the list.

Makes sense to you?

