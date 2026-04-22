Return-Path: <netfilter-devel+bounces-12131-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MxrJirT6GklQQIAu9opvQ
	(envelope-from <netfilter-devel+bounces-12131-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 15:54:50 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51701446F80
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 15:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF3A43019538
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Apr 2026 13:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30DF22D0C7B;
	Wed, 22 Apr 2026 13:51:21 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04CBA19AD5C;
	Wed, 22 Apr 2026 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776865881; cv=none; b=lZiamxQaHowiCcYsiDYZ9KBtCPvRsfUb6GlmD0Ot11wtppwxJdi95HJk7gHaErl1jBCjupTl9elU6X2fnCBwbV92vGWfFdTSfXDyiQHQaGsTuReFBf1vcrIm4qFs5xrLP6HHDamDcrglwcjL+piXv15uk3NYblkZxRhhA1T+Qko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776865881; c=relaxed/simple;
	bh=TfUf5P/ZH414X6ziQV7zEfFP2CvK/Zx8bpWlZdkh0Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUNOVH3V0CkeAHs3G+hErXOx2ygVim5fs6Jjl/+V767pJtgaQOLwv2a5iR3FqxNW51kwK405Tn5Syw4of74bOvC02IsPuBkj3KvQvzzi4g68IBVRiOHst7p0acN3ktmpBHcWiLJtFiPXciycgtrRfPs7OrGdNa6L6qHrDyNno20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 57E6160890; Wed, 22 Apr 2026 15:51:10 +0200 (CEST)
Date: Wed, 22 Apr 2026 15:51:09 +0200
From: Florian Westphal <fw@strlen.de>
To: Vastargazing <vebohr@gmail.com>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] selftests: netfilter: add nft_ct timeout destroy
 race test
Message-ID: <aejSTa7PcHkaOs4C@strlen.de>
References: <20260422131818.106417-1-vebohr@gmail.com>
 <20260422131818.106417-2-vebohr@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422131818.106417-2-vebohr@gmail.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12131-lists,netfilter-devel=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nft_ct_timeout_concurrency.sh:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51701446F80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Vastargazing <vebohr@gmail.com> wrote:
> new file mode 100644

This should say '755', else you get

# Warning: file nft_ct_timeout_concurrency.sh is not executable

I'm not sure we should add regression tests for regression tests sake.
Else we'll quickly accumulate thousands of such scripts and test
run time will explode.

A functional test for timeout policies would be much more useful.
We have a few of those in nftables.git but they ony check that
userspace and kernel parsing sides work.

