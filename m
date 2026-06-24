Return-Path: <netfilter-devel+bounces-13445-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /gMrH7rEO2qFcggAu9opvQ
	(envelope-from <netfilter-devel+bounces-13445-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 13:51:22 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1167A6BDD7A
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 13:51:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=LU8cG7G4;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13445-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13445-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E066B3047ABD
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jun 2026 11:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2909C2ECE91;
	Wed, 24 Jun 2026 11:51:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E80E346E43;
	Wed, 24 Jun 2026 11:51:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782301870; cv=none; b=oTXO1sBrqH1nQH5EjlFyWl/POREOxDRAlff1Y8bVR7adc92kmanb48xhuO8tWHVYA6dLg+BzgCF/CkWpt/8Ckfb4xo/Omam7puFb2hkhvd1bQ7rjl8oZ8R4MBIzesvoZHh3tOVFL6YiVy3T33C1q0ncE+xNLTnFySsZkN7TJYuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782301870; c=relaxed/simple;
	bh=qVFqyXbVB8/TNHhid0c5U9lTdB/szimlZwCiCEHIXLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fnGj20h04uv//HfcIatmzTUfRxZvAuUvjROjxIBonSl8PFlR+tQWTVYFDM3hc11adlbCtXV34V3U2/nNIXERnZWSKhGsFHeuzwphe++bVczVcZAfpCrnPGkVNtlmMZYBbga2jvEBhsslzTneimyOxxDi7C3Px/do3Wsu4CNn63A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=LU8cG7G4; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 42D3C60579;
	Wed, 24 Jun 2026 13:51:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1782301866;
	bh=Zdp1BVQY6kQIESjQyI/7EOzpHAd/8KSgFQBu2+r1qQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LU8cG7G4OQQXndQcyoDlhbFE5O7wIigyybdFaimJ+1LCmnUoOfu7RcnxxWdjRDRsH
	 2y5Jz/xiul2ccLsTTH9aZxFCapnI3OWdL1akPrFSNowXH0iLcbSsVtZsyJDwOEmV+U
	 W7iL0CfHyAG3wlt1+IVBdmPdLjECuw9ZEz64n6+1QiJRhhXg5vHjwIYL91lvcC8c99
	 m/LUv9qtd0v7vkDIg4rFWEecqS+sQVAhgM/7Va8u/1Y7RVaT4musEYOOf7yyNXwDBP
	 ZUNCnfgpRqC+RdSRDuu6ALcrsqmO1Afr4xnxnRzGeSwbxFPW4HSN48uDdNWvdR+VSR
	 ON4t0Kh4+ewHA==
Date: Wed, 24 Jun 2026 13:51:03 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexander Martyniuk <alexevgmart@gmail.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S. Miller" <davem@davemloft.net>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
	Jakub Kicinski <kuba@kernel.org>, Patrick McHardy <kaber@trash.net>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Weiming Shi <bestswngs@gmail.com>, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH 5.10] netfilter: nf_log: validate MAC header was set
 before dumping it
