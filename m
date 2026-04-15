Return-Path: <netfilter-devel+bounces-11930-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKjSNFrI32kmYwAAu9opvQ
	(envelope-from <netfilter-devel+bounces-11930-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 19:18:18 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E8A6406BA4
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 19:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 907CB326BF78
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 Apr 2026 16:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D926D3E6DC6;
	Wed, 15 Apr 2026 16:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="USudHZsI"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E944B3BD64D;
	Wed, 15 Apr 2026 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776272091; cv=none; b=SZTj4uM1wngWwihA75P9AsZqQdTzT+DHnnVAy8Mh9fR3h0wvssWo5+VtC9d7x6PNqftMpVs3NfXuwwRJIDuCulJZ5tUiBGJGn7IDRm1wHdJ/OfIWl8OMqUFPkTDIV0dB6+aIztIDiE/Wio8y/NGvXFFh9RzhTflIGUOsBlhhhbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776272091; c=relaxed/simple;
	bh=6DNTZ0ERM+6asbMeGGsrZ6aDsAY5gnasAF9NXF3KX/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O9N30p79KGHe+wCpzCw9Urbm1kE2FowSixPw1TaYIosJv4Guw9Tk+DZJRn6O5q8Sere3jW62caOVF+ZZj13f1Y5z1RfLP/0JLKsChquiBgut/+aBiHSJyHGqWCOLubRf1vFt+FlEf7n1z4TWNY/WOfiZ4x/E6zZUGWtBHkLPygI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=USudHZsI; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id C119E60177;
	Wed, 15 Apr 2026 18:54:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1776272087;
	bh=wI1AsDb3z2P6i589haHLZlIIadhnDuo0oWVn9mLJshA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=USudHZsIvGmL8Zp3SEelOosguhygRWXOemwMzscPov6DdONVtsBsjeY3c77AQylZ8
	 KfsyxDDwi0zzTBU+3Jm1P5WKV37IzyT0c+PbxsjM6F02Jgc8LR1+3GWVmOAHNXffY4
	 a8WhGFvPLXh8A3J++H3zCxZrwYUk7yAF9N1Is3ood5khhdsMYzgGCJBSPWy6aOjOUB
	 0qJoCk9c7NgIM/dFOc3y0NngnkHRSGXPH9VbuNJ5+m2bJSmArSLQovJPfXTt1CCENw
	 WyiMIWNoeRHbf7XIMv8o9wLxVGZ3kIFaJrNihkGUvCY8XBLuQeneDLzCOhRHhA7noZ
	 lxdCi1/eg0cig==
Date: Wed, 15 Apr 2026 18:54:45 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Phil Sutter <phil@nwl.cc>, Simon Horman <horms@kernel.org>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH nf] netfilter: nf_tables: use RCU-safe list primitives
 for basechain hook list
Message-ID: <ad_C1f2cW5-kctHi@chamomile>
References: <20260410101321.915190-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260410101321.915190-2-bestswngs@gmail.com>
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-11930-lists,netfilter-devel=lfdr.de];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ozlabs.org:url,netfilter.org:dkim]
X-Rspamd-Queue-Id: 3E8A6406BA4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 10, 2026 at 06:13:22PM +0800, Weiming Shi wrote:
> NFT_MSG_GETCHAIN runs as an NFNL_CB_RCU callback, so chain dumps
> traverse basechain->hook_list under rcu_read_lock() without holding
> commit_mutex. Meanwhile, nft_delchain_hook() mutates that same live
> hook_list with plain list_move() and list_splice(), and the commit/abort
> paths splice hooks back with plain list_splice(). None of these are
> RCU-safe list operations.
> 
> A concurrent GETCHAIN dump can observe partially updated list pointers,
> follow them into stack-local or transaction-private list heads, and
> crash when container_of() produces a bogus struct nft_hook pointer.

For the record, v1 of proposed series to fix this is here:

https://patchwork.ozlabs.org/project/netfilter-devel/list/?series=499757

