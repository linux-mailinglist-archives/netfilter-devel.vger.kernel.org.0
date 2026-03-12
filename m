Return-Path: <netfilter-devel+bounces-11148-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iFv5E+SzsmmYOwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11148-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 13:39:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D0271E9C
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 13:38:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CE9930DACDB
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Mar 2026 12:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB693BA24B;
	Thu, 12 Mar 2026 12:36:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7481DEFE8;
	Thu, 12 Mar 2026 12:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319007; cv=none; b=LGSJn8rEeWaOYWm9fvgQxwDZUcCFZMbM3J7GxrvGOvSCZ59wLWWbwWxRfUvAjvhzc/KGjXa13lXNw3JPkeJA5aZQEUAOe6ktzLwM6SgK7y99J+sWGNtZu0cg5/JH3iYCsNA9gCuGLAO5O9X1xaAaM8qj+0Ux1aWSCWZMNAZlIcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319007; c=relaxed/simple;
	bh=aLrncpKox8OUUgw9Pi1Wd+JmkU+sBo7DO9cXcHpsdMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gai2mL+B05oz2SUqjddiAlsfb9lnEA/Y+gHepRAq/40XonmQXRIHLcTsNbesa8YqruUON8gLNPUZhfV1Xj1YrnPP+jBcBuKu+vVqFRfXEM6zOfEokNBZjQQGGLXWiX2/3Op2DXxsxp/feGxn8+KYLhoKWO3gmUxS/DC2+aLxZS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D14026047A; Thu, 12 Mar 2026 13:36:38 +0100 (CET)
Date: Thu, 12 Mar 2026 13:36:40 +0100
From: Florian Westphal <fw@strlen.de>
To: Prasanna S Panchamukhi <panchamukhi@arista.com>
Cc: netfilter-devel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net-next] netfilter: conntrack: expose
 gc_scan_interval_max via sysctl
Message-ID: <abKzWIhVz_SeiSOa@strlen.de>
References: <20260311194058.13860-1-panchamukhi@arista.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311194058.13860-1-panchamukhi@arista.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11148-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.994];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arista.com:email]
X-Rspamd-Queue-Id: C58D0271E9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Prasanna S Panchamukhi <panchamukhi@arista.com> wrote:
> The conntrack garbage collection worker uses an adaptive algorithm that
> adjusts the scan interval based on the average timeout of tracked
> entries.  The upper bound of this interval is hardcoded as
> GC_SCAN_INTERVAL_MAX (60 seconds).
> 
> Expose the upper bound as a new sysctl,
> net.netfilter.nf_conntrack_gc_scan_interval_max, so it can be tuned at
> runtime without rebuilding the kernel.  The default remains 60 seconds
> to preserve existing behavior.  The sysctl is global and read-only in
> non-init network namespaces, consistent with nf_conntrack_max and
> nf_conntrack_buckets.

This was proposed before, see:

https://lore.kernel.org/netfilter-devel/aO-id5W6Tr7frdHN@strlen.de/
https://lore.kernel.org/netfilter-devel/aRsuU57juCvsMBKE@strlen.de/

I did not hear back wrt. the horizon cache.

I'm not 100% opposed to this, but I do wonder if we really can't do
better than the current avg strategy.

