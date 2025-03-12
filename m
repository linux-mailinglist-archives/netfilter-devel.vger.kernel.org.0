Return-Path: <netfilter-devel+bounces-6343-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 768AFA5E3F3
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Mar 2025 19:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD49E7AD2EE
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Mar 2025 18:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FBFC23C8D8;
	Wed, 12 Mar 2025 18:55:22 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E201E8335
	for <netfilter-devel@vger.kernel.org>; Wed, 12 Mar 2025 18:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741805722; cv=none; b=AD2J2BbhP8ES4bCTiqGKLzB5CTudObt+qecHlEnfRhNi5UdMwHX5etwu5y1mgtQp+uOtXEgASS8ojjPFEQcc3CVY/ceHoG1fnV/iGLA/b9o9P84sY8rGrzLX4SfjSRICgEfC0LSkvTNkf7zOpO3OqvP3pgb7CqIMXk40/00jq8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741805722; c=relaxed/simple;
	bh=cM5OHMrIwGn+/h/3YXeX7Kjk2y2LUgvOMKtthhLuaPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgY+mhsed8pMoul1RYME3gS2tQl0S0ERpXtSeqa2Wr2jQruAGdf0TfOS18DjjvhQtIMksxnGUDi6xU+M3HiSzvX/plaQMm1J4EPDjbefcvFJ5bvFB7E/S7hJ0bXdPVri+d8/lJfw8zRUOUiBTj0RrqLLwhsLBkMS6MTvn2NaDvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1tsREc-00017E-1I; Wed, 12 Mar 2025 19:55:18 +0100
Date: Wed, 12 Mar 2025 19:55:18 +0100
From: Florian Westphal <fw@strlen.de>
To: Corubba Smith <corubba@gmx.de>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH ulogd2,v2 3/6] ulogd: raise error on unknown config key
Message-ID: <20250312185518.GA4233@breakpoint.cc>
References: <1a5fff4d-4cef-48e3-a77c-bb4f7098f35b@gmx.de>
 <e3965ebb-b9f9-46ce-87e5-4960405dbe35@gmx.de>
 <20250312152154.GA28069@breakpoint.cc>
 <ccf47d9d-c620-418d-8143-589340802f70@gmx.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccf47d9d-c620-418d-8143-589340802f70@gmx.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Corubba Smith <corubba@gmx.de> wrote:
> So my proposed fix would be:
> 
> -		strncpy(&config_errce->key[0], wordbuf, CONFIG_KEY_LEN - 1);
> +		memcpy(&config_errce->key[0], wordbuf, sizeof(config_errce->key) - 1);
> 
> Compiles without a warning, and tested to work as expected. Would you
> like a v3 of the whole patch, or is this addendum good enough?

Please rebase and send a v3.

