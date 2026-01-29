Return-Path: <netfilter-devel+bounces-10496-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBGdELwxe2kVCQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10496-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 11:09:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5083AE664
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65071300D97D
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 10:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA36F37F8C1;
	Thu, 29 Jan 2026 10:08:57 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863DD3803DD;
	Thu, 29 Jan 2026 10:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769681337; cv=none; b=jeN/qkQoGiNaXejrUaAQdKBy6s3GbaC49VaB8rhXJHEqpCYQ0EP0ubz1ScDL7wYNDTN/QZJtjnJO0qa0e/8jXq/IKJ2wd5RRS3Pay620Vta7nUTm/nkzNPt+QTlvgCLZ2oIPiBMlkOSeYd0AHV680Y0p90G3Oxmxz4G/Sg+iDQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769681337; c=relaxed/simple;
	bh=llqbl1StBfL0xh5LU1kWvQbwuFYFuUEBq6UQdB4VAC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kPVjrG+pQpr8t+6mGyqqtR4pYanKefxc9DAGjbYh52wEDZ6DVJszh2/NhVlwiZ0gkscLcnCUWwpkf+Rx0wXorELWsnYu+SW24WotWvhQS7Wzato+VLjPApCxvUv/YWlKVkp3yIpOMERETwxs+ErlTWsyMICXdLB9EOJV9qt3hZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 45F8360516; Thu, 29 Jan 2026 11:08:53 +0100 (CET)
Date: Thu, 29 Jan 2026 11:08:47 +0100
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, netfilter-devel@vger.kernel.org,
	pablo@netfilter.org
Subject: Re: [PATCH net-next 0/9] netfilter: updates for net-next
Message-ID: <aXsxr8KQGFOhnLIa@strlen.de>
References: <20260128154155.32143-1-fw@strlen.de>
 <20260128210313.787486ba@kernel.org>
 <aXsgxfHxTEU1_k6e@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXsgxfHxTEU1_k6e@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10496-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: A5083AE664
X-Rspamd-Action: no action

Florian Westphal <fw@strlen.de> wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> > [  580.340726][T19113] sctp: Hash tables configured (bind 32/56)
> > [  601.749973][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  601.985349][    C2] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  602.191750][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  602.555469][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  602.895890][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  603.226543][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  603.435907][    C0] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  603.569421][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  603.672454][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  603.821679][    C1] TCP: request_sock_TCP: Possible SYN flooding on port 127.0.0.1:23456. Sending cookies.
> > [  618.553975][T19316] ==================================================================
> > [  618.554200][T19316] BUG: KASAN: slab-use-after-free in nfqnl_enqueue_packet+0x8f1/0x9e0 [nfnetlink_queue]
> > [  618.554424][T19316] Write of size 1 at addr ff1100001cc9ae68 by task socat/19316
> > [  618.554600][T19316] 
> 
> Did not occur here during local testing :-(
> 
> Should I send a v2 without the last two patches or will you pull and
> discard the last two changes?

Alternatively you can also pull this:

  https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git tags/nf-next-26-01-29

Which is the same series but without the last two patches, i.e. up to
e19079adcd26a25d7d3e586b1837493361fdf8b6:

  netfilter: nfnetlink_queue: optimize verdict lookup with hash table (2026-01-29 09:52:07 +0100)

----------------------------------------------------------------
netfilter pull request nf-next-26-01-29

----------------------------------------------------------------
Jinjie Ruan (1):
      netfilter: xt_time: use is_leap_year() helper

Lorenzo Bianconi (5):
      netfilter: Add ctx pointer in nf_flow_skb_encap_protocol/nf_flow_ip4_tunnel_proto signature
      netfilter: Introduce tunnel metadata info in nf_flowtable_ctx struct
      netfilter: flowtable: Add IP6IP6 rx sw acceleration
      netfilter: flowtable: Add IP6IP6 tx sw acceleration
      selftests: netfilter: nft_flowtable.sh: Add IP6IP6 flowtable selftest

Scott Mitchell (1):
      netfilter: nfnetlink_queue: optimize verdict lookup with hash table

6 files changed, 408 insertions(+), 81 deletions(-)

