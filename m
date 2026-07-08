Return-Path: <netfilter-devel+bounces-13724-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id H4TmLK8rTmoCEgIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13724-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 12:51:27 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 57011724835
	for <lists+netfilter-devel@lfdr.de>; Wed, 08 Jul 2026 12:51:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ideasonboard.com header.s=mail header.b=kfT0yzHb;
	dmarc=pass (policy=none) header.from=ideasonboard.com;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13724-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13724-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 72D4530067AF
	for <lists+netfilter-devel@lfdr.de>; Wed,  8 Jul 2026 10:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0253C8C68;
	Wed,  8 Jul 2026 10:48:16 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB533C555B;
	Wed,  8 Jul 2026 10:48:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783507694; cv=none; b=XIirKnmoK8X4RizhzGRrOtLr3apjp8vwPC5swXlCbgBWNzsraXiOzf0Ryx5a91/yreWrG5qm/nEr/ijRyQ1Q2N1rtsMD/uSe8GCD/D4i4dHFPP7doi7OwliBJjnFSbSTms7C70rfjb+WFpihJeM1teWUwu19x1TqVUT4FfdqSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783507694; c=relaxed/simple;
	bh=C+3z98aoNdTcNqpCFwp6bSQvevvKTWyRxGXhwHiPylE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F1zF79wfUXDnDPyphjUZSM2Tr3L26tmooB7vefZ/YJb4RbAotM3hySTztzuMEnRUgDeAEzez1n/ascfdty4KbshJd2/uIw1wQk5080Q9rhyQDsKAjg+fdnWKra1OUTfSCboP8eExMZ2dl93U7AvfH/SeLC+z+NdRsKk55KPiI4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=kfT0yzHb; arc=none smtp.client-ip=213.167.242.64
Received: from killaraus.ideasonboard.com (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5722CEAA;
	Wed,  8 Jul 2026 12:47:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1783507628;
	bh=C+3z98aoNdTcNqpCFwp6bSQvevvKTWyRxGXhwHiPylE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfT0yzHb0qI20BNcydafbmbqMKPvItu1evit41y2WDmuzZJF375NKA6R5mnBDcXay
	 HtJ9pEw62kf7Vuwd9VQiZ7nkfuqHDwq0dJfXMuY7e3bxZFLMtg0xjbp0G8t7VBVERD
	 /e8LHHX8W+1jRjWXRboYhOUKIRoSHVW0ft77nLPg=
Date: Wed, 8 Jul 2026 13:47:56 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Yuan Tan <yuantan098@gmail.com>
Cc: linux-kernel@vger.kernel.org, workflows@vger.kernel.org,
	jhs@mojatatu.com, gregkh@linuxfoundation.org, sven@narfation.org,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [RFC] VEGA: a syzbot-like workflow for LLM-found kernel bugs
Message-ID: <20260708104756.GA333627@killaraus.ideasonboard.com>
References: <20260708092247.4188498-1-yuantan098@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260708092247.4188498-1-yuantan098@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ideasonboard.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[ideasonboard.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13724-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:yuantan098@gmail.com,m:linux-kernel@vger.kernel.org,m:workflows@vger.kernel.org,m:jhs@mojatatu.com,m:gregkh@linuxfoundation.org,m:sven@narfation.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[laurent.pinchart@ideasonboard.com,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[ideasonboard.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[laurent.pinchart@ideasonboard.com,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,ideasonboard.com:from_mime,ideasonboard.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 57011724835

On Wed, Jul 08, 2026 at 02:22:47AM -0700, Yuan Tan wrote:
> Hi all,
> 
> We would like to ask for feedback on a proposed workflow for reporting Linux
> kernel bugs found by an LLM-assisted code auditing tool that we have
> been developing since earlier this year.
> 
> Since February, we have been developing an LLM-driven kernel code auditing
> tool called VEGA. It started as a side project, but the results became much
> substantial than we expected: VEGA has found hundreds of valid bugs in Linux
> kernel.
> 
> That immediately created a practical problem: we do not want to dump a large
> pile of bug reports onto mail lists and annoy the maintainers.
> 
> The first thing we tried was to fix as many as we could ourselves. We
> started working with a group of student volunteers. Most of them are
> college students, so we have been training them, reviewing their patches,
> and trying to build an internal review process before anything is sent to
> the mailing list. The goal is to turn these findings into useful fixes, and
> also to help new contributors grow into people who can reduce maintainer
> workload instead of adding to it.
> 
> The process was not perfect. Some patches were not good enough, and we also
> made some mistakes early on when deciding what should be called a security
> issue.  Our internal review process has been improving with the help of the
> community.
> 
> Since March, we picked up non-root triggerable bug first and have worked on
> fixes for more than 100 validated kernel bugs. we especially want to thank
> the students and professor who have helped a lot with this effort.
> 
> But the remaining queue is still too large for us to handle.
> 
> Recently Jamal pointed out problems around our tags. That made me realize
> that we should probably stop treating this as an ad-hoc patch effort and
> build something closer to syzbot: public, reproducible, trackable,
> deduplicated, and useful to maintainers.
> 
> So this mail is an RFC for a VEGA reporting workflow.
> 
> The rough idea
> ==============
> 
> VEGA would have a public dashboard, similar to syzbot, and would
> send selected bug reports to the relevant kernel mailing lists.
> 
> The goal is to send reports that contain enough information for maintainers
> or other developers to pick up, understand, reproduce and fix the issue.
> 
> For each public report, we expect to include:
> 
>   - a description of the bug
>   - the tested kernel tree and commit
>   - the kernel config and environment
>   - the crash log
>   - a minimized user-space reproducer
>   - the suspected introducing commit
>   - a suggested fix patch
> 
> The suggested fix patch is meant to reduce maintainer burden. It still need
> human review, but hopefully it can save a lot time from building a patch
> from scratch.

Will the information included in the public report (including the
suggested fix) be written by a human or an LLM ? In the latter case I
don't see how you could reasonably claim to reduce maintainer burden, so
that would be a big NACK as far as I'm concerned.

> What will be public
> ===================
> 
> All VEGA findings that we have evaluated as not having major security
> impact can be published on the VEGA dashboard. The dashboard would make it
> possible to see what VEGA found, whether the issue was reproduced, whether
> a fix exists, whether it was reported to a mailing list, and whether it has
> been fixed upstream.
> 
> For issues that we have validated as having possible serious security
> impact, we will not publish it on the public dashboard before going through
> the appropriate kernel security process.
> 
> Dumping everything onto the mailing list may be annoying. During the initial
> stage, reports will be rate-limited and sent manually. We will check for
> duplicates against lore/upstream, and make sure the issue is not already
> fixed or reported.
> 
> Report identity and tags
> ========================
> 
> Each public VEGA report will have a stable identity, similar to
> syzbot reports.
> 
> One possible format is:
> 
>   Reported-by: VEGA <vega+HASH@DOMAIN>
>   Closes: <public dashboard URL>
> 
> =========
> 
> We would like to hear what maintainers think about this before we start
> sending these reports.
> 
> We do not want VEGA to become another source of mailing list noise. The goal
> is to make LLM-based bug finding transparent and useful, and to make sure
> the reports come with enough context, reproducers, suggested fixes, and
> tracking so that they reduce work rather than create more.

-- 
Regards,

Laurent Pinchart

