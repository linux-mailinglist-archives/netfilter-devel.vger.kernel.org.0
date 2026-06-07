Return-Path: <netfilter-devel+bounces-13087-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tOJnN8I0JWpQEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13087-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:07:14 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3543164F35B
	for <lists+netfilter-devel@lfdr.de>; Sun, 07 Jun 2026 11:07:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=M9TBxBqW;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13087-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13087-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0422F300B07B
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2026 09:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36CAF37D11A;
	Sun,  7 Jun 2026 09:06:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5599A374E60;
	Sun,  7 Jun 2026 09:06:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780823176; cv=none; b=k5OUBvJQzr6WS3HRqF/wxn2ulnbNA5qKbUwTgHOXHZRKmu+10DIIXmG2vpRhiO53DofeAf/fhooqhYAOP29ABGxwqhxs1i3+VtGp4nocnqWDhw09XKBz5Uw6K2ZOxZe8zlVBzaQGosaLBfGwZS4d/UgtnzXpfRzGc7jOwDC+Glk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780823176; c=relaxed/simple;
	bh=jH5IacHCfa1exoQoEiifl2qV9mZY7B8MX7QP2VF6Gus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYlCax8EYPz6Q+J+nysMXYKR97R8scV3VxLh4nZrZqYnA7WpBOhPvZRHHe1n6ytvAqPFOAswV0RGLn6sQOnt4EW+ejohk31XppPn0ADQ6lqhj5dXZOJ9Xx267qg8QqxHJZH72hlZ3SebSgdkTV47CQFFGuMQ9t5siaDmck683Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=M9TBxBqW; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 17F036017D;
	Sun,  7 Jun 2026 11:06:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780823164;
	bh=2HBpyxOGYXTX59z3igPQadtZGsHjN3rD8ejQRTQyb/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M9TBxBqWx8RaIzJmbSEZBKfkEFHq62XKHBqsUwrRKnkcIaf+QLlyQPBRE+gYLKeEN
	 OAf0xlmKAcI2szVI1h4I2T8cAXrJDRlvF5c7CK0WvJ1ZlECfr5Hoi+kxgnsGIPGk2t
	 98cDDIWGILmiHgFPhQo1tHo49mLLMZIXVWRXRL08I/47/Z4IUIQhP1GgwAsOMhJvLU
	 ofhRvgNj2LQIxSq1t5JpJ6/kwjX1OE1G3ncTJ2N1jB3z/8xZ8zcDALhFehQif2rLz8
	 PJX2y2OlX9APX3KBSLIk4uUA6Y1IszaKFPlbQnUBqPweHTit9Rys9HfkaCgKUQFrGJ
	 psVrEe4iOQ8Rw==
Date: Sun, 7 Jun 2026 11:06:00 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: Rosen Penev <rosenp@gmail.com>, netfilter-devel@vger.kernel.org,
	linusw@kernel.org, Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"open list:NETFILTER" <coreteam@netfilter.org>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] netfilter: nf_conntrack: use get_unaligned_be32() in
 tcp_sack()
Message-ID: <aiU0eKvHtfL1eD1j@chamomile>
References: <20260525215840.93217-1-rosenp@gmail.com>
 <a8cfeb06-6ffb-49f2-a14d-c5a50bc4e5be@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8cfeb06-6ffb-49f2-a14d-c5a50bc4e5be@suse.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fmancera@suse.de,m:rosenp@gmail.com,m:netfilter-devel@vger.kernel.org,m:linusw@kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13087-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,kernel.org,strlen.de,nwl.cc,davemloft.net,google.com,redhat.com,netfilter.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_TWELVE(0.00)[14];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3543164F35B

Hi Fernando,

On Tue, May 26, 2026 at 12:35:22AM +0200, Fernando Fernandez Mancera wrote:
> On 5/25/26 11:58 PM, Rosen Penev wrote:
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
> I already spotted this corner case when working on a SYNPROXY patch [1] but
> didn't send a patch yet. I think this is for correctness too.
> 
> Anyway, it is likely that there are more places where this tweak is needed..

I agree a more general audit to spot unaligned access, targetting
nf-next would be good.

Thanks.

> I will look around.. meanwhile:
> 
> Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> [1] lore.kernel.org/netfilter-devel/20260525124450.6043-4-fmancera@suse.de/

