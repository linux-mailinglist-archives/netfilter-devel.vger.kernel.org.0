Return-Path: <netfilter-devel+bounces-3865-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8151E977E62
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2024 13:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3DF41C217E1
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2024 11:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2CA01D86D8;
	Fri, 13 Sep 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amSm8OHH"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB56187849;
	Fri, 13 Sep 2024 11:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726226257; cv=none; b=dh+41aGd94teP+KrbuY22ODLuj+9WNcHZqqSejS+i2G76pQi1/DrJ8y+UpunryCM3FZnDggQW+Qynjx3mgT14FWTkOmP4cu9oZV3oePwXBKgn0Dknnlne0TJA7IS87yz4tgFdMUGfMpjdngEP1zfqzHNkkpA2hMsU4k+fw1VLVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726226257; c=relaxed/simple;
	bh=68sScwS5SIib1G11p6Hu/7v3V+LPBdR0qoLi2atvoIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XF8GjSYQJd6huP5QRv3HPVixeYTMJCDABfhhSSNYAvB1tQWHMprG3TZIkk4P/irDv9Mai1L5yW+HCTZM0GglvkthbsdszAX9v1LGP30xde4HUZryMGWIGyZdzHH6uf7j2dF4ikmgyAXAB/nHfp4lgYgZDUrixQ7eKwaF3/pN1FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amSm8OHH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B20DC4CEC0;
	Fri, 13 Sep 2024 11:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726226257;
	bh=68sScwS5SIib1G11p6Hu/7v3V+LPBdR0qoLi2atvoIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=amSm8OHHk+ZZCy+kx4/gf8t7jUfsLnkxhQlFtLTDaCKn+QzykUnNG+XJB9rBtuZds
	 X8bSX10FjTrLNrsbwqvjo7co4kImG/ZuMW+Di4dxeywgBZhPeU19cDCp6R7ikPSVX7
	 apgaBHrguVmIbc7fu4VB4L4kElXaYwav9vknxzAOMMT7rUQ82cBT+mIqhGROeTK2kx
	 k7WXCdd7nDv3NTTrlGAh5YoJ4qWY+TXVfwMPqDX0K7x0WNx5jNQ1XHbcCIz/S6v1c3
	 AHFWXFnKoeENM6P4pEh6/bckzbJT2otXItn+RUPyvMphWwUlKCe+Sa2MMsrjgA50y5
	 bAAWqNThLGWuQ==
Date: Fri, 13 Sep 2024 12:17:32 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Stitt <justinstitt@google.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	bridge@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH] netfilter: nf_tables: replace deprecated strncpy with
 strscpy_pad
Message-ID: <20240913111732.GV572255@kernel.org>
References: <20240909-strncpy-net-bridge-netfilter-nft_meta_bridge-c-v1-1-946180aa7909@google.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909-strncpy-net-bridge-netfilter-nft_meta_bridge-c-v1-1-946180aa7909@google.com>

On Mon, Sep 09, 2024 at 03:48:39PM -0700, Justin Stitt wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings [1] and
> as such we should prefer more robust and less ambiguous string interfaces.
> 
> In this particular instance, the usage of strncpy() is fine and works as
> expected. However, towards the goal of [2], we should consider replacing
> it with an alternative as many instances of strncpy() are bug-prone. Its
> removal from the kernel promotes better long term health for the
> codebase.
> 
> The current usage of strncpy() likely just wants the NUL-padding
> behavior offered by strncpy() and doesn't care about the
> NUL-termination. Since the compiler doesn't know the size of @dest, we
> can't use strtomem_pad(). Instead, use strscpy_pad() which behaves
> functionally the same as strncpy() in this context -- as we expect
> br_dev->name to be NUL-terminated itself.
> 
> Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
> Link: https://github.com/KSPP/linux/issues/90 [2]
> Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> Cc: Kees Cook <keescook@chromium.org>
> Cc: linux-hardening@vger.kernel.org
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
> Note: build-tested only.

Reviewed-by: Simon Horman <horms@kernel.org>

