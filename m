Return-Path: <netfilter-devel+bounces-11828-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPQSCBXL22lnGwkAu9opvQ
	(envelope-from <netfilter-devel+bounces-11828-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 18:40:53 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E42ED3E4E28
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 18:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA33130062DB
	for <lists+netfilter-devel@lfdr.de>; Sun, 12 Apr 2026 16:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0B22DA76C;
	Sun, 12 Apr 2026 16:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Myz7zT68"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4012D8DA3;
	Sun, 12 Apr 2026 16:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012050; cv=none; b=EGuGuMbohm9wnNghUDpiinx0xkCKapXklyOHkWTgMWRARnqScYn1H/MiTuVlwlbCQYMAJ4kEEeGazJ4Hr/KV6M17vKLMNeYR1bW9xPtqxjI904GBC+2Pr/+zFfJjNH5ytAIZzCndEuHi3OTBQJhImjiGAgq6zqe3gPShHdjuMys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012050; c=relaxed/simple;
	bh=ykRAjh4Mbm+RQZsA622iVwa8kSHurZM4yvHxPWyXMOg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OSJALhycFhZfG474z9QlLaIEvjZGYZh07jXNTP0JaxJyKGOfALpfWVMcBZTTZT+QgDCYsHgFbJWKqv9nzct2CiOTHsmffawGA7dtKnWE0lTMBpm+SpjETfd9i1Lbhte4ibH2AFy9AuGdcEllHSZEU4E5UxbPekCU6XpRmQ5eZiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Myz7zT68; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF55C2BCB4;
	Sun, 12 Apr 2026 16:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012050;
	bh=ykRAjh4Mbm+RQZsA622iVwa8kSHurZM4yvHxPWyXMOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Myz7zT681VuNeAfdBI70mvcxOObfrrmFEmOY8P45FWvGa1Cjej3MzDs6s/2CbzU04
	 oLr5xFJTLov29g2ePdP7BVXJ1nhS8hcOpPRAiafA7NJu2S9hiyjvL/YX3KeyoMV+dE
	 LlK0Nd+wTDcho/dgVj6HFAo61DPL+bT+hHE8tADLRvRfRhn6Rj9mSfbUAOpZqNOoj9
	 9sASdZ0nvT+nUysadSzL8AwwIgl4rC8lHs5yecxYhijLu4iiN9DY3czWmbeI/CUR7T
	 nXKI7v7jbcLcyMqDGlFIetadScrX7uVcAUx+h6p3Yj7hWa8QPnAhF0JJiqf9LyKtCv
	 HxfjWoOx0dErg==
Date: Sun, 12 Apr 2026 09:40:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 <netfilter-devel@vger.kernel.org>, pablo@netfilter.org
Subject: Re: [PATCH net-next 00/11] netfilter: updates for net-next
Message-ID: <20260412094049.7b01dd7b@kernel.org>
In-Reply-To: <20260410112352.23599-1-fw@strlen.de>
References: <20260410112352.23599-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-11828-lists,netfilter-devel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netfilter-devel@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E42ED3E4E28
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 10 Apr 2026 13:23:41 +0200 Florian Westphal wrote:
> 1-3) IPVS updates from Julian Anastasov to enhance visibility into
>      IPVS internal state by exposing hash size, load factor etc and
>      allows userspace to tune the load factor used for resizing hash
>      tables.

Someone should take a look at the Sashiko reports for those, please?

