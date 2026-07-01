Return-Path: <netfilter-devel+bounces-13563-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +A0BGji0RGrmzAoAu9opvQ
	(envelope-from <netfilter-devel+bounces-13563-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 08:31:20 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B9626EA3BF
	for <lists+netfilter-devel@lfdr.de>; Wed, 01 Jul 2026 08:31:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13563-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13563-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9C52F301E00F
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jul 2026 06:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897AA3AFD18;
	Wed,  1 Jul 2026 06:31:18 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D943A3830;
	Wed,  1 Jul 2026 06:31:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782887478; cv=none; b=X02owfaIpNtBo1Vt6sx1CFk8+e64P1gHRDEkqQ0Nr7b5X4gd3q0sGjPhpahEFZ/3r9wUz2bVldvozvVeTjgn/LIEXkztCCAH+ZYwNzJfDNnM0EMCeBvDe2NJ9qW4tmXeq9HqLbzeiTOAzQ/lsDrVpTgGgAMee2MOxZnW3GjKYsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782887478; c=relaxed/simple;
	bh=6DXe25HNgUIkVcacAqjomd34UoaNnsPR6LZ9KLJs25w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Niv0s/K/NVfvs9Pt1RevvSRMdlMrg+nr0b4S0AFQ9K/E5IT8R2IqiKTgSijKHUj67XGadtA4C2l3sKyyTM3ccXNl5igg+0ISA3nydDykINUEeGJcThUEDJemmRUtiU1iBOPWPwCGfoWXYCwGfrNXML2zqq2dklB64OaRSxqmc8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D868F602F8; Wed, 01 Jul 2026 08:31:14 +0200 (CEST)
Date: Wed, 1 Jul 2026 08:31:14 +0200
From: Florian Westphal <fw@strlen.de>
To: Ian Bridges <icb@fastmail.org>
Cc: David Laight <david.laight.linux@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] netfilter: x_tables: replace strlcat() with snprintf()
Message-ID: <akS0MrGUcI_3oAan@strlen.de>
References: <aj78X4Cjqcpbb8Co@dev>
 <20260627221643.1e837496@pumpkin>
 <akSy4AzKgPffteU7@dev>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akSy4AzKgPffteU7@dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13563-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:icb@fastmail.org,m:david.laight.linux@gmail.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,netfilter.org,nwl.cc,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,fastmail.org:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0B9626EA3BF

Ian Bridges <icb@fastmail.org> wrote:
> I learned something new today, thanks. I'll use the first form in v2.
> 
> > FORMAT_TABLES should also be FORMAT_NAMES.

No. The name is fine.

> The macro is already named FORMAT_TABLES today, so that rename would
> be a cleanup of pre-existing code rather than part of the strlcat
> conversion. I'm happy to fold it into v2 if a maintainer is fine
> including the tidy-up in this patch.

No need for a v2, I mangled this patch locally already to use
"%s_FOO" in FORMAT_FOO.

