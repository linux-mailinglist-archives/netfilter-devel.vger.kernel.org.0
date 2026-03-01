Return-Path: <netfilter-devel+bounces-10911-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAPvCQ0+pGlnawUAu9opvQ
	(envelope-from <netfilter-devel+bounces-10911-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 01 Mar 2026 14:24:29 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F801CFEDB
	for <lists+netfilter-devel@lfdr.de>; Sun, 01 Mar 2026 14:24:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C62B3301DBBD
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Mar 2026 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26CD32A3C8;
	Sun,  1 Mar 2026 13:24:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CD732C923;
	Sun,  1 Mar 2026 13:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772371441; cv=none; b=PYHeVKuT88Kto3pFEEbS9aUvDkS0+1p1Iz/fF5PJdVAMQ3RqJzqWk7QZpwmD0nZnP0cJFxVRbLVZvec2K2XHuKCrMuA3tshsxIioW3DnvD9JaRVyT/1t3z2K1x3Gs70fha/00Hj7srbNsXvkh2ai1WHKVjHGRMkZtI7vvtGh7jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772371441; c=relaxed/simple;
	bh=EhL+zwKR3bPa3a4htqR3uD37iVBiUGaI67YNlG9OUOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMWMBQXB/nZYhuCRdfKHxA9stIT8d1CsAOfd9dQYiePnVI3anhQDuLLUATEnZezilCvyF+ky9Nm7YefjnBQ4LHqB0Co24Sp1cELfl6zsr7Aph2AQ2kPESQJRcjK24AhYUPRo28XXAcmxxIroBPyk8vTSrMq1KVS+dbq7nRXTWH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 4A2CF6047A; Sun, 01 Mar 2026 14:23:50 +0100 (CET)
Date: Sun, 1 Mar 2026 14:23:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Julian Anastasov <ja@ssi.bg>
Cc: Simon Horman <horms@verge.net.au>,
	Pablo Neira Ayuso <pablo@netfilter.org>, lvs-devel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	Dust Li <dust.li@linux.alibaba.com>,
	Jiejian Wu <jiejian@linux.alibaba.com>, rcu@vger.kernel.org
Subject: Re: [PATCH nf-next 2/5] ipvs: add resizable hash tables
Message-ID: <aaQ955aj9ONBe695@strlen.de>
References: <20260226195021.64943-1-ja@ssi.bg>
 <20260226195021.64943-3-ja@ssi.bg>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260226195021.64943-3-ja@ssi.bg>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10911-lists,netfilter-devel=lfdr.de];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,ssi.bg:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D9F801CFEDB
X-Rspamd-Action: no action

Julian Anastasov <ja@ssi.bg> wrote:
> +/**
> + * ip_vs_rht_for_bucket_retry() - Retry bucket if entries are moved
> + * @t:		current table, used as cursor, struct ip_vs_rht *var
> + * @bucket:	index of current bucket or hash key
> + * @sc:		temp seqcount_t *var
> + * @retry:	temp int var
> + */
> +#define ip_vs_rht_for_bucket_retry(t, bucket, sc, seq, retry)		\

This triggers a small kdoc warning:

Warning: include/net/ip_vs.h:554 function parameter 'seq' not described in 'ip_vs_rht_for_bucket_retry'

