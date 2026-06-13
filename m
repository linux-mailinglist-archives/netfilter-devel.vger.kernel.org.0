Return-Path: <netfilter-devel+bounces-13245-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id b+hPKQ/OLWorkQQAu9opvQ
	(envelope-from <netfilter-devel+bounces-13245-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Jun 2026 23:39:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 347E067FCCF
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Jun 2026 23:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13245-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13245-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45817300DA46
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Jun 2026 21:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941EB35CB81;
	Sat, 13 Jun 2026 21:39:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E581C352036
	for <netfilter-devel@vger.kernel.org>; Sat, 13 Jun 2026 21:39:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781386764; cv=none; b=FYEpfr9uyTcCLT7/+1TGPJUaG1a62v1R23BZZIMYvlbQ0EotCuiB1jwvQ2Im28YnwWaxANaOkeiJdbw6SAEIru0C5aP5t2CEFPwu4iVP2Yew4K7R/pWJuSn1r/115+FA6JdtcrkN4csjTl09Hyd+SZ8tr7ZUbwIdL+MeKldFmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781386764; c=relaxed/simple;
	bh=gPkBGRN1ErYrvCjLd+b8cf85bckOEl1ldP1cISJH2BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oHwMgZD4O+ZiIrf3XoVfjuWNUZq8XIR/LWFPlYDm8zFbc94lISjpaQfj8VYiZ6oX79APmN5S0dKElERJyq7pu5sNwxkBHDJ39g1fh9kXTxKwkTckGfOnPjVXM6byXZzkA7jof2PHMstJLFyOARRfspmbHcXQKqyH9JTj9jZrY5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 70036605EE; Sat, 13 Jun 2026 23:31:24 +0200 (CEST)
Date: Sat, 13 Jun 2026 23:31:19 +0200
From: Florian Westphal <fw@strlen.de>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org, phil@nwl.cc,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	zcliangcn@gmail.com, bird@lzu.edu.cn, bronzed_45_vested@icloud.com
Subject: Re: [PATCH nf 1/1] netfilter: xt_nat: reject unsupported target
 families
Message-ID: <ai3MJ2P2MnXLxcmb@strlen.de>
References: <cover.1781144570.git.bronzed_45_vested@icloud.com>
 <5722ce33544cc22da3f811de77ab57847eb58366.1781144570.git.bronzed_45_vested@icloud.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5722ce33544cc22da3f811de77ab57847eb58366.1781144570.git.bronzed_45_vested@icloud.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13245-lists,netfilter-devel=lfdr.de];
	DMARC_NA(0.00)[strlen.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:phil@nwl.cc,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,m:bronzed_45_vested@icloud.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,nwl.cc,gmail.com,lzu.edu.cn,icloud.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 347E067FCCF

Ren Wei <n05ec@lzu.edu.cn> wrote:
> xt_nat SNAT and DNAT target handlers assume IP-family conntrack state
> is present and can dereference a NULL pointer when instantiated from an
> unsupported family through nft_compat. A bridge-family compat rule can
> therefore trigger a NULL-dereference in nf_nat_setup_info().

Are you sure this is related to nft_compat?  What prevents attaching
-j D|SNAT to classic ebtables?

> Reject non-IP families in xt_nat_checkentry() so unsupported targets
> cannot be installed. Keep NFPROTO_INET allowed for valid inet NAT
> compat users and leave the runtime fast path unchanged.

Not so sure, I don't think there is harm in allowing NFPROTO_INET but
such users should not exist.

Patch is fine. There are already many different targets here,
I don't think we should do a NFPROTO_IPV4 / IPV6 split in this case.

(redirect & masquarade are ok, they register via IPV4/IP6 only).

