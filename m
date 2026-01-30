Return-Path: <netfilter-devel+bounces-10534-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHUPKdusfGkaOQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10534-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 14:06:35 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C74BADE6
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 14:06:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC2903001CE4
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 13:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85FDD2D47EE;
	Fri, 30 Jan 2026 13:06:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51375224AE0
	for <netfilter-devel@vger.kernel.org>; Fri, 30 Jan 2026 13:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769778389; cv=none; b=YMEeDVRtjM1yniuajbCzXta3ZMeuOIupQ/Dttf4qU5u7pT9IGeLBQKZTF8Z3CgXvUpYU7FJq2da0ntRY7f7KPRbURlqXb8nnyUkLCbnmME/CUxa2whskucItElZUAffjKJ5W5TaGLe5PCJCUe/vU5kbabCRVQ56vilD+yVKuWyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769778389; c=relaxed/simple;
	bh=74eu7CLQA44s4+4hBRscG9LXCd3mva/UN0q1L5hCU3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9dUkWsAsr9mL7tOhCnZmFqM4m6CddCNpqYEqM6X5/nDlkmHuNI6gxSY0L4qlmWjfTqaF8ER14BepMlkfwu5lDO2uOKRD495miH+nYZUT8CI+vIQI9/M+asvzysJPMsTpd7u6lm5abjm1qzB7jD+ENSICo0SSn4/bnUXpCfzpw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id E55AC60284; Fri, 30 Jan 2026 14:06:24 +0100 (CET)
Date: Fri, 30 Jan 2026 14:06:24 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] tests: shell: Review
 nft-only/0009-needless-bitwise_0
Message-ID: <aXys0GNWBg9NWuq6@strlen.de>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10534-lists,netfilter-devel=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 11C74BADE6
X-Rspamd-Action: no action

Phil Sutter <phil@nwl.cc> wrote:
> - Avoid calling host's nft binary, use double-verbose mode with *tables
>   tools instead
> - Update expected payloads to match new byteorder-aware libnftnl output
> - Drop '-x' flag from shell

Thanks, this makes it pass for me again.

