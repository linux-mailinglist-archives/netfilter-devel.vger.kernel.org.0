Return-Path: <netfilter-devel+bounces-11096-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBdbGNdWsGkJiQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11096-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 18:37:27 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id ED5BC255AFA
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 18:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 02DB93013A60
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Mar 2026 17:37:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C733C9452;
	Tue, 10 Mar 2026 17:37:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B423859D5
	for <netfilter-devel@vger.kernel.org>; Tue, 10 Mar 2026 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164244; cv=none; b=lMj9E0+4XyvehVJT1DxLiFiRvDlOwwWQYqepJYScRRENkFI+Sb5c0E22aSbk1KREbzHzUnsXK+TKZZcT7uAjNcS9eV7RQnVt8YQMHDw8LwwIUUD1JQEKJ5L14c4onZYFO8W4NYz/enExswraLCUInyqYkiOURO3u5+jZRb9sAu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164244; c=relaxed/simple;
	bh=ti0Ho/MECAHrhwSyprKlZbOGzXxq4wXFOETI6SBoIiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vBp4ZwoeV00JWTBNibInjFlgdzAEVVMWjDGXpp44vqFu6WMnFABp5KljmOAF/prPAL3tNW3bZjZKvdhBKNYNo/SPNOaSqVZZSasLuUQPUUd07LFWjYjEiKfbQgUTt53q5FFf9q97IC+sprNFQgHNdTfZOLNQxcW1LzK2vEB5c1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2FDD560516; Tue, 10 Mar 2026 18:37:14 +0100 (CET)
Date: Tue, 10 Mar 2026 18:37:14 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] xtables-translate: Return non-zero if
 translation fails
Message-ID: <abBWyuHDm7MT9JC3@strlen.de>
References: <20260310171853.26362-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310171853.26362-1-phil@nwl.cc>
X-Rspamd-Queue-Id: ED5BC255AFA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11096-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.952];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nwl.cc:email,strlen.de:mid,strlen.de:email]
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> Untranslated parts in output are easily overlooked and also don't disrupt
> piping into nft (which is a bad idea to begin with), so make a little
> noise if things go sideways:

Makes sense to me.

Acked-by: Florian Westphal <fw@strlen.de>

