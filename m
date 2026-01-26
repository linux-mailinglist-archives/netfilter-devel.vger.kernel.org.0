Return-Path: <netfilter-devel+bounces-10413-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wC6qIE10d2n7ggEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10413-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 15:03:57 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E94FE8949A
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 15:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 10726300B9E1
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 13:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCD533ADAC;
	Mon, 26 Jan 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzYV1yNg"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6533AD90;
	Mon, 26 Jan 2026 13:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769435798; cv=none; b=FO2Deyrzn4OiweA+zm80iltHzfLCJnoHGFHEJIMgbp9rNwmkEwVm7DVCN3RtoyWKd9g1KumFkesICld5IiRnc6k96Le2Oo0ekISQPxfJE92Us2hSRAneTL61mAIJ3/LhPds86FM41A0c0J3ljY7jlO6cv+d1wkrlgmq3gThrwDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769435798; c=relaxed/simple;
	bh=04a/VV6VOmIqWD5Ds4BSeW2LLTscE1DzMTZgVcCLQ7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NQ9+5vQaw8m7aDJ1BJdoyXLCTRLgHWs82TWurUaaLhyO7Ov3d9VgB71G1l48wpCm3DyY7zqR6dis8/CHAu4XKPw4C9XAz7TTGc2AA+4+8vGBItGPFt6cLRPi5vJNBVggfxepntFkvCCOEzvDCbPgPw95/C4tHTHPXpIrjuOXs0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzYV1yNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BDFC116C6;
	Mon, 26 Jan 2026 13:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769435798;
	bh=04a/VV6VOmIqWD5Ds4BSeW2LLTscE1DzMTZgVcCLQ7E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KzYV1yNgmvuvADWNKqbnyENwBhcMumCmSutGhY22rioGcEBGF+n27MPP98HjU5QSe
	 CHC3Ko8o64gvk8IN+2WKsG5gmhvv0Z7NndRvu3TO4T6uIiw7EwDLMPkULf1X/skWtG
	 qewKnenKjv0QMLvjcw9jRqrWf6aSo4Gh0A8yaSY2Mxt0+17hF4dHlMGvHK+WFYzTZr
	 eBg33pEyA3amS1R3YVSghXig+W/wWO/AHeWrI8ya4J/yt5A1j1jbXjzyqdQlSlCJRm
	 q9zirG3UgzzwAigAZEBqi2G8Cgv0SZQkA2ynGuxNeyod4G5b+p0UDwp387jU6gEvUC
	 Kjvj2Wl2VMb6A==
Date: Mon, 26 Jan 2026 13:56:33 +0000
From: Simon Horman <horms@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] netfilter: xt_time: use is_leap_year() helper
Message-ID: <aXdykTYHStzwgNTt@horms.kernel.org>
References: <20260123081051.336239-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123081051.336239-1-ruanjinjie@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10413-lists,netfilter-devel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: E94FE8949A
X-Rspamd-Action: no action

On Fri, Jan 23, 2026 at 04:10:51PM +0800, Jinjie Ruan wrote:
> Use the is_leap_year() helper from rtc.h instead of
> writing it by hand
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


