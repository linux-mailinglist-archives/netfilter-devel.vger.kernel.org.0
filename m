Return-Path: <netfilter-devel+bounces-10537-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGbvLczafGlbOwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10537-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 17:22:36 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A663BC7CF
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 17:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D34300F1B4
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Jan 2026 16:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476C934321B;
	Fri, 30 Jan 2026 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="GCiaQiea"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3388202963
	for <netfilter-devel@vger.kernel.org>; Fri, 30 Jan 2026 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769790154; cv=none; b=dOk0784zjJ8fkaDk4xwhJodae14Dy+RSjBvSxTAGFtpusrB5aP+pz7lz0e6HEP/gMZcuUeshqziqD+VQa4lwYkVLp1hFl6xwQVlEXzNJpWRApTBISkwGQZHen52BzAp+rhXeKtmZM1wZvufyKm6q7fv5XOtMPbRWe6CBlJ78Y5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769790154; c=relaxed/simple;
	bh=4+jwPV9YjcCuUB7IhFCgJO/GFvV/cxcdpAz/mRTtX/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PFTUJaT1m9X0qzBLho19VzfnNdyUhRtS3cOwA04UgsvWJJAbNEHdT+HAs98Ty43NRWN/VVDGfD34TmPYjQppddSUG42tw50SdrRS4pMXALg0IxYM1LLF0zl+IYYu5OYBr10FwX6owIgJFYTx1oFyaEMmCvP6xo/urWsMeyLUY7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=GCiaQiea; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=fZ8KP30DvTpUtmeTjZMnGufkyq2RRkSNlPg0NcTWadw=; b=GCiaQieabPUNx7+6zP/Xhwjuqe
	1gBjpDreuSSt3szeS3vQ1GmLXPzUv0x5y2VkwhlZLcVbCiM9fKIUi7eJyjH71BNhjz7Kk2g7Qdb29
	yqLGFJUdd3hB6cfLBT9yfFJ3mC5aHJE9btQzWSIpbbSg2nZt2ItWPJQaU6/KEdigVzD4wkn86+qZ/
	TLHjTT2q4e89DnlO5rheemQSavdRD2mIp+h5/Svdi/0mDhjMbvyhISRNyWaESZOO023oUIAlDrGP+
	A0Pm8XRrID7g/hE1GEHEOA7ZYDEFpfpgLHkqUrficy8Lm7dLVMQCP+sufeo83404M5DpuGUi2ztdO
	j7h0T8GA==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vlrGQ-000000001mD-2wGu;
	Fri, 30 Jan 2026 17:22:30 +0100
Date: Fri, 30 Jan 2026 17:22:30 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Cc: Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v2] ruleparse: arp: Fix for all-zero mask on Big
 Endian
Message-ID: <aXzaxpX59E4QsWYF@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20260129195700.13553-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129195700.13553-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10537-lists,netfilter-devel=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2A663BC7CF
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 08:56:38PM +0100, Phil Sutter wrote:
> With 16bit mask values, the first two bytes of bitwise.mask in struct
> nft_xt_ctx_reg are significant. Reading the first 32bit-sized field
> works only on Little Endian, on Big Endian the mask appears in the upper
> two bytes which are discarded when assigning to a 16bit variable.
> 
> Fixes: ab2d5f8c7bbee ("nft-arp: add missing mask support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Changes since v1:
> - Use memcpy() to avoid gcc's -Wstrict-aliasing warning

Patch applied.

