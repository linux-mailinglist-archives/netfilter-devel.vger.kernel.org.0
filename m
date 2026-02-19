Return-Path: <netfilter-devel+bounces-10805-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IOviEVB4lmkQgAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-10805-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Feb 2026 03:41:20 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9379315BC27
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Feb 2026 03:41:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAB23016514
	for <lists+netfilter-devel@lfdr.de>; Thu, 19 Feb 2026 02:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0251426ED3C;
	Thu, 19 Feb 2026 02:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fCqf0FfQ"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCA231EEA49;
	Thu, 19 Feb 2026 02:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771468875; cv=none; b=LAQMmnYSxree1629MGnnJZSSRXzAfK4ilrw/XkK3VC0xLOHWT+0jHqkNYqhuw+jKq893yoRgKQeHiamqCso/IzKzSDZKF0UaTrnOS1zx634H4GJfn2t4MK9BlVgL7CJ2TPRk8sRzJx+qw8pQzm689lDtPr4/kuMSMgClcZiYFks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771468875; c=relaxed/simple;
	bh=4qa8PM3QPfyLTwp+FHLkYksJ0nocHdKpD92Kq/ehAd8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QaSV+Z49QioGMu5IS44+8kS5RNEm/jN3AYJ1vI1sNDAIPSSD+Ly7ektlFTELDxWutcz5qOW/3xUJM8zQ3HC3648oPwZSR2NvDoOCvaMZOpqXYcSxaSQyuDrmBaw7NY+WaWjx4VAj7AHAVr3SpRdKA7NkF+kWYdiWhuY4fvO6miU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fCqf0FfQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00494C116D0;
	Thu, 19 Feb 2026 02:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771468875;
	bh=4qa8PM3QPfyLTwp+FHLkYksJ0nocHdKpD92Kq/ehAd8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fCqf0FfQ44kpqiSjDNNB6gl47x+N/OUeGKrD04ZXONxYYyu7JzxYdTcROOKJev87P
	 Ne2Dz7uKcYJJBerTnnIaZ0Yx/MBVcDG3I1snIDtPPRrNNjiqZuyNIisPq6FUNIl8xa
	 SVyoNznmYH/8VdyrTl+bnWeZZYdeDeyR5DP2hD9AiMudR4QFcFauJzzuZMIdJx1w40
	 UcIAavoN56fix+v8Cprtm9vBAYPVOYthjB1vaoU5tVcFBRStAsmYgTAVtbTzpNgOhJ
	 yQKvbKV/OICQMI1DukGMMqf+ZRaw13qJlAaYOGMr7FzzC4EXWWQKaSZggZQt1LGPuK
	 2bmBZSc7opVaA==
Date: Wed, 18 Feb 2026 18:41:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netfilter-devel@vger.kernel.org>, pablo@netfilter.org
Subject: [TEST] nft_queue / test_udp_gro_ct flakes
Message-ID: <20260218184114.0b405b72@kernel.org>
In-Reply-To: <20260206153048.17570-4-fw@strlen.de>
References: <20260206153048.17570-1-fw@strlen.de>
	<20260206153048.17570-4-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-10805-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url]
X-Rspamd-Queue-Id: 9379315BC27
X-Rspamd-Action: no action

On Fri,  6 Feb 2026 16:30:40 +0100 Florian Westphal wrote:
> Without the preceding patch, this fails with:
> 
> FAIL: test_udp_gro_ct: Expected udp conntrack entry
> FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 10 and 0

Hi Florian!

This test case is a bit flaky for us on debug kernels:

https://netdev.bots.linux.dev/contest.html?pass=0&test=nft-queue-sh

It's 3rd flakiest of all netdev selftests at this point.

Example:

# 2026/02/12 10:14:22 socat[20338] W exiting on signal 15
# 2026/02/12 10:14:22 socat[20383] W exiting on signal 15
# FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 12 and 10

