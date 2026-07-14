Return-Path: <netfilter-devel+bounces-13944-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id a/t3CLtdVmqO4AAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13944-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 18:03:07 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B100756C44
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 18:03:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=blackhole.kfki.hu header.s=20151130 header.b="IulHy6M/";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13944-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13944-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=blackhole.kfki.hu;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E780330CF732
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Jul 2026 16:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AA74A3402;
	Tue, 14 Jul 2026 16:00:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01E4A33F5
	for <netfilter-devel@vger.kernel.org>; Tue, 14 Jul 2026 16:00:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784044856; cv=none; b=LBd8xVq8k5qJSH8d8aRBUDHHagTJ7r4TzCJJkTO9j3wZiEtwq4Z3aa/N3f+XNKo03pNUymrQXOHJwwum46+77xyPBT3jVEGnkH1lG9f6Z0xTckEGGF9gNDKkGUAgQ/6jH2KyaqwBTXOEEF0SsfXR7sjhlIqMBrDFHpC/e4bnoJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784044856; c=relaxed/simple;
	bh=gcP1aNpm3ONVEMtAlO8YK7JAlIRow8P/J9l9PKgwDvg=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Zt4S0hDFB2H54XXiNMNkYEQEJgFMvL76E58QZD/Jy19zjQAw6mvXH0Tu2HSVvkUeCQE0I5gFc0PXCrbNCvuBXbuqq/9TMBX1BP83XUgxmwxIrEuYEOGH2iSQtTqmigszS3/8u51Qap8+otJDaWBG2vh25Pxc7fuWDLIvWoYCN8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=IulHy6M/; arc=none smtp.client-ip=148.6.0.50
Received: from localhost (localhost [127.0.0.1])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4h03j258jrzGFDCL;
	Tue, 14 Jul 2026 17:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1784044340; x=1785858741; bh=CU2UkeyfBB
	6dYCFaJE8ruGCG/MqU8Cw9VnY49YW2eHM=; b=IulHy6M/lQFPj/Tna872cg/gDl
	p/wWcD/RdFZCY6qEUI+R/Nt/UIpsiNeYUOoUVbq+fIygcDLlclnfCqWT6EnKDDoZ
	0BVWgTLlu0iWbvP5b6386/7MbWpAEDNAfat6CAZXfg4ZHo7+BKImBBc/hQEU9KCh
	xF2b1BayFk/LOJ0L0=
X-Virus-Scanned: Debian amavis at smtp1.kfki.hu
Received: from smtp1.kfki.hu ([127.0.0.1])
 by localhost (smtp1.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id o0RPo4KKAYwA; Tue, 14 Jul 2026 17:52:20 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [148.6.240.2])
	by smtp1.kfki.hu (Postfix) with ESMTP id 4h03j04K9RzGFDCJ;
	Tue, 14 Jul 2026 17:52:20 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id 84DC634316E; Tue, 14 Jul 2026 17:52:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id 83AEC34316D;
	Tue, 14 Jul 2026 17:52:20 +0200 (CEST)
Date: Tue, 14 Jul 2026 17:52:20 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: Florian Westphal <fw@strlen.de>
cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org
Subject: Re: [PATCH RFC nf-next 00/12] netfilter: ipset: convert to
 rhashtable
