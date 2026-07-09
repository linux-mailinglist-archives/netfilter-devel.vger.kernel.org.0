Return-Path: <netfilter-devel+bounces-13774-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Lhg0D45XT2oqewIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13774-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 10:10:54 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A251972E148
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 10:10:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13774-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13774-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E800E303204C
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 08:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDC63E7BA9;
	Thu,  9 Jul 2026 08:05:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E28743935E
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 08:05:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584340; cv=none; b=B0PXMthRhSHcjxB2d1dshicPaM2rDy/Ce3B0rVb5S04STdR98QUW9AONCoT7v17j9SoPbVQ+8diQbJ2uzByRQ3BRB/CVysMAFEkDIjZJNhr4GN4msQzYnW5qqKa5ODOu9x2oOtudtCzKoie4KbLOmV5WzpGdttdlHZe/qHhdBnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584340; c=relaxed/simple;
	bh=PmUK2bM3XM72E/3t3fsi1vpjayf4eWrItCsKV8zJVqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFxM842jYgiidHZ9iLEgCXWtw9iuUr3HvPIuuBWCPsRe0FfM9/zSSdL/jWqI0SWFlZuxbubdq6vPpPI06R8o7BsQrsDiV+ikLrqfB91uyNzr0TMT+5S5OrmV88ALXWmdpOWBbyCT99TGC8hHNO6HeYFEsO1o6QJrhrJos4J6ZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 05BDF60293; Thu, 09 Jul 2026 10:05:34 +0200 (CEST)
Date: Thu, 9 Jul 2026 10:05:34 +0200
From: Florian Westphal <fw@strlen.de>
To: Omkhar Arasaratnam <omkhar@linkedin.com>
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>,
	"pablo@netfilter.org" <pablo@netfilter.org>,
	"fmancera@suse.de" <fmancera@suse.de>
Subject: Re: [PATCH nft] parser_json: initialize geneve options list for
 empty tunnel array
Message-ID: <ak9WRGrU4SjDxMEF@strlen.de>
References: <LV0SPRMB0026D6A74A8E3E8504609CB0A1FF2@LV0SPRMB0026.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV0SPRMB0026D6A74A8E3E8504609CB0A1FF2@LV0SPRMB0026.namprd21.prod.outlook.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13774-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:omkhar@linkedin.com,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,m:fmancera@suse.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A251972E148

Omkhar Arasaratnam <omkhar@linkedin.com> wrote:
> The attached patch fixes a crash in the JSON parser. A geneve tunnel object with an empty options array ("tunnel": []) leaves obj->tunnel.geneve_opts uninitialized; obj_tunnel_add_opts() then walks the uninitialized list head and nft -j crashes (SEGV in nftnl_tunnel_opt_geneve_set via near-NULL deref).

Applied.  I moved the crasher to testcases/bogons.