Message-ID: <ajvEp2mxZQ1gQVRG@chamomile>
References: <20260624140117.19799-1-alexevgmart@gmail.com>
 <ajvEDFOlP7Bqb-3j@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ajvEDFOlP7Bqb-3j@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS(0.00)[m:alexevgmart@gmail.com,m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:kadlec@netfilter.org,m:fw@strlen.de,m:davem@davemloft.net,m:kuznet@ms2.inr.ac.ru,m:yoshfuji@linux-ipv6.org,m:kuba@kernel.org,m:kaber@trash.net,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,netfilter.org,strlen.de,davemloft.net,ms2.inr.ac.ru,linux-ipv6.org,kernel.org,trash.net,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13445-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[netfilter.org:dkim,netfilter.org:email,netfilter.org:from_mime,chamomile:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,asu.edu:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1167A6BDD7A

BTW, fixing Cc: to netfilter-devel@vger.kernel.org

On Wed, Jun 24, 2026 at 01:48:31PM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> Thanks but why only 5.10?
> 
> On Wed, Jun 24, 2026 at 02:01:15PM +0000, Alexander Martyniuk wrote:
> > From: Xiang Mei <xmei5@asu.edu>
> > 
> > commit a84b6fedbc97078788be78dbdd7517d143ad1a77 upstream
> > 
> > The fallback path of dump_mac_header() guards the MAC header access
> > only with "skb->mac_header != skb->network_header", without checking
> > skb_mac_header_was_set(). When the MAC header is unset, mac_header is
> > 0xffff, so the test passes and skb_mac_header(skb) returns
> > skb->head + 0xffff, ~64 KiB past the buffer; the loop then reads
> > dev->hard_header_len bytes out of bounds into the kernel log.
> > 
> > This is reachable via the netdev logger: nf_log_unknown_packet() calls
> > dump_mac_header() unconditionally, and an skb sent through AF_PACKET
> > with PACKET_QDISC_BYPASS reaches the egress hook with mac_header still
> > unset (__dev_queue_xmit(), which would reset it, is bypassed).
> > 
> > Add the skb_mac_header_was_set() check the ARPHRD_ETHER path already
> > uses, and replace the open-coded MAC header length test with
> > skb_mac_header_len(). Only skbs with an unset MAC header are affected;
> > valid ones are dumped as before.
> > 
> >  BUG: KASAN: slab-out-of-bounds in dump_mac_header (net/netfilter/nf_log_syslog.c:831)
> >  Read of size 1 at addr ffff88800ea49d3f by task exploit/148
> >  Call Trace:
> >   kasan_report (mm/kasan/report.c:595)
> >   dump_mac_header (net/netfilter/nf_log_syslog.c:831)
> >   nf_log_netdev_packet (net/netfilter/nf_log_syslog.c:938 net/netfilter/nf_log_syslog.c:963)
> >   nf_log_packet (net/netfilter/nf_log.c:260)
> >   nft_log_eval (net/netfilter/nft_log.c:60)
> >   nft_do_chain (net/netfilter/nf_tables_core.c:285)
> >   nft_do_chain_netdev (net/netfilter/nft_chain_filter.c:307)
> >   nf_hook_slow (net/netfilter/core.c:619)
> >   nf_hook_direct_egress (net/packet/af_packet.c:257)
> >   packet_xmit (net/packet/af_packet.c:280)
> >   packet_sendmsg (net/packet/af_packet.c:3114)
> >   __sys_sendto (net/socket.c:2265)
> > 
> > Fixes: 7eb9282cd0ef ("netfilter: ipt_LOG/ip6t_LOG: add option to print decoded MAC header")
> > Reported-by: Weiming Shi <bestswngs@gmail.com>
> > Assisted-by: Claude:claude-opus-4-8
> > Signed-off-by: Xiang Mei <xmei5@asu.edu>
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> > Signed-off-by: Alexander Martyniuk <alexevgmart@gmail.com>
> > ---
> > Backport fix for CVE-2026-52942
> >  net/ipv4/netfilter/nf_log_ipv4.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/ipv4/netfilter/nf_log_ipv4.c b/net/ipv4/netfilter/nf_log_ipv4.c
> > index d07583fac8f8..d6164e8e2c73 100644
> > --- a/net/ipv4/netfilter/nf_log_ipv4.c
> > +++ b/net/ipv4/netfilter/nf_log_ipv4.c
> > @@ -296,8 +296,8 @@ static void dump_ipv4_mac_header(struct nf_log_buf *m,
> >  
> >  fallback:
> >  	nf_log_buf_add(m, "MAC=");
> > -	if (dev->hard_header_len &&
> > -	    skb->mac_header != skb->network_header) {
> > +	if (dev->hard_header_len && skb_mac_header_was_set(skb) &&
> > +	    skb_mac_header_len(skb) != 0) {
> >  		const unsigned char *p = skb_mac_header(skb);
> >  		unsigned int i;
> >  
> > -- 
> > 2.43.0
> > 

