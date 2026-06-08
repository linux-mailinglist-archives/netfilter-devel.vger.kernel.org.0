Return-Path: <netfilter-devel+bounces-13137-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xl8sBaFMJ2o+ugIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13137-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 01:13:37 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6894965B23B
	for <lists+netfilter-devel@lfdr.de>; Tue, 09 Jun 2026 01:13:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=Ul3LiJtg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13137-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13137-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7239E3026C3F
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Jun 2026 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B175B3B19A8;
	Mon,  8 Jun 2026 23:13:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3B63A7F5D;
	Mon,  8 Jun 2026 23:13:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780960405; cv=none; b=Zf9l2TFlPKLVeJtPI6no/ScmgB0UA+5yXqMfVjlgYtDdTVjZszTA8FuZicgsz7nWCSsm01vz8yFhB9o+85snXquWmZqLiOh6yuaVbz+V4Lxu/wbv0H2MOVylahXnU+eEolB/Ltqt20nXDM0XLx45cbZWgLyR/g42kBCDckw42lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780960405; c=relaxed/simple;
	bh=++AsT4jug5R9P+O5ifhwx/I9KJ6uUNzbukRjsimfpDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sTBLtunVs/1W3r4MCa4rzqpr3Kf/avgcivQFAbSHF33sy62qygPgAcg679P9yAJVZyhyW77Pe4Ue249wpHRF0l6URmf/fJcBWkg9jZkG+mU6a113h/CHwqyDAG2+LHvATivZBhZi9eD7QG6RA6ZW4zTiTu/Pi41u6sK3mItfHus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=Ul3LiJtg; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id EBE406017E;
	Tue,  9 Jun 2026 01:13:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1780960403;
	bh=4M5kOKRfK1cOaArhXrxaj+dAkI50k1gaaYkhIYI7Zww=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ul3LiJtgpoK/nhtVF7lM8jzzCbdxoMKBWGnw66AtBWq7nqnZyJiTWxGlvqPdChfL/
	 Tvf4xuDQppQKcjP1XO87mSwkNN60vjuThUxB9tyjGM35/dfJWhD9KEdQ3Q8V+7HmZq
	 kfEPdVMxC7RBx6AyFeW9BAUalYeyjdEQZHL/+Txn5S5zz+8LJix/ELc32YnB5cftkU
	 DV+UULhc9wpvIrqwvIQRf0afD3sK3aqhLf44Yx+Hc4Eu0rHHOREJPqZg1s9tS/UAPa
	 RHWufC7sK+mtfqOtFzBSsVwqTA7f4OKbVrbiAD/b6+QrxH7MgS3KWxHvrx2F/jnVWc
	 z1xbqFbVp+MJw==
Date: Tue, 9 Jun 2026 01:13:20 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netfilter-devel@vger.kernel.org, davem@davemloft.net,
	netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	fw@strlen.de, horms@kernel.org, Julian Anastasov <ja@ssi.bg>
Subject: Re: [PATCH net-next 08/15] netfilter: cttimeout: detach dataplane
 timeout policy and repurpose refcount
Message-ID: <aidMkCI_5iYfePtp@chamomile>
References: <20260607094954.48892-1-pablo@netfilter.org>
 <20260607094954.48892-9-pablo@netfilter.org>
 <aidCgrrmFJGNF-Th@chamomile>
 <20260608155728.2b332bce@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260608155728.2b332bce@kernel.org>
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
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:davem@davemloft.net,m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:fw@strlen.de,m:horms@kernel.org,m:ja@ssi.bg,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[netfilter.org];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13137-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,netfilter.org:dkim,netfilter.org:from_mime,chamomile:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6894965B23B

On Mon, Jun 08, 2026 at 03:57:28PM -0700, Jakub Kicinski wrote:
> On Tue, 9 Jun 2026 00:30:26 +0200 Pablo Neira Ayuso wrote:
[...]
> > I can post a v2 for this PR.
> 
> Bad timing :( Please send follow ups

No problem, we'll follow up, thanks.

