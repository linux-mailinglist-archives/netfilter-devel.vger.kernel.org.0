Return-Path: <netfilter-devel+bounces-10429-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKiEHHTHeGmltAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10429-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 15:11:00 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05BF395630
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 15:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E3A533008D68
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 14:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4AC31197F;
	Tue, 27 Jan 2026 14:10:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4536E2E9EAC;
	Tue, 27 Jan 2026 14:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769523053; cv=none; b=iTVaszBWq2awebow5jMQa+ACTeyHD0ChBtMYXnOvGWkOhmFDDFuX51qkdkarA7A7JMntVk+AN58KBDGca5gfwPYjRWWOTqUhrr7piuWn0vlbwBacTyPrKX3oQQDmS5YFuO7PCDWE98VEAyvB3LWXWN4Y+PdZfPSo2MGHh/NkkAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769523053; c=relaxed/simple;
	bh=0by4I+x4xjY4G2tv2PI+E4VhVVnS22VxcaVNO9sAJ18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FfqsT/GLYAwLiUKTB/iI/mp0zNO5BamxZnuOv7zRCMnw+i8QN0ZMgQSX/MoECkJtMh+N8V7ip+4Lfl7JFPGcVmkerA1MWPH1VV1ixyXKL5u1RNHu7m6GT7PJ49iGBvQeWPF+g+lIFp4uAkndOY8stD55wnqtu6jBNEBEYCH1XW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 388C76033F; Tue, 27 Jan 2026 15:10:48 +0100 (CET)
Date: Tue, 27 Jan 2026 15:10:43 +0100
From: Florian Westphal <fw@strlen.de>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>, Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH v6 5/6] doc/netlink: nftables: Add getcompat operation
Message-ID: <aXjHYyB1jYNxaFm7@strlen.de>
References: <20260121184621.198537-1-one-d-wide@protonmail.com>
 <20260121184621.198537-6-one-d-wide@protonmail.com>
 <aXiiYOxuXVn5YhXG@strlen.de>
 <Y2VtJPFWA2Kgxe16KslviULQU9LRZsdYFsoUD6VZ9CH-49a2P2fwiQ9B03i3Rmfq6tUczD-oiGpWCCs9aPGwwD2N-vVzy4cFIZT7F7-83Fc=@protonmail.com>
 <aXiwkXKg7uvIon4p@strlen.de>
 <2mi8BfZGa57pxicf4pXNT_oDJ3bvV7pByJOBhG8e7u_3eBbjubS3YJ88xHp4oDiMi3iY20zcG6FgF8_m5nsJJ_3CYHNftjAL_4EAqN5zeU0=@protonmail.com>
 <aXi26_vIXqQPhopG@strlen.de>
 <UQH3L3tF4h7c1fSG9jiwLDOlbwlsoqbmP_3oKD-sjVhUZB0YoSEy0TUD5DZ09eLwxVu55xOuEJ5wDx5pWBROF0VAWQvwdYNmw8KEGxzvvnA=@protonmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UQH3L3tF4h7c1fSG9jiwLDOlbwlsoqbmP_3oKD-sjVhUZB0YoSEy0TUD5DZ09eLwxVu55xOuEJ5wDx5pWBROF0VAWQvwdYNmw8KEGxzvvnA=@protonmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10429-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org,netfilter.org,nwl.cc];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[protonmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,protonmail.com:email]
X-Rspamd-Queue-Id: 05BF395630
X-Rspamd-Action: no action

Remy D. Farley <one-d-wide@protonmail.com> wrote:
> > And perhaps mention that this is only for iptables-nft in the yaml file too.
> > (nft uses it on 'nft list' only if it encounters a rule added by iptables-nft).
> 
> Do you mean to still add getcompat operation to spec in the kernel tree?
> In case I misrepresented it, netlink-bindings is not a kernel project. And
> AFACT, this issue isn't relevant for ynl C library, as it would only try to
> decodes messages from operations you sent.

Oh, indeed, I misunderstood.  In that case I think its better to not add
it to the yaml spec.

