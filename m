Return-Path: <netfilter-devel+bounces-11118-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOXFKEtCsWl0tAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-11118-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 11:22:03 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6AA262065
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 11:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67A423616EF8
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2026 09:47:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39673CCFC2;
	Wed, 11 Mar 2026 09:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="gFWQb70j"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCD3C5548
	for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2026 09:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773221994; cv=none; b=DHFa1CJhSo1KU7cRiN0NTDg9s6dPRCJKJwoy2kwDmY1rPDhwCwBic/r+BN8p7d1w/beE3JMzIjLImZmIGSNpDyyBpFpEOp+N6RJozcks5neoAm1B3mnBJz9zxvvmraHl7NQXO6htrAmCJT9EObxlI0gA8Q0VPxPaxG+10AUnNcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773221994; c=relaxed/simple;
	bh=7VRP4Aa9j+K13V8Wgk7jopyPn5I/NAlP2p7fxQUO3Ko=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5CptYm9K/IZyatncQ9TUA4AiYHZpIMm/fM88H33BKHN7nm/C8vw9t+vP2aqKy4TiKXYLIoC87lwVz4pIV5NSoSpJ5dbiRWLx9LBAhdVPfoFNeb/jwPOVbWHpbhtg0uUtC7POm2zNosNQ7rLXnPrgotuvRRHW5F4Ca/q7um0oBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=gFWQb70j; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 9466D602B4;
	Wed, 11 Mar 2026 10:39:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1773221991;
	bh=YEAvjeAdKxLkQIxCMM3wPS+0MU5VsLgNMj5NUBwqH0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gFWQb70jfo1QPOTqxDHaGIvpctGGl4krl3jcrNaWwmwCS6P1RCTkVJc+rHkmgzy3L
	 lhscImZvhBb3c6NBuFhK4flNIGYeMx7D3cZDyQ97rrn/GpdMFoz4j+Vn7ox4j6b7d4
	 dnYCdfQRJpdJeHQsOmndnpRJ8GdOoglFWt2IeHZiY1sx/dqaTsFtcu2sKJBHlzCmq8
	 5rsMqW9+KDtSJeXyLHAhgpWCfs46xqNAzCaYIVhudOfhfwHhXm1vN43mBLsopGO5Tq
	 fyedU8Ucz/JECsP73ufpBaJe1FeUNEOTlMza+Yj+HzN6wiOxDbpjhCVtgVoKQdT7f6
	 mnR0P/odbMGuw==
Date: Wed, 11 Mar 2026 10:39:48 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 4/5] cache: Filter for table when listing sets or maps
Message-ID: <abE4ZHagAWhI-8cV@chamomile>
References: <20260310231115.25638-1-phil@nwl.cc>
 <20260310231115.25638-5-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260310231115.25638-5-phil@nwl.cc>
X-Rspamd-Queue-Id: 2B6AA262065
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11118-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,netfilter.org:dkim,netfilter.org:email,nwl.cc:email]
X-Rspamd-Action: no action

On Wed, Mar 11, 2026 at 12:11:14AM +0100, Phil Sutter wrote:
> Respect an optionally specified table name to filter listed sets or maps
> to by populating the filter accordingly.
> 

Fixes: a1a6b0a5c3c4 ("cache: finer grain cache population for list commands")

> Signed-off-by: Phil Sutter <phil@nwl.cc>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

