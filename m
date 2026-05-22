Return-Path: <netfilter-devel+bounces-12755-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHpZDqkxEGp4UwYAu9opvQ
	(envelope-from <netfilter-devel+bounces-12755-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:36:25 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B69DD5B23DE
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 12:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF18F3045EDE
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 May 2026 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22893B9920;
	Fri, 22 May 2026 10:27:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279D43BAD96
	for <netfilter-devel@vger.kernel.org>; Fri, 22 May 2026 10:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779445663; cv=none; b=drkyNXKlDqNgVz/pOLo81H5epWBd1E5KW1Yysek8OkvsUzj1pVctx+JNaMffG2x51ra/xofJqFI7YnI5N+u0MKxym0bFBKPdBg0Ktsl5ZiyaSeplendAhlFV44Cn07yQIsF0LjEkLlUFKYl4YumkYwBQ0MNcYDigd/gx1GPEcXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779445663; c=relaxed/simple;
	bh=tizpuggaC7SNn18Xo8wrXSdO/82Aqv1LiLMb5N9HUNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1s6j7Sl/Padu2YB90zuiLvsGhU2n2j5eTlzXfLwv+Pf1IJ24ADAMactCl3KfHykgoPGcO6L60JHBV4sWpbE1X7n1n4nzthmFMj+tqbROHS8S02of9P0LISNLuPwN0ZvhuNCOI67E+zhhDXGD/O+VFC4z2yFv3FPuVWKHcuU7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B61FC60345; Fri, 22 May 2026 12:27:18 +0200 (CEST)
Date: Fri, 22 May 2026 12:27:16 +0200
From: Florian Westphal <fw@strlen.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netfilter-devel@vger.kernel.org,
	syzbot+690d3e3ffa7335ac10eb@syzkaller.appspotmail.com
Subject: Re: [PATCH nf] netfilter: xt_cpu: prefer raw_smp_processor_id
Message-ID: <ahAvhJpc8RLhXEzV@strlen.de>
References: <20260519183430.20726-1-fw@strlen.de>
 <35756825-5349-468c-881f-e88b80f0729b@suse.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <35756825-5349-468c-881f-e88b80f0729b@suse.de>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel,690d3e3ffa7335ac10eb];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.985];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-12755-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Queue-Id: B69DD5B23DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fernando Fernandez Mancera <fmancera@suse.de> wrote:
> I see I can use the compat layer to configure NFQUEUE target see:
> 
> # Warning: table ip filter is managed by iptables-nft, do not touch!
> table ip filter {
> 	chain FORWARD {
> 		type filter hook forward priority filter; policy accept;
> 		tcp dport 80 counter packets 0 bytes 0 xt target "NFQUEUE"
> 	}

Please send a patch.

