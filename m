Return-Path: <netfilter-devel+bounces-7655-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A0AEC711
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Jun 2025 14:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A5C47A81A6
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Jun 2025 12:25:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 408AB24678D;
	Sat, 28 Jun 2025 12:26:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B591141C63;
	Sat, 28 Jun 2025 12:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751113594; cv=none; b=qcd75uCPMVW9Ni0/jNq6+vL4kbAYbP5kNYwcsOIPl0cWPi7ZPPjpJ70nw+iUVbIr1Us3plrJRMqhAjKezaefj5YoANi39dk7ebJMBjFSvfZC7pwV/yZ00ZVqm4aqsJC23RTORtZ/um1NAkX8nB1YOUFFdbfG5vrIibRgawyxsVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751113594; c=relaxed/simple;
	bh=GMhfCIdbqlpL1GdKcfi2XjpkDe6sdi/nDCnOWy7Hafs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLLGoppdQc7uW2cB59keCV9zvzQsL9W0nRMT9FDHgj7Px28A7MJiRDKEuaFh+iIn/NAraKhhb45QNhk9Z1ypObqMgcdwdhLzyWjbq9S97atpBApcV9nw1XUiYBC4WuukrS/GfJqzD9DHalHWW9MJEmxmjZlNPJpzVFhvf/xmvXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 3854F60489; Sat, 28 Jun 2025 14:26:28 +0200 (CEST)
Date: Sat, 28 Jun 2025 14:26:21 +0200
From: Florian Westphal <fw@strlen.de>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netfilter: conntrack: Remove unused net in
 nf_conntrack_double_lock()
Message-ID: <aF_fbdR3RlP3egz7@strlen.de>
References: <20250628103240.211386-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250628103240.211386-1-yuehaibing@huawei.com>

Yue Haibing <yuehaibing@huawei.com> wrote:
> Since commit a3efd81205b1 ("netfilter: conntrack: move generation
> seqcnt out of netns_ct") this param is unused.

Acked-by: Florian Westphal <fw@strlen.de>

