Return-Path: <netfilter-devel+bounces-10841-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UIoiMMSfnWlrQwQAu9opvQ
	(envelope-from <netfilter-devel+bounces-10841-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 13:55:32 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5983018745D
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 13:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E284630D924C
	for <lists+netfilter-devel@lfdr.de>; Tue, 24 Feb 2026 12:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86F239A7F9;
	Tue, 24 Feb 2026 12:52:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991F9376471;
	Tue, 24 Feb 2026 12:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771937544; cv=none; b=cmHSm23Ya+A8L92dO60f34uywh5Vae4bvpni1mpzXjpyLJ/88AFlt6k10YuqdIzR4O3SP6neEOUfpl+/OLEyfPTwEKv7No6TCdbUS6oYVWXPt71Nbs1sgIOOepit+Gt41+P48XDV4eqMTxHYqUc2XzrD4sK/mwAlUBxRoEAY6x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771937544; c=relaxed/simple;
	bh=kxHueJRntiA0k5kX1bYXk2d2IybvnLE5gdzrheyoBmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dGrBvafeyudPrpSMrSG/ytBC52awT9Wr6eJ+ftbPmaF/2WCyJrwVvVfM2gb8BgC/Nfp7tpI+PG4l56W72Z/GD2tIgWlMq0IuCZ9R2JlXI7iBWBm6ogXAhf3XqSPEmVNss752Usqb1FYv6M00FRWCw4/6o4RJT8QkQpTjTOQ4IA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2341A60336; Tue, 24 Feb 2026 13:52:20 +0100 (CET)
Date: Tue, 24 Feb 2026 13:52:19 +0100
From: Florian Westphal <fw@strlen.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH net-next] netfilter: xt_owner: no longer acquire
 sk_callback_lock in mt_owner()
Message-ID: <aZ2fA2x5nHsnQoBu@strlen.de>
References: <20260224122856.3152608-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224122856.3152608-1-edumazet@google.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10841-lists,netfilter-devel=lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,netfilter.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: 5983018745D
X-Rspamd-Action: no action

Eric Dumazet <edumazet@google.com> wrote:
> After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
> from Sebastian Andrzej Siewior, apply the same logic in mt_owner()
> to avoid touching sk_callback_lock.
> -	read_lock_bh(&sk->sk_callback_lock);
> -	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
> +	/* The sk pointer remains valid as long as the skb is. The sk_socket and
> +	 * file pointer may become NULL if the socket is closed. Both structures
> +	 * (including file->cred) are RCU freed which means they can be accessed
> +	 * within a RCU read section.
> +	 */
> +	rcu_read_lock();
> +	sock = READ_ONCE(sk->sk_socket);
> +	filp = sock ? READ_ONCE(sock->file) : NULL;

Thanks for doing this Eric!

Minor nit: rcu_read_lock is already acquired from nf_hook() helper, so
we aleays have it in both iptables and nftables.

Reviewed-by: Florian Westphal <fw@strlen.de>

