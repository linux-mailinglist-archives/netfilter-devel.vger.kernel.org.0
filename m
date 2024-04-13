Return-Path: <netfilter-devel+bounces-1782-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5689E8A3975
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Apr 2024 02:54:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC70F2836A4
	for <lists+netfilter-devel@lfdr.de>; Sat, 13 Apr 2024 00:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A17192F56;
	Sat, 13 Apr 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZYcF0pL"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77486D272;
	Sat, 13 Apr 2024 00:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712969655; cv=none; b=YnGr47qkH6QrWPyUCgukHbInlMo5aP2QKG91UG1DlFVr6U58fWMoABksSegGwaiw/T3hGRtXeQdy5G0UesBel1VgI3el6g22NN0uTTFxEBv198LV2KZ8fOVlv1FkgzcvvBLGNP4LYuZW8m7PWeoMH2YGjayQ8LHm5A7STyiGg1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712969655; c=relaxed/simple;
	bh=z1L3Y8/XCJm03C3FMAVqpR8mO47p0JHfUafwQ35R7vc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IDWsiPowrRRssSvJDtFABbihOa+OIfEnSpUz9GRdMDSZvvG7RdtveSP4cUtWe3rlpgv73ppprIPu3ja4YMx2uJje4h4Hh/ZesWD0chulr6gIhXR6rVTvF84wAIqe+7adoS0TCFgdTKfrzerekzGGyFrpW0XoFFYu4hX4fdwJsWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZYcF0pL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C7EFC113CC;
	Sat, 13 Apr 2024 00:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712969654;
	bh=z1L3Y8/XCJm03C3FMAVqpR8mO47p0JHfUafwQ35R7vc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DZYcF0pLO/RJSAJpfvH1NoLlQVumsOt1VkBYAoMLTPUjZDo2vpJPKXrb4/K2g0NK6
	 nMRarAnGNAi/OK5k52CcbErADOh6xY+MTujMA7gBRyQ3+UdTPX018o8CcI/Ji1lRyF
	 F12TkTNyzSWDyAy8rdJZDUr0ijYvDmoYDi/GoFWKc7xfgDrlIgE2Zf82gdzhjmdgpc
	 YfhOmhCOKtqI9256StqMnstn7wgM9IjPNOTK98Zy8ccWhsbKAamTThCCGYewAsevjJ
	 c6nvXn7bQzsmmIFpGF/AEyTdyukT9ZDmeQml+1tqBEX6jFlJkGxcSSWRBZC6InlSYW
	 CZdPz7Jgncp9w==
Date: Fri, 12 Apr 2024 17:54:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH net-next 00/15] selftests: move netfilter tests to net
Message-ID: <20240412175413.04e5e616@kernel.org>
In-Reply-To: <20240411233624.8129-1-fw@strlen.de>
References: <20240411233624.8129-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 12 Apr 2024 01:36:05 +0200 Florian Westphal wrote:
>  create mode 100644 tools/testing/selftests/net/netfilter/lib.sh

FWIW one of our checks points out this file should be listed under
TEST_INCLUDES so that ksft install vacuums it in.

