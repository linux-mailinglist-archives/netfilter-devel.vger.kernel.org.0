Return-Path: <netfilter-devel+bounces-10720-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nW2/EOBwjGn6oAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10720-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:06:56 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B96212413F
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 13:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78E06301386E
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Feb 2026 12:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0F63254B8;
	Wed, 11 Feb 2026 12:06:52 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE35320A0B;
	Wed, 11 Feb 2026 12:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811612; cv=none; b=jb7x6Zo86vAX6wwmFgLi0WkQ2PHPSZeH0B4nLqQMwawyPXRwiXsXz6unzNptjzFOAzJh9MtSA+jV4IOX9Q48o1udR78TZO+6yEcPEDbh+nT19EvstxhbcoGtnypMk7sKesKUqtSYjONvpjtO4Z90EFbhyPfO88t5p/oQYpLdPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811612; c=relaxed/simple;
	bh=Rg45E007GuMvd+6JmDtys+sRW/yIwziqpIB/CqghpBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLp8StKOSezEWMKjHUZCksQ6Vdm7vJYnLN9qnM2vqkJlmhwttvOC8QF7C5NLkhGUXeebmeIc7k3aMcIlQ1m18y+YE30jX/7Nu6SEp0tH39Dt2SUkhGChdfhfNxT9FHd0vuGIOCB5cjN1nCq0lW1x4pQMZjq9StkS9D4x/qIE6oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A81C5605E7; Wed, 11 Feb 2026 13:06:48 +0100 (CET)
Date: Wed, 11 Feb 2026 13:06:48 +0100
From: Florian Westphal <fw@strlen.de>
To: Shigeru Yoshida <syoshida@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	syzbot+5a66db916cdde0dbcc1c@syzkaller.appspotmail.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH net] net: flow_offload: protect driver_block_list in
 flow_block_cb_setup_simple()
Message-ID: <aYxw2CpxOKLh1wOz@strlen.de>
References: <20260208110054.2525262-1-syoshida@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260208110054.2525262-1-syoshida@redhat.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10720-lists,netfilter-devel=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,5a66db916cdde0dbcc1c];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 8B96212413F
X-Rspamd-Action: no action

Shigeru Yoshida <syoshida@redhat.com> wrote:
> syzbot reported a list_del corruption in flow_block_cb_setup_simple(). [0]
> 
> flow_block_cb_setup_simple() accesses the driver_block_list (e.g.,
> netdevsim's nsim_block_cb_list) without any synchronization. The
> nftables offload path calls into this function via ndo_setup_tc while
> holding the per-netns commit_mutex, but this mutex does not prevent
> concurrent access from tasks in different network namespaces that
> share the same driver_block_list, leading to list corruption:
> 
> - Task A (FLOW_BLOCK_BIND) calls list_add_tail() to insert a new
>   flow_block_cb into driver_block_list.
> 
> - Task B (FLOW_BLOCK_UNBIND) concurrently calls list_del() on another
>   flow_block_cb from the same list.

Looking at the *upper layer*, I don't think it expected drivers to use
a single global list for this bit something that is scoped to the
net_device.

As drivers do use shared lists everywhere I think this fix is correct, so

Acked-by: Florian Westphal <fw@strlen.de>

