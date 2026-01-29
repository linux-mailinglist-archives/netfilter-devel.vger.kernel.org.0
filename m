Return-Path: <netfilter-devel+bounces-10518-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id dtYtEzWNe2nnFwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10518-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 17:39:17 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C59E7B2493
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 17:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BD287300AC2B
	for <lists+netfilter-devel@lfdr.de>; Thu, 29 Jan 2026 16:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B01313281;
	Thu, 29 Jan 2026 16:39:14 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA7C28934F
	for <netfilter-devel@vger.kernel.org>; Thu, 29 Jan 2026 16:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769704754; cv=none; b=FteCLwPNvkYCcfMwEwqFNTOEke+hBP0UwF2l82Lmj8KOObeVhgvVuSkS0jiQwt2i8jKLE3u9X00qWyJGgFy+UsKCr+MUYedOhMemEeeF2Xc4jrxd5DWbmJubZn+6wctmIaAsTg0RY01wZQ/689uDrAJi5aaiawvYHWP5XLPimh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769704754; c=relaxed/simple;
	bh=fVHOO4nVZXQ09tv+4UfD9HfjVyj/njCVHD4QqYizEVE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpx+emYtA6Aqz5rTtfOkwQ9HRajTyDI8zDleE6iBhs1oY8ZpraXZuo7RVVx2Z8+2CuyFl3JCYi2x7Bapnwh5lTFebHu7D+6s+/SowL1EfjqGsQMdTVdu0SiM+PoPaNUu7NRKiQiKTw7LIFVuNXwXl0iWTUmB1R9KmeQbx15JDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3CA1460516; Thu, 29 Jan 2026 17:39:11 +0100 (CET)
Date: Thu, 29 Jan 2026 17:39:11 +0100
From: Florian Westphal <fw@strlen.de>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: add test case for interval set with
 timeout and aborted transaction
Message-ID: <aXuNL-gZl4OJ20Vy@strlen.de>
References: <20260129163309.6512-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129163309.6512-1-fw@strlen.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10518-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_ONE(0.00)[1];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:mid,strlen.de:email]
X-Rspamd-Queue-Id: C59E7B2493
X-Rspamd-Action: no action

Florian Westphal <fw@strlen.de> wrote:
> +		elements = { 10.0.0.1, 10.0.1.2-10.1.2.4 timeout 1s }
> +	}
> +}
> +EOF
> +
> +sleep 2

Argh, I keep forgetting I can use sub-ms timeout :-)

I'll push an amended test that completes a bit faster.