In-Reply-To: <20260714131828.10685-1-fw@strlen.de>
Message-ID: <b26c6d72-80ea-11d5-7aa4-0028d91ffd0b@blackhole.kfki.hu>
References: <20260714131828.10685-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[blackhole.kfki.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13944-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[kadlec@blackhole.kfki.hu,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:netfilter-devel@vger.kernel.org,m:kadlec@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@blackhole.kfki.hu,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B100756C44

Hi Florian,

Thank you your hard work on converting from hash-array to rhashtable! In 
the next days I'll go through the whole patchset.

Best regards,
Jozsef

On Tue, 14 Jul 2026, Florian Westphal wrote:

> Hi,
>
> This is an initial RFC patchset to convert the hash types to rhashtable.
> Main conversion is in patch 8.  First patches contain small drive-by
> fixes, patches after 8 contain further simplifications/cleanups.
> Last patch adds back the FORCEADD support dropped in the conversion
> commit (diff was getting too large...).
>
> The next step is to go through the ipset test failures and figure out
> which ones hint at actual bugs and which ones are just harmless cosmetic
> issues (that could be suppressed by tinkering with diff.sh in ipset tests).
>
> Notable likely valid remaining bugs:
> - iphash: IP: Compare sorted save and restore: [..] FAILED
> - hash:net,iface.t: Check 10.0.1.1 with eth0:
> Failed test: ../src/ipset [..] 10.0.1.1,eth0
> Warning: 10.0.1.1,eth0 is in set test.
>
> I'd like to eventually get rid of more set->lock places, remove all
> usage of rcu_dereference_protected(.. , 1), but thats not too urgent
> atm.
>
> 1) Rework ipset CIDR bookkeeping.  I had to remove this one from the last
> nf batch at the last minute because of a buildbot report. See next patch.
>
> 2) Fix a few nits in patch 1), to be squash-merged.
>
> 3) Add small wrappers for hash and bucket sizes to reduce noise in the
> actual conversion patch.
>
> 4) add and use tmtype_del_cidr_all helper to simplify the upcoming
> rewrite.
>
> 5) Use ip_set_init_comment_slow to prevent race conditions in hash ipset
> types. Add lockdep annotations.
>
> 6) Same as 5, but for remove: adds ip_set_ext_destroy_slow.
>
> 7) Add rhashtable boilerplate stubs to ipset. Initialize and destroy the
> rhashtable without ever adding elements.
>
> 8) Replace ipset's internal hash table with rhashtable.  FORCEADD is
> removed here, and added back in last patch.
>
> 9) Use plain rcu_read_lock, not _bh variants.
>
> 10) Better lockdep annotations in ipset_dereference. Add assertions to
> more places.
>
> 11) Remove the last region lock usage in ipset. Move lock responsibility to
> kadt, uadt, and flush callbacks.
>
> 12) Re-add forceadd support for rhashtable in ipset. Implement
> mtype_remove_random() to evict elements when the set is full.
>
> Florian Westphal (11):
>  netfilter: ipset: rework cidr bookkeeping fixups
>  netfilter: ipset: add small wrappers for hash and bucket sizes
>  netfilter: ipset: add and use mtype_del_cidr_all helper
>  netfilter: ipset: add and use ip_set_init_comment_slow
>  netfilter: ipset: add and use ip_set_ext_destroy_slow
>  netfilter: ipset: add rhashtable boilerplate stubs
>  netfilter: ipset: replace internal hash table with rhashtable
>  netfilter: ipset: use plain rcu_read_lock
>  netfilter: ipset: use correct lockdep annotation in ipset_dereference
>  netfilter: ipset: remove last region lock usage
>  netfilter: ipset: re-add forceadd support for rhashtable
>
> Jozsef Kadlecsik (1):
>  netfilter: ipset: rework cidr bookkeeping
>
> include/linux/netfilter/ipset/ip_set.h       |   44 +-
> net/netfilter/ipset/ip_set_bitmap_gen.h      |    6 +
> net/netfilter/ipset/ip_set_bitmap_ip.c       |   11 +-
> net/netfilter/ipset/ip_set_bitmap_ipmac.c    |    9 +-
> net/netfilter/ipset/ip_set_bitmap_port.c     |   11 +-
> net/netfilter/ipset/ip_set_core.c            |   35 +-
> net/netfilter/ipset/ip_set_hash_gen.h        | 1552 ++++++------------
> net/netfilter/ipset/ip_set_hash_ipportnet.c  |    4 +-
> net/netfilter/ipset/ip_set_hash_net.c        |    4 +-
> net/netfilter/ipset/ip_set_hash_netiface.c   |    4 +-
> net/netfilter/ipset/ip_set_hash_netnet.c     |   12 +-
> net/netfilter/ipset/ip_set_hash_netport.c    |    4 +-
> net/netfilter/ipset/ip_set_hash_netportnet.c |   12 +-
> net/netfilter/ipset/ip_set_list_set.c        |   13 +
> 14 files changed, 629 insertions(+), 1092 deletions(-)
>
> -- 
> 2.54.0
>

