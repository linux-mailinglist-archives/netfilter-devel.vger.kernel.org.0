Return-Path: <netfilter-devel+bounces-10444-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HMRJi1AeWmAwAEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10444-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:46:05 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F130B9B34A
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 23:46:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A4C883012C56
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Jan 2026 22:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3723C503;
	Tue, 27 Jan 2026 22:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b="K1oImKHR"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [151.80.46.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255FD78F2E
	for <netfilter-devel@vger.kernel.org>; Tue, 27 Jan 2026 22:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=151.80.46.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553963; cv=none; b=T2e7VYgvCtl495zf/Du53zgAgZW/rrKLPhZ4xVbWpSJI7RT9UTD7TD78eRsbOuq+BWLfKRp0O0rFaRjIweDZMyDKwVNDFr9jDL0Oohw9fMiB4OFQjvcSchE6HrIyuvObTq+3mA0HPt1vDiSFvSAL+JPogLpmybBwbisH8iWRcl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553963; c=relaxed/simple;
	bh=IvLnRxv/okl6XNkXE1G8Q2V9l/oMGAN8pWOCWwFW51o=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ozERMJycPl90yZ7BBVjWEccqs+x8DRH92IaR92lzV9aW5Z0oFYscvJbRSKrBMBLlotyLEsyaxa0TZCXjV6uniJGaO6ttZbwJFM3L1RVmbXYj+jZQyjc1daCBOWitnmSAs3aotcPJJhBy6xiuf8dmuaXOQqUl8a8SMMDTjhdIUWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc; spf=pass smtp.mailfrom=nwl.cc; dkim=pass (2048-bit key) header.d=nwl.cc header.i=@nwl.cc header.b=K1oImKHR; arc=none smtp.client-ip=151.80.46.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nwl.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nwl.cc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
	s=mail2022; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x9B8ks4yptPrMxpVbhgWcFma0zzXiwQ8/LrfQOTBePk=; b=K1oImKHRJTEfw0rjFcjqErdPMo
	nRSaVEI7z5+zrfcnxeU834awdKXWdfOr28UaxwkxZMZt2oGuvuey4qNxCJT4aSOmWLS1JT+9+AqtH
	0Etp4SJZwS9X+Qkg6XMSxjKjs556rAsEzkgLgXU6DTlIzf5V6GTIahnMhbPtwhL7WSX7MOAnjLce9
	3a+5zG5cjoudunkhBvQDD7XwawKOK6lQW6VwOiA/xpCbqmumr0beKttYUbyoP4baiPqfsFfc+MR/e
	Uw/9Pq4GtDegn33xOF0pfeNAeQR+nfa3xkPopVIpt5nsQzOFPRiLXgnJ3WJvqyvNWBzkOPB2aRztq
	Po56poQg==;
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.98.2)
	(envelope-from <phil@nwl.cc>)
	id 1vkrot-0000000037w-2qWJ
	for netfilter-devel@vger.kernel.org;
	Tue, 27 Jan 2026 23:45:59 +0100
Date: Tue, 27 Jan 2026 23:45:59 +0100
From: Phil Sutter <phil@nwl.cc>
To: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] Makefile.am: Drop pointless per-project AM_CPPFLAGS
Message-ID: <aXlAJ4dHytHTQTOA@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	netfilter-devel@vger.kernel.org
References: <20260127223036.32299-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127223036.32299-1-phil@nwl.cc>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[nwl.cc:s=mail2022];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-10444-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[nwl.cc];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[nwl.cc:-];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_ONE(0.00)[1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phil@nwl.cc,netfilter-devel@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[orbyte.nwl.cc:mid,nwl.cc:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F130B9B34A
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 11:30:36PM +0100, Phil Sutter wrote:
> These are redundant, the common AM_CPPFLAGS variable has it already.
> 
> Fixes: c96e0a17f3699 ("build: no recursive make for "examples/Makefile.am"")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.

