Return-Path: <netfilter-devel+bounces-13089-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1jF3CFA2JWqUEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13089-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:13:52 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7395F64F37D
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:13:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b="oS/4eLSF";
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13089-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13089-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7EE81300C032
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2026 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB5F36D9F6;
	Sun,  7 Jun 2026 09:12:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720FD2356BE;
	Sun,  7 Jun 2026 09:12:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823560; cv=none; b=K/3kWDE6FWW8s/2qhlDRNHxUg6owCX9zr9Bsw7evqIqy2doHe5BJakxt17znhbdYxAee4b5YDttK2JqgG8VXgJBdFXpFz4Tymvy+VDCtL/QWOvnUasU6yMTRbFtITQ924PRDPMXXsA6mhkk0JjktK95hAKix3ST6QoJYbVN0prk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823560; c=relaxed/simple;
	bh=0Tp9pDbqKiPJTn3OY+hIy5AwH+LWlqH25EAb84KJFwg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzGdhC8RRFtE8xy9vclNgcLEdRo1T9mWDMiBD+KJG5ynfeJNWMRne+PblQw332M6Lz6Zx2ECTf7bavg5QegOuJUTAkhLr1P4nUulRR+0rfRBAu+5yFOswyq5Ct4esF6TChu7LmdeXq9N9rnUK+RWqUGxR9EKdErzjgRB7DV1Qqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=oS/4eLSF; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 2A873601A0;
	Sun,  7 Jun 2026 11:12:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780823556;
	bh=bC+gduYJsRsgGEUuxSyt3EGRQphsLlpnRW2YVsAgNoM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oS/4eLSF4twjR2VfUvzYmajNSESJ07+rq/nkCaylrIRUGhmQARQAo7itwuqGXS/6W
	 HfydNGVGPvNBlR0DPLTOCoPu1qL93zFSr1psobI2w2kD6Vnxr1pCeVDpfWii2FAbTS
	 AWNkHCNKRjR2tLUGE+btLUuZ9JjLQ9NvowzRGo59PLX0EFp4hXuO4tX59PNQjGLVBD
	 6kXJkUkmAXTxpy0lZrQarvqlQF9dJgVK2z1rDYOqyZ33MIOOPLipXZpJP1yffARfJu
	 8m/jDkstbbaAGWBACWVpWFwwwYwqbL733DQEs7MLN/kABfe2B1o7gk5BZD/mIchWWn
	 4AZWHt5qYn0RQ==
Date: Sun, 7 Jun 2026 11:12:33 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netfilter-devel@vger.kernel.org, linusw@kernel.org,
	Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: nf_conntrack: use get_unaligned_be32() in
 tcp_sack()
Message-ID: <aiU2AYffZfeP74nE@chamomile>
References: <20260525215840.93217-1-rosenp@gmail.com>
 <aiU1U36QUMBgQCfa@chamomile>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aiU1U36QUMBgQCfa@chamomile>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_RECIPIENTS(0.00)[m:rosenp@gmail.com,m:netfilter-devel@vger.kernel.org,m:linusw@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-13089-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chamomile:mid,netfilter.org:from_mime,netfilter.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7395F64F37D

On Sun, Jun 07, 2026 at 11:09:43AM +0200, Pablo Neira Ayuso wrote:
> On Mon, May 25, 2026 at 02:58:40PM -0700, Rosen Penev wrote:
> > The timestamp-only fast path dereferences the option stream as
> > *(__be32 *)ptr, which assumes 4-byte alignment that the TCP option
> > stream does not guarantee. Use get_unaligned_be32() instead, which
> > reads the value safely and already returns host byte order, so the
> > htonl() on the comparison constant can be dropped.
> > 
> > This matches the existing get_unaligned_be32() use later in the same
> > function.
> > 
> > Assisted-by: Claude:Opus-4.7
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  net/netfilter/nf_conntrack_proto_tcp.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/net/netfilter/nf_conntrack_proto_tcp.c b/net/netfilter/nf_conntrack_proto_tcp.c
> > index b67426c2189b..8993374c9df2 100644
> > --- a/net/netfilter/nf_conntrack_proto_tcp.c
> > +++ b/net/netfilter/nf_conntrack_proto_tcp.c
> > @@ -405,11 +405,11 @@ static void tcp_sack(const struct sk_buff *skb, unsigned int dataoff,
> >  		return;
> >  
> >  	/* Fast path for timestamp-only option */
> > -	if (length == TCPOLEN_TSTAMP_ALIGNED
> > -	    && *(__be32 *)ptr == htonl((TCPOPT_NOP << 24)
> > -				       | (TCPOPT_NOP << 16)
> > -				       | (TCPOPT_TIMESTAMP << 8)
> > -				       | TCPOLEN_TIMESTAMP))
> > +	if (length == TCPOLEN_TSTAMP_ALIGNED &&
> > +	    get_unaligned_be32(ptr) == ((TCPOPT_NOP << 24) |
> > +					(TCPOPT_NOP << 16) |
> > +					(TCPOPT_TIMESTAMP << 8) |
> > +					TCPOLEN_TIMESTAMP))
> 
> Missing put_unaligned_be32(), BTW.

Sorry, no write in this case, only read, LGTM. Apologies.

> >  		return;
> >  
> >  	while (length > 0) {
> > -- 
> > 2.54.0
> > 

