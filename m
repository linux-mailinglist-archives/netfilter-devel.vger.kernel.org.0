Return-Path: <netfilter-devel+bounces-12750-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO35MijoD2q5RQYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12750-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 07:22:48 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2349E5AF167
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 07:22:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73EFB3028024
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 05:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C193B392806;
	Fri, 22 May 2026 05:20:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967D6391851;
	Fri, 22 May 2026 05:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779427204; cv=none; b=HCuqd2AvYCEGMESesjq4qrkomC7NruOZfKzPII8rKZ2dr6lLASx0VSB3dhKHkFvEEbegT88iF3kVIJPJwBJ7IEQnPX6rxrMr4EPX6i8Z+aE0DxYTerSlw82ZBgQ5AaAl96ambLqHwO/SqygvIvGtzYJjTYZhIC14B8dN4YuxWAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779427204; c=relaxed/simple;
	bh=d94ENTgaahbOkQMH8t51whIljGLTrs4yR5S2GWvbB8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjTzYlRe8SD31RSNtVLlybYYTgoQ5EdpU7kbKanCB1cnDB5MJYViyfRiuQUWskI/whyAUlEODmd+BICGn18PHPKazQqRLfEh9wMxNa70primHA47CZtQAtMynylylydy9e2BsTY63G3RJEck+UMv+f8xjnzEPjts6N8F4Q5dmU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 10C4760345; Fri, 22 May 2026 07:19:58 +0200 (CEST)
Date: Fri, 22 May 2026 07:19:56 +0200
From: Florian Westphal <fw@strlen.de>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Simon Horman <horms@verge.net.au>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Julian Anastasov <ja@ssi.bg>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	lvs-devel@vger.kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org
Subject: Re: [PATCH v2 net-next 2/2] ipvs: Replace use of system_unbound_wq
 with system_dfl_long_wq
Message-ID: <ag_nfJAqqBkZi2dy@strlen.de>
References: <20260515135143.259669-1-marco.crivellari@suse.com>
 <20260515135143.259669-3-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515135143.259669-3-marco.crivellari@suse.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-12750-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,verge.net.au,google.com,davemloft.net,redhat.com,ssi.bg,netfilter.org,nwl.cc];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid]
X-Rspamd-Queue-Id: 2349E5AF167
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Marco Crivellari <marco.crivellari@suse.com> wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> This specific work is considered long, so enqueue it using
> system_dfl_long_wq instead of system_dfl_wq.

While 5522d65d81a7 ("ipvs: avoid possible loop in ip_vs_dst_event on resizing")
is now in nf-next, this patch doesn't apply (anymore):

git am -s v2-net-next-2-2-ipvs-Replace-use-of-system_unbound_wq-with-system_dfl_long_wq.patch
Applying: ipvs: Replace use of system_unbound_wq with system_dfl_long_wq
error: patch failed: net/netfilter/ipvs/ip_vs_ctl.c:800
error: net/netfilter/ipvs/ip_vs_ctl.c: patch does not apply
Patch failed at 0001 ipvs: Replace use of system_unbound_wq with system_dfl_long_wq

Would you mind sending a new version? Thanks.

