Return-Path: <netfilter-devel+bounces-2775-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D418917FBC
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2024 13:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5A661F27852
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2024 11:32:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3592C178387;
	Wed, 26 Jun 2024 11:32:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [213.95.27.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F92316A94A
	for <netfilter-devel@vger.kernel.org>; Wed, 26 Jun 2024 11:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.27.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719401574; cv=none; b=P8IEqH1mosFh3kBKaPWQ21dhVZRrWVWsL/zCemM8vfZOJAwo46iEqzfeG7niHNTejntWw38WIwn9Ua9B7eelthoIWQjg/cFlYDz9aWhKMIyfM4nZhqYa2WgaMPqtYuCOl4D/kiteg2iG9HkIQ0Sy+1YM02a82FKoXG1xmueMV3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719401574; c=relaxed/simple;
	bh=N8twmhQFXRGPcwVqpfzsP3sQv4MvIKfZnF80cu+7Ajw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZfUFwCckcGiT3A1b4+4bMibqVwRs64fvxFb9sAU1XxVZQKUs3wqV7s5mGeiV7v4ZUrlH5WDTLA8LySVq+vDmKn6wPwg4Z6oQSK0LRy6UpsQ1SsnNER4PWGg/voy+8kJQ5WQYa5C+hfed/F3XhGYtl55NwOO3u0JJCHDjvQCzMKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=gnumonks.org; arc=none smtp.client-ip=213.95.27.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnumonks.org
Received: from [78.30.37.63] (port=55524 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1sMQtH-007sBn-A9; Wed, 26 Jun 2024 13:32:46 +0200
Date: Wed, 26 Jun 2024 13:32:42 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Yunjian Wang <wangyunjian@huawei.com>
Cc: netfilter-devel@vger.kernel.org, kadlec@netfilter.org, fw@strlen.de,
	kuba@kernel.org, davem@davemloft.net, coreteam@netfilter.org,
	xudingke@huawei.com
Subject: Re: [PATCH nf-next v2] netfilter: nf_conncount: fix wrong variable
 type
Message-ID: <Znv8WltX-A3aZ_eD@calendula>
References: <1717127327-22064-1-git-send-email-wangyunjian@huawei.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1717127327-22064-1-git-send-email-wangyunjian@huawei.com>
X-Spam-Score: -1.9 (-)

On Fri, May 31, 2024 at 11:48:47AM +0800, Yunjian Wang wrote:
> Now there is a issue is that code checks reports a warning: implicit
> narrowing conversion from type 'unsigned int' to small type 'u8' (the
> 'keylen' variable). Fix it by removing the 'keylen' variable.

Applied, thanks

