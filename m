Return-Path: <netfilter-devel+bounces-4547-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EDBA9A22E4
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2024 15:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D0AA1C2146C
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2024 13:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D76E1DDA20;
	Thu, 17 Oct 2024 12:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IdPqZ8at"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACA51DB346;
	Thu, 17 Oct 2024 12:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729169999; cv=none; b=QPhOTcFfy3u98fUVuJRd6Y3n/FAGBpcNLUW2QOS676UF/YjqNmnCLxLo4hHYRDb6o+vK6Z/ZqRHeq21HhFpqrXZ7bocjIzqzsZ/MBac4YE0dvuhDkVd+OHaDYRmL45Yrwco8sHp9vwQah6CLTsH4M3mTgyx5I46hNiuJKpyciUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729169999; c=relaxed/simple;
	bh=YOZCH60pS1Se/2HsDojbhYFYSgrcFk/30n+UQMt0dZ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lpcmDM6zpcbCY3m2BsmA9kE0cdtsFYxiidmnN+B1Nx6JxPenqPIFKfPr4+sP4Euk7of1rOBPukE59TerYcRqV1OoxzJYY4rU0/0NCRyCS/U9mqlmbut0hUvzdPfopel3gJQWt7TW6XIp3VYcTKaBWJ+bfaZtmDku1qvGNid+REQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IdPqZ8at; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69657C4CEC3;
	Thu, 17 Oct 2024 12:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729169998;
	bh=YOZCH60pS1Se/2HsDojbhYFYSgrcFk/30n+UQMt0dZ8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IdPqZ8atudZ9qKVqW7AlhqQOQJrTUZBkXcpP6cCrBieF+KEsw7ZZiexSd0+lqehRP
	 5hkzdoqE/aycN6EJYpX8eIckN6wwo4anAoQQSM+8Ily0XolrP92Oe/ShbMuMPpWMmF
	 eInmrFKvBy7nvRK8glJ7GU53jzGhLvB5UAl1kvIFsfJmkVWPXctkOca8znJV5HKtnB
	 PTeRtjFsBGt/UeimPMEBK3oCm/iBMTwoHr+s0MxBv4XUXK7lmFLIh+4HqoQWB6mQEj
	 fwvzmdQpGP3E0ssid0xxQP+WB4jYmAmHcz1NGgVyeIRvLiXKnR4XPnFrjsn9g+wmCF
	 XIPwyygrAtaKA==
Message-ID: <49bc2227-d8e1-4233-8bc4-4c2f0a191b7c@kernel.org>
Date: Thu, 17 Oct 2024 14:59:48 +0200
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [RFC PATCH v2 1/8] landlock: Fix non-TCP sockets restriction
Content-Language: en-GB
To: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, mic@digikod.net,
 gnoack@google.com
Cc: willemdebruijn.kernel@gmail.com, matthieu@buffet.re,
 linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, yusongping@huawei.com,
 artem.kuzin@huawei.com, konstantin.meskhidze@huawei.com,
 MPTCP Linux <mptcp@lists.linux.dev>
References: <20241017110454.265818-1-ivanov.mikhail1@huawei-partners.com>
 <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20241017110454.265818-2-ivanov.mikhail1@huawei-partners.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Mikhail and Landlock maintainers,

+cc MPTCP list.

On 17/10/2024 13:04, Mikhail Ivanov wrote:
> Do not check TCP access right if socket protocol is not IPPROTO_TCP.
> LANDLOCK_ACCESS_NET_BIND_TCP and LANDLOCK_ACCESS_NET_CONNECT_TCP
> should not restrict bind(2) and connect(2) for non-TCP protocols
> (SCTP, MPTCP, SMC).

Thank you for the patch!

I'm part of the MPTCP team, and I'm wondering if MPTCP should not be
treated like TCP here. MPTCP is an extension to TCP: on the wire, we can
see TCP packets with extra TCP options. On Linux, there is indeed a
dedicated MPTCP socket (IPPROTO_MPTCP), but that's just internal,
because we needed such dedicated socket to talk to the userspace.

I don't know Landlock well, but I think it is important to know that an
MPTCP socket can be used to discuss with "plain" TCP packets: the kernel
will do a fallback to "plain" TCP if MPTCP is not supported by the other
peer or by a middlebox. It means that with this patch, if TCP is blocked
by Landlock, someone can simply force an application to create an MPTCP
socket -- e.g. via LD_PRELOAD -- and bypass the restrictions. It will
certainly work, even when connecting to a peer not supporting MPTCP.

Please note that I'm not against this modification -- especially here
when we remove restrictions around MPTCP sockets :) -- I'm just saying
it might be less confusing for users if MPTCP is considered as being
part of TCP. A bit similar to what someone would do with a firewall: if
TCP is blocked, MPTCP is blocked as well.

I understand that a future goal might probably be to have dedicated
restrictions for MPTCP and the other stream protocols (and/or for all
stream protocols like it was before this patch), but in the meantime, it
might be less confusing considering MPTCP as being part of TCP (I'm not
sure about the other stream protocols).


> sk_is_tcp() is used for this to check address family of the socket
> before doing INET-specific address length validation. This is required
> for error consistency.
> 
> Closes: https://github.com/landlock-lsm/linux/issues/40
> Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")

I don't know how fixes are considered in Landlock, but should this patch
be considered as a fix? It might be surprising for someone who thought
all "stream" connections were blocked to have them unblocked when
updating to a minor kernel version, no?

(Personally, I would understand such behaviour change when upgrading to
a major version, and still, maybe only if there were alternatives to
continue having the same behaviour, e.g. a way to restrict all stream
sockets the same way, or something per stream socket. But that's just me
:) )

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.


