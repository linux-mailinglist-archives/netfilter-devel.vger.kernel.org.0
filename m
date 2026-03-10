Return-Path: <netfilter-devel+bounces-11093-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHCwKSA8sGmohQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11093-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 16:43:28 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C58253D0C
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 16:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 243E4300D1F9
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 15:40:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF94E30FC1A;
	Tue, 10 Mar 2026 15:40:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0786C28640B
	for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2026 15:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773157234; cv=none; b=PiEspxq4IwpcHB5mABoEiNNZ7QMa954186r0ZSVs8EKu0yTwIK+fx11++Jj2tUtC4FKCa2Ii50LA8F9d9jeNCuSE25hLIY5fX83sIXJacwzn7GXV4D++osvFST9vTjgQaaVzcGtg6fQwNrOmKEo5Jye1e/zlIs7/ZPtDwpSY4mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773157234; c=relaxed/simple;
	bh=3Gqwj8ROl4IwoEhT3Nbs7D2dB2rXE+QoF6TP2IPtC4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IKlT4HqjQfM5hJShSYzw+mYHkP4uVq8UwaJVu6MczcpcqLkC0h3nruUQJlsoYeajcclsKRdwGMonmgFqn3vGD2lXGGsKK5FAAZJ+gHIlRqKZ3WlSJE2Zmp75yJv7cuKceQntj3DZA0R95DzIR3SanQRUMnC8FYtR64gmLxsCZgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D219060516; Tue, 10 Mar 2026 16:40:30 +0100 (CET)
Date: Tue, 10 Mar 2026 16:40:26 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v19 nf-next 5/5] netfilter: nft_chain_filter: Add bridge
 double vlan and pppoe
Message-ID: <abA7anfac6z0q3HH@strlen.de>
References: <20260224065307.120768-1-ericwouds@gmail.com>
 <20260224065307.120768-6-ericwouds@gmail.com>
 <76b3546a-37c5-4dab-9074-4df0cbe48524@gmail.com>
 <abAOwZDmHjcLIbj1@chamomile>
 <f69a9456-5047-4044-aa8d-1bad3bd81f4b@gmail.com>
 <abAcBtV9WbEIDgCt@strlen.de>
 <58cc080e-1e55-4a51-8c3c-16d6b87794b2@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cc080e-1e55-4a51-8c3c-16d6b87794b2@gmail.com>
X-Rspamd-Queue-Id: 44C58253D0C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-11093-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.977];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Action: no action

Eric Woudstra <ericwouds@gmail.com> wrote:
> For me, most is known, as it is probably not very different from other
> places using patchwork.
> 
> What was new and unclear were the AI generated reviews, and what is
> expected in response of them.

Ok.  Basically they should be treated like any other review/comment.

netdev maintainers do pre-filter the AI reviews, to avoid garbage
from hitting list.

In case the AI review is nonsense, just say so.
Same for reviews that might make sense but enter bikeshed territory,
you can always push back, no need to fix up everything.

Just like with human requests [ albeit, if maintainer tells to
'do x', its a bit harder to push back of course 8-) ]

