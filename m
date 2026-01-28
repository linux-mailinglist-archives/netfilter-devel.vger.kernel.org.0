Return-Path: <netfilter-devel+bounces-10481-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFg5CPUxemlr4gEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10481-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:57:41 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95AF8A4CE1
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 16:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 015F1312B227
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Jan 2026 15:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EF23570D4;
	Wed, 28 Jan 2026 15:45:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1C350D44
	for <netfilter-devel@vger.kernel.org>; Wed, 28 Jan 2026 15:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769615143; cv=none; b=FiDXM8NiidxOW9lUVVcPhCgfa9KDo2Rzzko4JLsO7q1bFW+uoViQxRPyE3jTZ9sxlVUjfES7wlPdOz+1Qo1BCwRr8bD4fDUVfA6xxmO/9qpNHNxhz/Wwj9H7k4tf7DuJyfTLcnJHu4BF/0RToWMbeVsh/6aqsAwecPsX6f47Kbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769615143; c=relaxed/simple;
	bh=sRJMxEHiWKRaDqce1HIJXy+s/KXi+nXrTTTNO5HZ0f8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGdYxECWvmfe+2i+jy7HN66rDoya+cj57l5QSNBCt2HaEJzYenRPA6cB0OsszLfWnTqKl0HsMhJTJgeKWLrpPifmwYWlUAObSDzZS4FYUBtrQzD97Cuns3iGSfy9AeEtxI6P+5eQbdrFFGqZVz368zJVp35DE5FXHXX3GXmhGrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id C7BA6605C1; Wed, 28 Jan 2026 16:45:40 +0100 (CET)
Date: Wed, 28 Jan 2026 16:45:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/4] nf_tables: complete interval overlap
 detection
Message-ID: <aXovJVWj5PD-wrN9@strlen.de>
References: <20260128014251.754512-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128014251.754512-1-pablo@netfilter.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10481-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 95AF8A4CE1
X-Rspamd-Action: no action

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Overlap detection from the kernel in interval sets is still missing a
> few corner cases, this is currently mitigated by nft from userspace by
> dumping the set content for each add/create element command.
>  
> This series is composed of:

Looks good to me.  I've held this back because syzbot found a problem
with rbtree + bsearch blob getting out of sync in some cases and
I would prefer to first get things back under control before making
more changes to it.

I wasn't able to fix all of the problems so far and need more time
to add relevant test coverage.

Once rbtree is back to 'syzbot is happy again' state I will apply them.

Sorry for the inconvenience.

