Return-Path: <netfilter-devel+bounces-1158-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A90A8701D3
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Mar 2024 13:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118221F22356
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Mar 2024 12:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E7353D39A;
	Mon,  4 Mar 2024 12:49:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC87524B26
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Mar 2024 12:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709556584; cv=none; b=YICB4u0wHbcakrTRTypuiDQ3rEmaYJ6Wpw0jcDOnTESXt9fg0VQghpEjgzd8lOdMH+dXIMm6WO0DFsmYI+c3QudZ15eVPvzqhsrHDcauiGjumhZSlvu/wJXlkoTGfMifAcDkh5G020H1dM8yOtbGSWyjKQJC1QU5R/RmTK4Mok0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709556584; c=relaxed/simple;
	bh=iJMCS6fEhB7JnveJf5wu0cc8FIqaPppvfUPFKEREdSc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5u9rVx8vZdZJ0U1d0TDHYgvfLJaTz/84bl3Hq0+jDqupxIeE+XXFAIuJLKzO7kiqEYBbLCpjBXXm3MN4RQqD5F2amWm0Urqe5t9XK9BjtRDsrJtNMVASkbVFk9SWcBB3ahdfMZhpkhDP7bveT5Z/guzTw4z6G/B1OgWh2fNmsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.33.11] (port=35096 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rh7lB-00CGBZ-6s; Mon, 04 Mar 2024 13:49:39 +0100
Date: Mon, 4 Mar 2024 13:49:36 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Donald Yandt <donald.yandt@gmail.com>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH conntrack-tools v2 0/3] fix potential memory loss and
 exit codes
Message-ID: <ZeXDYANYnRZJCcE8@calendula>
References: <20240302160802.7309-1-donald.yandt@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240302160802.7309-1-donald.yandt@gmail.com>
X-Spam-Score: -1.9 (-)

On Sat, Mar 02, 2024 at 11:07:59AM -0500, Donald Yandt wrote:
> Vector data will be lost if reallocation fails, leading to undefined behaviour. 
> Additionally, the indices of the allocated vector data can be represented more
> precisely by using size_t as the index type.
> 
> If no configuration file or an invalid parameter is provided, the daemon should exit with
> a failure status.

Applied.

I move this description chunks where they belong to

