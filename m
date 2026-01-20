Return-Path: <netfilter-devel+bounces-10327-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PStI6azb2nHMAAAu9opvQ
	(envelope-from <netfilter-devel+bounces-10327-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 17:56:06 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 214CA480F5
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 17:56:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE8D386E01D
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jan 2026 14:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64ADF43CEF1;
	Tue, 20 Jan 2026 14:35:15 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FA043D4FE
	for <netfilter-devel@vger.kernel.org>; Tue, 20 Jan 2026 14:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768919714; cv=none; b=ejqA9UgIgFcALk6fC90bc72F3t7yKSB2Giw0C7aPyrAG8HIRyznEE5vP74ppzargTb3D7eXE5w/zxVjgjZOpBGezvP9VhbIU7EdwCtCfin/Q10vJxZHzUX8wqmU2im+BJ+svCwtGQ5nznebrrhkP2tUVWcuza3OKuv3/WD9kuzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768919714; c=relaxed/simple;
	bh=Aca5frLAx+PtJhq6l11i0Pm1ZvWrVDm4h/yHuPrIsEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MceFdlYaVYnBs42+dqu0UmPaXPs4o89xcSspmKIhbkt8+5KloRTqxuflH8In47/dLlbp345wNuB9CWei9q1WlywhvWT8vIkOFUNCQs4bSdyamKAXce+KpV9bjeRcqZOAuNKHYE3TyVOXU2cvFQkQFOLTh9HjPNAwq6GIUXC8DFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 59A9060260; Tue, 20 Jan 2026 15:35:05 +0100 (CET)
Date: Tue, 20 Jan 2026 15:35:05 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 6/6] scanner: Introduce SCANSTATE_RATE
Message-ID: <aW-SicaUzUULQFv9@strlen.de>
References: <20251209164541.13425-1-phil@nwl.cc>
 <20251209164541.13425-7-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251209164541.13425-7-phil@nwl.cc>
X-Spamd-Result: default: False [-1.26 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_NA(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-10327-lists,netfilter-devel=lfdr.de];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nwl.cc:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 214CA480F5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Phil Sutter <phil@nwl.cc> wrote:
> This is a first exclusive start condition, i.e. one which rejects
> unscoped tokens. When tokenizing, flex all too easily falls back into
> treating something as STRING when it could be split into tokens instead.
> Via an exclusive start condition, the string-fallback can be disabled as
> needed.
> 
> With rates in typical formatting <NUM><bytes-unit>/<time-unit>,
> tokenizer result depended on whitespace placement. SCANSTATE_RATE forces
> flex to split the string into tokens and fall back to JUNK upon failure.
> For this to work, tokens which shall still be recognized must be enabled
> in SCANSTATE_RATE (or all scopes denoted by '*'). This includes any
> tokens possibly following SCANSTATE_RATE to please the parser's
> lookahead behaviour.

Series:
Reviewed-by: Florian Westphal <fw@strlen.de>

