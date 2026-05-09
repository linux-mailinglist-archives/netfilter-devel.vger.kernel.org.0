Return-Path: <netfilter-devel+bounces-12517-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOcpO6rr/mmMzgAAu9opvQ
	(envelope-from <netfilter-devel+bounces-12517-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 09 May 2026 10:09:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 719E84FEA55
	for <lists+netfilter-devel@lfdr.de>; Sat, 09 May 2026 10:09:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 901CB300CC02
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 May 2026 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B19336AB77;
	Sat,  9 May 2026 08:09:12 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF71E18C933
	for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2026 08:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778314152; cv=none; b=Dkgch+aHmiH+kTyw18ZBpILI5YtbGv3kLJnhdv+z33AmuJPzKoR0edmCwGz8bRcWgPjr0Rn/8EOZo54THv6qi4/n1s4BcYFW+zhN8Zf6xo7mF2AfBOmaGklZccKuQTkykV0iv8ph+m15OaX7051bmpryDKIkEOxa22zWPWA2mV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778314152; c=relaxed/simple;
	bh=EJWHKecBBQx18bkB7WVC+Ft4Vs7sffFYop4MHJWt4N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JP53n5AgtYUiymrlo0wAYPyEaDI/rv8d5tvp7/io0xd8AJOeyOPLRMlO8B56CWf3JW94YWcppwWdA8aoVHFhkET0bCt986bM42+ejwyTgUXdNTsJ3+be+ULJABMt/A3Y72h5pemEgOw4pmp7KixFNnkeVXBvS8LZlKzhH9cxViM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1154E6084A; Sat, 09 May 2026 10:09:02 +0200 (CEST)
Date: Sat, 9 May 2026 10:09:01 +0200
From: Florian Westphal <fw@strlen.de>
To: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: netfilter-devel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH v6 0/8] netfilter: ipset fixes
Message-ID: <af7rnaoD7TlglbhL@strlen.de>
References: <20260508205903.10238-1-kadlec@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508205903.10238-1-kadlec@netfilter.org>
X-Rspamd-Queue-Id: 719E84FEA55
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_FROM(0.00)[bounces-12517-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.993];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,netfilter.org:email,strlen.de:mid]
X-Rspamd-Action: no action

Jozsef Kadlecsik <kadlec@netfilter.org> wrote:
> Hi Pablo,
> 
> Here follows the new revision of the fixes for the current list
> of ipset related issues. If sashiko won't find any issues in 
> the patches themselves, then please consider applying them.

I think it would make sense to start taking the first 4 patches so we
make some progress here and Jozsef doesn't have to respin all patches.

What do you think?

