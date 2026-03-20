Return-Path: <netfilter-devel+bounces-11318-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNErMKEsvWmI7QIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11318-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:16:49 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B8D2D962B
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 12:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6867302B22E
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2026 11:16:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA4374749;
	Fri, 20 Mar 2026 11:16:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3942C3A4F50
	for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2026 11:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774005400; cv=none; b=QdL3w+4PulxIeYUeWdPn/kywxzdAb3oMGchIcDRMYszgFxDRMoKh7yl4wNAz0kleXh1KUO+NpD5wMg7jcU0Vun8DLpOydZTBXXe7Aq0S0Gl+PbL8k1oMNmRq0rMJpszj9fMTDLAdRVZq2V0Na37Pkm9SfY2NhR67Qc4AbZdD2Ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774005400; c=relaxed/simple;
	bh=Dwi1LVulY5r2iMwUWUar8J9zLjlTg5Dmq97GvxQxsK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UUakzFq3Ox8ph/7XRonU3pzTgpz6HmVkpGKNmVbU4sWTeucWCMFjdzhWxu4IdNvQJtG+ZemMjGCYX0wotCzfFGgh1bh6qfmlLt+obpLw191B5zg/Lmm7Rn2QTht2dMRgDxfkHNOJP0ikb2Fq4CJ6pR5K0+XtEFOFXlczVxFtCsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 38AC3608F4; Fri, 20 Mar 2026 12:16:37 +0100 (CET)
Date: Fri, 20 Mar 2026 12:16:36 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Daniel Winship <danw@redhat.com>
Subject: Re: [nft PATCH] parser: Support table spec in 'list chains' command
Message-ID: <ab0slL66fr_fScNm@strlen.de>
References: <20260319133240.20143-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260319133240.20143-1-phil@nwl.cc>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-11318-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.428];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:email,strlen.de:mid,nwl.cc:email]
X-Rspamd-Queue-Id: 50B8D2D962B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> Make it possible for users to list all chains in a given table.

LGTM, thanks.

Acked-by: Florian Westphal <fw@strlen.de>


