Return-Path: <netfilter-devel+bounces-10596-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHkxMS4ugmlFQAMAu9opvQ
	(envelope-from <netfilter-devel+bounces-10596-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 18:19:42 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F41FDCAE9
	for <lists+netfilter-devel@lfdr.de>; Tue, 03 Feb 2026 18:19:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 60DE130263E8
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Feb 2026 17:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041473EBF15;
	Tue,  3 Feb 2026 17:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="J2yL/5pO"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EB22126D
	for <netfilter-devel@vger.kernel.org>; Tue,  3 Feb 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770139134; cv=none; b=cGYjv/67I0geBSrxYPkCqob9g6BeGhkp32ErIMY1M8NbkzSuayyeE3fXmV8eOETeQo9iScOiymaUZB02mU7lWMqD/5p4G8JVYt8M1Q8MWaj/OEP9Jd5VrxWCWzvdwWK9YuCrbQBtK07nAY+B6b6DIIuWlKWD5DKkzDTpZPpgwKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770139134; c=relaxed/simple;
	bh=5PPi+eJmcKEjAKBWrlT5N5cgCtnwHEbad+MhXJh7LmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WaYAvcALW93Umil1f+96w0xo4FFKNc7uegtbsVZp/a2Wsv8Szj4aIIJN1aAuNFoUgTnxHq0qjP3kFHdbpDhkbxjtxgOsVH6FhaV+/M7Zc/1l1Ebrlt3G0YXSYZARcsHX4KIw6xKpJwycwIBVDi7YTH2iUAS6OwThnCavvlVVvXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=J2yL/5pO; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EVbpP9FVGMVt8AI76qtlMTVB0+bZqhn3N5fNmuG5b2U=; b=J2yL/5pOjV6O11WkBoB5zcwK/b
	/onvc2OXCyWnk2GgtxUTLw8kyYT/wfa0gT5mUQsQAfX3w2clX5yptqw2lCoYbK5yvWDPTC3TcSN0B
	TwWIO3tEq72BuukHeYvnQpnrXJzl5Cj6gPTU0VyX/ePT7lrHAjwQQzOLg41ghhZla90/Od8Ta6y3P
	luNFFpwG5FS/VA9F8rQDQVr8N8rbo2hZZaRvCTB1CcLxSCqAx3wEJ+o+cqktaISlasDtvqbeeXFv3
	pL98+ceWz3rahK3el2m6RcafNuE0sHfS613me05RPs4D1kzbAmlLGdgtt2KIi3DpMCX2jgKetkpQd
	KLuwuLwA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vnK32-000000004FS-3Gh8;
	Tue, 03 Feb 2026 18:18:44 +0100
Date: Tue, 3 Feb 2026 18:18:44 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [libnftnl PATCH 1/2] Revert "udata: Store u32 udata values in
 Big Endian"
Message-ID: <aYIt9IC8cepwJsq7@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20260129140707.10025-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129140707.10025-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10596-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[nwl.cc];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nwl.cc:-];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.981];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2F41FDCAE9
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 03:07:06PM +0100, Phil Sutter wrote:
> This reverts commit f20dfa7824860a9ac14425a3f7ca970a6c981597.
> 
> This change to payload (interpretation) is problematic with package
> updates at run-time: The new version might trip over userdata in the
> running ruleset, avoid this.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.

