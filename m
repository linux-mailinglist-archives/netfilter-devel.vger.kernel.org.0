Return-Path: <netfilter-devel+bounces-11153-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OBLAcDTsmktQAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11153-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 15:54:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93341273B3E
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 15:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 439A330164AC
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 14:54:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E143F37C93B;
	Thu, 12 Mar 2026 14:54:05 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B757A37B009
	for <netfilter-devel@vger.kernel.org>; Thu, 12 Mar 2026 14:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327245; cv=none; b=Gz6KwXh74jkm02HgaJJMCJCKSrjJ/4hgqzmUwCCTmOyGEkdWGJ2YeTikv18iBHjhzNEh8Zf+YWJ08C65N2a1H3/kVJp8/Npt7kN5HKULJDo5gCd2uUgvR13SsYQv7Mo8MCNf/c6ytgYaBY9abC3d3fCdidFlTciEBkpqkpNAdYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327245; c=relaxed/simple;
	bh=6YdV9LHd6PRFBGZ4qs8kxdXrsQhI3C1rSWi852CO4iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PDDMd0mR1GwQvWs3VZV8qasgmzD41gNerlaSlXiH+x3+SOseGXRawCFhEG4KIdqY71NHMUSPsiXMq4DOZRxXx4aSjtd27ANrbVVgH+dMWeW+za2VUJaU2Loey+4F1QGcBYXEU/b4rCakqGY7TJsq09EJT2X8YtDPqUOC/9+e314=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 725166047A; Thu, 12 Mar 2026 15:54:00 +0100 (CET)
Date: Thu, 12 Mar 2026 15:54:01 +0100
From: Florian Westphal <fw@strlen.de>
To: Jenny Guanni Qu <qguanni@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org,
	netfilter-devel@vger.kernel.org, klaudia@vidocsecurity.com,
	dawid@vidocsecurity.com
Subject: Re: [PATCH] netfilter: ctnetlink: validate CTA_EXPECT_NAT_DIR value
Message-ID: <abLTiYt1Q4aZUAoJ@strlen.de>
References: <20260312144252.2985553-1-qguanni@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312144252.2985553-1-qguanni@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11153-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid]
X-Rspamd-Queue-Id: 93341273B3E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Jenny Guanni Qu <qguanni@gmail.com> wrote:
> ctnetlink_parse_expect_nat() reads the CTA_EXPECT_NAT_DIR attribute
> from userspace via netlink and assigns it to exp->dir without checking
> whether it is a valid direction value. Since exp->dir is used as an
> array index into the 2-element tuplehash[] array, an out-of-range
> value causes an out-of-bounds access.
> 
> Add a bounds check to ensure the direction is less than IP_CT_DIR_MAX.

Please see:
https://patchwork.ozlabs.org/project/netfilter-devel/patch/20260310132857.1383-1-fw@strlen.de/

We are seeing a massive influx of bug reports, and sometimes same
issue is reported multiple times.

Due to the large backlog, we are unable to provide timely
pull requests to the net tree anymore.

I hope I can make another pull request with pending patches
this Friday.

We are aware that the conntrack expectation bugs remain
unresolved.

This is because some of the proposed fixes are not sufficient
and a further audit is going on.

