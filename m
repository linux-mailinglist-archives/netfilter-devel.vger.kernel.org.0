Return-Path: <netfilter-devel+bounces-13505-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Sx9cI4twQmoQ7QkAu9opvQ
	(envelope-from <netfilter-devel+bounces-13505-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 15:18:03 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B8C6DB031
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 15:18:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13505-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13505-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AF4C3056602
	for <lists+netfilter-devel@lfdr.de>; Mon, 29 Jun 2026 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1576402451;
	Mon, 29 Jun 2026 12:56:26 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121BE401A3F;
	Mon, 29 Jun 2026 12:56:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782737786; cv=none; b=uL0YmEXA2wfz7atilBlFhSCobVmUbTvnan5rI0aAw7bkUZ9aM5qaAuof8+cghkNNkohfWbr8KKxUouGjyR3zzEI2R7HzCBeyv4Ego2EhIMo6Oy5kWn7wVDm4PFVAwFPvCRHOA9HhuCZgBmlItZsOokYIxRUxMLehBFE55h8e0/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782737786; c=relaxed/simple;
	bh=vD5i8Uu5BLJ1HYu/zfIpvv/0OUhlqGC5AVzWeeEMFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W9kUmZYgaBgz66kK2lacrgmOVsg1O+tz92KhgjoCx2SqR6Vp8mJBfa7U4Z8rCHBq2Wm+1scKgaDxxcoRjpOM+KZkEc4XQhHR0putALlVn+sGZ/GS67PiS0JLJACBfTKzt+OLoF3bvqM0a7g6G2taxGSobbSUqYg+HP6CGWn67/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C98976032C; Mon, 29 Jun 2026 14:56:16 +0200 (CEST)
Date: Mon, 29 Jun 2026 14:56:16 +0200
From: Florian Westphal <fw@strlen.de>
To: Daniel Pawlik <pawlik.dan@gmail.com>
Cc: netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
	pablo@netfilter.org, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, andrew+netdev@lunn.ch, razor@blackwall.org,
	idosch@nvidia.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com, bridge@lists.linux.dev,
	coreteam@netfilter.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, rchen14b@gmail.com,
	lorenzo@kernel.org
Subject: Re: [PATCH 0/5] netfilter: nf_flow_table_path: L2 bridge offload
Message-ID: <akJrZpkuM2GkOqWA@strlen.de>
References: <20260629123253.1912621-1-pawlik.dan@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629123253.1912621-1-pawlik.dan@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:pawlik.dan@gmail.com,m:netfilter-devel@vger.kernel.org,m:netdev@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:razor@blackwall.org,m:idosch@nvidia.com,m:matthias.bgg@gmail.com,m:angelogioacchino.delregno@collabora.com,m:bridge@lists.linux.dev,m:coreteam@netfilter.org,m:linux-mediatek@lists.infradead.org,m:linux-arm-kernel@lists.infradead.org,m:rchen14b@gmail.com,m:lorenzo@kernel.org,m:pawlikdan@gmail.com,m:andrew@lunn.ch,m:matthiasbgg@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-13505-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,blackwall.org,nvidia.com,gmail.com,collabora.com,lists.linux.dev,lists.infradead.org];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel,netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1B8C6DB031

Daniel Pawlik <pawlik.dan@gmail.com> wrote:
> -----------------------------
> 1. Load kmod-br-netfilter so that bridged IP traffic traverses the
>    netfilter forward chain.

Ouch.  br_netfilter should die.  Really.  Its a gross hack, never
use this thing...

> 2. Enable netfilter hooks on the bridge:
>      echo 1 > /sys/class/net/<br>/bridge/nf_call_iptables
>      echo 1 > /sys/class/net/<br>/bridge/nf_call_ip6tables
>
> 3. Register bridge member interfaces in the nft flowtable:
>      table inet filter {
>          flowtable f {
>              hook ingress priority filter
>              devices = { eth0, wlan0 }
>          }

I think that bridge flowtable should use 'table bridge ...', not
use the br_netfilter compat hacks.

Sorry.

Are you aware of Eric Woudstras bridge flowtable patches?
https://lore.kernel.org/netfilter-devel/20250408142802.96101-5-ericwouds@gmail.com/

