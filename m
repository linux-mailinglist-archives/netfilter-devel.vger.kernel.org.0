Return-Path: <netfilter-devel+bounces-10968-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPMwM6MzqGm+pQAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10968-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 14:29:07 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9052006C1
	for <lists+netfilter-devel@lfdr.de>; Wed, 04 Mar 2026 14:29:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FADF300DD7A
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Mar 2026 13:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81336AB4A;
	Wed,  4 Mar 2026 13:28:27 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42168351C12;
	Wed,  4 Mar 2026 13:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630907; cv=none; b=p911b0WVH4gr1yazWFsFA/7lgEsshB2fZPyLTzPNfTMMMLrtpw2VwXxrMoWNa/Drts6uhcY155l6Rsn7/b5Lgb7vOiR7TjC1+0Od5bqIhXlGxnQbL086z8T8pCaZztJ3OQjALDHUm4huTtUCU9fB011cGWQM5RPRCpnceBImjBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630907; c=relaxed/simple;
	bh=ulwdWRUfQaAJ5xq3e9RTDZMiKLOgG0zzZcyZRZa68Hw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ezJsAAVQ8XjTz07+38/2DElEds9z/JBBNhx3CsmI+wm5l/vvqpVvb05WdKgYASYFvn5Wh/2AlafAOlFYg0lxNEgNZ3rsZAW0520eJqu6KVHdMQym6gK7kaaYjhQJOUfslnhO76uzEu/kiqBflc3JSSySlH1S80SkLmuLjfVfxoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 1429160D34; Wed, 04 Mar 2026 14:28:24 +0100 (CET)
Date: Wed, 4 Mar 2026 14:28:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>, Pablo Neira Ayuso <pablo@netfilter.org>,
	Helen Koike <koike@igalia.com>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-dev@igalia.com
Subject: Re: [PATCH] netfilter: nf_tables: fix use-after-free on ops->dev
Message-ID: <aagzeEIkk1v4OmJk@strlen.de>
References: <20260302212605.689909-1-koike@igalia.com>
 <aaYYiPTO5JYOlhhY@chamomile>
 <aagqaq6LNJnrg8eC@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aagqaq6LNJnrg8eC@orbyte.nwl.cc>
X-Rspamd-Queue-Id: 4C9052006C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10968-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.944];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nwl.cc:email,strlen.de:mid]
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> But isn't __nf_unregister_net_hook() still called immediately when
> handling NETDEV_UNREGISTER event? I guess struct nf_hook_ops::dev may
> still be accessed afterwards since ops is RCU-freed. Is Helen's report
> inaccurate in that regard?

Its a red herring.

The device is registered twice.  But UNREGISTER only removes ONE
instance.

Then, later, when a different device (same name!) invokes netlink handler,
the walk finds the old, free'd net_device.

I hacked UNREGISTER to handle this: no more splat.
I reverted this change and altered REGISTER to never allow
double-register: no splats.

