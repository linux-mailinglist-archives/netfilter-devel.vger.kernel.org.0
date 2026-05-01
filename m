Return-Path: <netfilter-devel+bounces-12370-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BYZLW2C9Gn8BwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12370-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 12:37:33 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4ED4ABADF
	for <lists+netfilter-devel@lfdr.de>; Fri, 01 May 2026 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D1D5300C936
	for <lists+netfilter-devel@lfdr.de>; Fri,  1 May 2026 10:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F85386C0A;
	Fri,  1 May 2026 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="Tzw2heYN"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D3435F60F;
	Fri,  1 May 2026 10:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777631850; cv=none; b=SKbQPDZXdQoyGIlT90DuHAyN8AsViNWAXbsKcQoFuCuQoXuzy0xUpl62mzJSDC15es8uaGHGWPUq/rYhoFevnNE4unExPYSYntynn0/A81nZ/PCBmQ74bjf7srhser9VZl3RvFjKXYEQl2s2bEBXML4X0WAZy27hFG7mizQ5R8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777631850; c=relaxed/simple;
	bh=ATUhY+HzFYMwfPPJZ/gR3aY9ETi6X/NMEIaPrd6ZbvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rHWLtjGD7C0P065uvPZwjkQ1MstiFv/LONV/vg5yBJXKkujCN+0uPJGmLWSCFmdhrWDhizPG18hnypmdA3oRWomKiFkdwZ1XXopBg76sm7zqi0uG5t67+AkCJpREg5csijflkZ9ji/q9wYeXQL+Hh5G/F0PSdvuvFThSsnf6KEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Tzw2heYN; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 77A7B6026F;
	Fri,  1 May 2026 12:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1777631839;
	bh=7dL3spOjql5alNq6grQDqMFHHsofjZ+rzTkDGkjyXps=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tzw2heYNrTl4xIIjscJhnth9kLHk50Pnwpp2mOu1SUvYvcHkwJOUbv2Fthcyt+S6F
	 s7Douchn0MZ4SQNlkCRIKZlvUDj+2e1NgKA21V/19xdwCGpvFPjeUp85hKw4WFXRw7
	 pV57nsP9L6wJtu9hcQu1hnPjLInHFUFMWAou2Cfrsnv0PnzP+JpNeFuPL8Bq0hhuEe
	 jknOKrgWN+v2jPPjOLKp6BLtZmUjQVgN+3V+VvXn8pEjvW/FdATtezX60/fCYg6IIz
	 1m9wg1EbRw2G1ifh2au2Pgqc7BGvDf9WkdlWNwE8W0lH+xNew4iJPk2Ux8B101hCmG
	 CdsuepwdWkeCA==
Date: Fri, 1 May 2026 12:37:16 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, davem@davemloft.net,
	netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, horms@kernel.org,
	Eelco Chaudron <echaudro@redhat.com>,
	Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net 06/12] netfilter: nf_conntrack_expect: honor
 expectation helper field
Message-ID: <afSCXEg-X-ieL9cY@chamomile>
References: <20260326125153.685915-1-pablo@netfilter.org>
 <20260326125153.685915-7-pablo@netfilter.org>
 <8fd5d3a3-d1d7-4542-a0db-1678989940d4@ovn.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fd5d3a3-d1d7-4542-a0db-1678989940d4@ovn.org>
X-Rspamd-Queue-Id: BF4ED4ABADF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-12370-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,strlen.de:email]

Hi Ilya,

On Thu, Apr 30, 2026 at 10:58:38PM +0200, Ilya Maximets wrote:
> On 3/26/26 1:51 PM, Pablo Neira Ayuso wrote:
> > The expectation helper field is mostly unused. As a result, the
> > netfilter codebase relies on accessing the helper through exp->master.
> > 
> > Always set on the expectation helper field so it can be used to reach
> > the helper.
> > 
> > nf_ct_expect_init() is called from packet path where the skb owns
> > the ct object, therefore accessing exp->master for the newly created
> > expectation is safe. This saves a lot of updates in all callsites
> > to pass the ct object as parameter to nf_ct_expect_init().
> > 
> > This is a preparation patches for follow up fixes.
> > 
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > ---
> 
> Hi, Pablo and Florian.
> 
> I was investigating FTP test failures in OVS with 7.0 kernel and bisected
> the issue down to this commit.  AFAIU, with this change all the related
> connections over time gain their parents' helpers,.  This is causing a change
> visible to the userspace, because FTP data connections are now reported to
> have helpers in the conntrack dump:
> 
> # conntrack -L
> tcp      6 119 TIME_WAIT src=10.1.1.1 dst=10.1.1.2 sport=59534 dport=21 \
>                          src=10.1.1.2 dst=10.1.1.1 sport=21    dport=59534 \
>            [ASSURED] mark=0 helper=ftp use=2
> tcp      6 119 TIME_WAIT src=10.1.1.2 dst=10.1.1.1 sport=52709 dport=52381 \
>                          src=10.1.1.1 dst=10.1.1.2 sport=52381 dport=52709 \
>            [ASSURED] mark=0 helper=ftp use=1
> 
> Before this commit only the control connection had helper=ftp reported in
> the dump.  The traffic seems to work fine, but our tests fail because we
> do not expect the helper attached.
> 
> AFAIU, it's generally not something that should be happening, as helpers
> on data connections do not really make much sense.  But I'm just trying to
> figure out if you would consider this as a regression and fix in the kernel
> or if we should adjust our userspace components for this new dump content,
> which would not be very straightforward to do if we want to be able to run
> tests on both old and the new versions.
> 
> What do you think?

It seems previous behaviour to 9c42bc9db90a was inconsistent, ie. only
the h323 helper sets on exp->helper, then it shows helper= in expected
connections via ctnetlink. I guess this is for debugging given that
h323 is actually a family of helpers.

To consistently skip dumping this for expected connections, probably
this is the way to do:

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conn
index eda5fe4a75c8..9491ae9e080e 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -226,7 +226,7 @@ static int ctnetlink_dump_helpinfo(struct sk_buff *sk
        const struct nf_conn_help *help = nfct_help(ct);
        struct nf_conntrack_helper *helper;
 
-       if (!help)
+       if (!help || ct->status & IPS_EXPECTED)
                return 0;
 
        rcu_read_lock();

