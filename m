Return-Path: <netfilter-devel+bounces-13923-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFfFDp5UVWrxmwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-13923-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 23:11:58 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994374F322
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 23:11:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=elaCtaC9;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13923-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13923-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C02F30363BB
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Jul 2026 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5163A35E1BC;
	Mon, 13 Jul 2026 21:11:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8741630E85D;
	Mon, 13 Jul 2026 21:11:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783977113; cv=none; b=MkF5vmNQIOjZw0yyER1eFI/aO/Wl8Xeahdqte1gV1kfObqxUPuCcMU9PJt7x23X0r7/sJ3n4y7e8x/ijpabEQmXa3LcLWzH9bMo8y4Yn3GL3HbIOzfVa6pCV5xAEfeWoh7pH56yY+n15uO2soZixtIkg95K1h+4r3ibtQd0sWkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783977113; c=relaxed/simple;
	bh=2ZBmYPof/SK7y2CjX6IgJ8sFX74uWquKBXBCXe1OHAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D8OlKqTlinJupuT3p1A80DUkZq1Qk61G16JDk4SB+E7fXiPdRI/ltStxRP9omAJISp+SH5YIDIyY+imTcNEJbhluwmmKnVANcvDF9/3p58b5ZRzTaa22xppbx+V1CoYWpWVXKT4AB7fyUtNOC26hKJIrLN3pPbr9XoOobkkKu34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=elaCtaC9; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id BD4F160191;
	Mon, 13 Jul 2026 23:11:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783977107;
	bh=4kEkS8RIh0oVx8XiT/u4QYhxlOI4Xz5/jdBjZkbLce4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elaCtaC9tCX5SlXKY4Nma+clmu+fc8gwJiWKqENg2UYZHwn9hLBTbMiwzYl4jxvct
	 GNgCpjMQ2sKJ2duARY1BBwZzml+ZRcl8B/TS/Mjls8iieaxopsn8tj8Pmlj2GRXlex
	 A6XpWvVB05nsGJ96kaiCyS2LnQq1jWxsWpCgGquWqrSdsfrCQO1qeSDBonp952xUI0
	 SXChz7Rr6hfvbzghB+Qy+kSoEwpEl8jEvjAA5Amv5tmPxzIHkhRc4bjg/dCzoGWEFu
	 jAeTrRC3cRAdIAqbgNKfFF77ghSR7polEGly3L0JQOHBr3J+yaPj3WHkhYOjw1NsNe
	 P0T24JdbZIluA==
Date: Mon, 13 Jul 2026 23:11:45 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH nf] netfilter: nft_fib: bail out if input device is
 missing
Message-ID: <alVUka8INN918W0K@chamomile>
References: <20260713183614.2975972-1-xmei5@asu.edu>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260713183614.2975972-1-xmei5@asu.edu>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:fw@strlen.de,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:AutonomousCodeSecurity@microsoft.com,m:tgopinath@linux.microsoft.com,m:kys@microsoft.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13923-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8994374F322

Hi,

On Mon, Jul 13, 2026 at 06:36:14PM +0000, Xiang Mei (Microsoft) wrote:
> nft_fib_can_skip() dereferences the input device (indev->ifindex, and
> in->flags via nft_fib_is_loopback()) without a NULL check, assuming the
> hook switch only admits PRE_ROUTING/INGRESS/LOCAL_IN. But NF_NETDEV_EGRESS
> == NF_INET_LOCAL_IN == 1, so a netdev-family base chain on the egress hook
> passes both the switch and nft_fib_validate() (which also keys only on the
> hook number). Egress packets have no input device, so nft_fib_can_skip()
> dereferences NULL.

By reading your description, does your kernel include this patch?

commit d07955dd34ecae17d35d8c7d0a273a3fba653a8c
Author: Theodor Arsenij Larionov-Trichkine <theodorlarionov@gmail.com>
Date:   Mon Jun 29 12:53:11 2026 +0200
 
    netfilter: nft_fib: reject fib expression on the netdev egress hook


