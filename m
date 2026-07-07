Return-Path: <netfilter-devel+bounces-13686-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pcwLLrnaTGrSqwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-13686-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 12:53:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 127DA71AAA3
	for <lists+netfilter-devel@lfdr.de>; Tue, 07 Jul 2026 12:53:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13686-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13686-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2639A3065491
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jul 2026 10:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2100D3EC2CD;
	Tue,  7 Jul 2026 10:31:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3E8E3ED3CD
	for <netfilter-devel@vger.kernel.org>; Tue,  7 Jul 2026 10:31:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783420305; cv=none; b=gF0u/K3aM3RSH8XgWlbZAU6EIy9cR16LRyJVoglgXofZFOzFRVaG1vmtVlzMT3vwPtIhYZiygijLqOqC5oX0xIbc/C/jHEVwx6/LxpkF/tpKfSFPu5eFLGzGKMWfNfPzqKlDCmhl4SAD/gdHtWcFZKOt3vQ8EIVEJbVjx9cVdfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783420305; c=relaxed/simple;
	bh=/aA5GyhuQpl9bU98YSBXniNG69ZkWIyZdWhF6HcuObc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5ABR9W9/P28YnrQ0C0MFzy64XY3KhnXsfcEMmC+lBo9dql2ipaVSN0+NgRh+013zxj5jGoB27OIFZduFhsrYOUgu2uMPNJILV34HxEaYM4PR+9d2mYYi1RkBAAxwaITO7F4Rv7TQ+FhmdlPGD3PTWPUpn8SiVp6zqI4NVynEcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 7DA9B6047A; Tue, 07 Jul 2026 12:31:34 +0200 (CEST)
Date: Tue, 7 Jul 2026 12:31:34 +0200
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, lorenzo@kernel.org,
	chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf,v2 2/3] netfilter: flowtable: IPIP tunnel hardware
 offload is not yet support
Message-ID: <akzVhnsxasPRga8H@strlen.de>
References: <20260630094056.97038-1-pablo@netfilter.org>
 <20260630094056.97038-2-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630094056.97038-2-pablo@netfilter.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	TAGGED_FROM(0.00)[bounces-13686-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:pablo@netfilter.org,m:netfilter-devel@vger.kernel.org,m:lorenzo@kernel.org,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:email,strlen.de:mid,strlen.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 127DA71AAA3

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> No driver supports for IPIP tunnels yet, give up early on setting up the
> hardware offload for this scenario.

This series triggers many drive-by findings.

No big deal, should be addressed later.

> +	__set_bit(NF_FLOW_HW, &flow->flags);

Would you mind if I mangle this to use set_bit() ?

Its a low-hanging fruit, the other findings need
more attention.

Otherwise I can also apply this as-is, its an improvement
in either case.

