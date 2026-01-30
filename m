Return-Path: <netfilter-devel+bounces-10538-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aHkzMdzafGlbOwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10538-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 17:22:52 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D386FBC7D6
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 17:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A7BC3002528
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BB2343D83;
	Fri, 30 Jan 2026 16:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="OGGJCZt0"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BA3202963
	for <netfilter-devel@vger.kernel.org>; Fri, 30 Jan 2026 16:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790168; cv=none; b=O1qq2JfR8n9lM0sVrhoC/rqnmYoztKrENswtCUtOyrvqnA3zahkaKiz2QQEpIYODUN5mG8YoeciUJkn+LHA65h+Hh/MyZ0YfDJ5ktV2YmLjSY0haAgGyhtqvSkIaVrAvvVy0e7pKyxXq68miUl4nMYIRUQy8A7Rq4l+4ApZrglA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790168; c=relaxed/simple;
	bh=7i0Kk3kSHE+8DXtnhZOMa3dV+lJMR4yqFzVwd53xdyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=icgT2Br165aGtljVFpbBIA7DfHMmA4346MrtXpcILMMV/3MHW8YmNsdVHcpDSwWSOvLS4tem5p5VRjQfMw9e3+NNzEKD1t7G4c87/JqeWGlTY7oe9u52jJKPTrBglIwoj3eFjS3Y6S7s03hh9RvLDLGRvM2c41T7hXm7vM/u08c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=OGGJCZt0; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XJ/2ww+1kp6L/lW2I8Qp1OhxR8+g9ESzqy84wH8lvUU=; b=OGGJCZt0kP+kJCVrFmRWhvEn1E
	iTkBojUO6IzoFO0yWzkVViuSjj3HLjNGcYmOtP7AlLr1hHZVtBIRL84v2A0AchZyc1WX6AS7PnjBN
	PHEiKPzj/ECe08xY/HgvZ49fw8y5s3q8e8+T63yCm8796gvCF4lvWEIob0I+BPZgm7xa01VT6FdQv
	x3HBIIymAIaiKFFvookKrVeZhe8KLXhgPRo4+C4DJiaY+N2ro5mfw4sXpjQcRKd3qAUpSEdiiqFjH
	xLEpk2FPKjlM15JnZnuWTHxNFpJfIZFHMQHmRtn8eoLcO8PFv3D9LE+1kZ8oilT/y2XlldKky92Eh
	mvKBmx5g==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vlrGf-000000001mu-1V9s;
	Fri, 30 Jan 2026 17:22:45 +0100
Date: Fri, 30 Jan 2026 17:22:45 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH] tests: shell: Review
 nft-only/0009-needless-bitwise_0
Message-ID: <aXza1fj5drmecIaS@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20260129195755.13905-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129195755.13905-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10538-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[nwl.cc];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,orbyte.nwl.cc:mid]
X-Rspamd-Queue-Id: D386FBC7D6
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:57:55PM +0100, Phil Sutter wrote:
> - Avoid calling host's nft binary, use double-verbose mode with *tables
>   tools instead
> - Update expected payloads to match new byteorder-aware libnftnl output
> - Drop '-x' flag from shell
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.

