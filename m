Return-Path: <netfilter-devel+bounces-4599-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC5A9A69B3
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2024 15:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D67C41F23834
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2024 13:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D7C194C62;
	Mon, 21 Oct 2024 13:05:56 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3ECD1EF953
	for <netfilter-devel@vger.kernel.org>; Mon, 21 Oct 2024 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515956; cv=none; b=Ik88tTrZxyCKBF96yuRNaGo+scUuMxbgwu5LHHquo0uouMgD84e8KDWPeXKYMfNHFBPwtb2gfoIPg6xzza+MNc2XgnmK25IoJ3rbW0KTd2RgrrgNbwzv+T4jnV48f7AcQLAjNYCQGBoOAWv9cpVMcxdGXSEMXXMaT0hrpOphGkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515956; c=relaxed/simple;
	bh=6ry5uotO8HUdOo5ap6Zg5BzI0sxeAmjFmUWz2PM4ZZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kd/U47Mctsjbgei7Qaovyiuk+2hXFqd9PyDeOYMsMcVCAtxOJ9rdTO3H7IKvMQy+1xHJLAp8xXN67dWRj8BkBsot0xTVF1MRg2+4aIUYKaruzZ6HuzPZZ/X+gxgSqxcaduxAFBDfeBWnPz4FNUnAzCO9ifffvosMugr0nV4bfrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1t2s6S-0004AB-NZ; Mon, 21 Oct 2024 15:05:44 +0200
Date: Mon, 21 Oct 2024 15:05:44 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Eric Garver <e@erig.me>
Subject: Re: [nf-next PATCH v5 00/18] Dynamic hook interface binding
Message-ID: <20241021130544.GA15761@breakpoint.cc>
References: <20240926095643.8801-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240926095643.8801-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)

Phil Sutter <phil@nwl.cc> wrote:

I started to review this, I would suggest to apply the first 10 patches
for the next net-next PR so that its exposed to wider audience.

