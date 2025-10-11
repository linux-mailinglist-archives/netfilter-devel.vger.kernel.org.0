Return-Path: <netfilter-devel+bounces-9158-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6F5BCF62E
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Oct 2025 16:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7583189A6E6
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Oct 2025 14:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C6221FBA;
	Sat, 11 Oct 2025 14:04:30 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E551548C
	for <netfilter-devel@vger.kernel.org>; Sat, 11 Oct 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760191470; cv=none; b=jn4+/rsHlXS36JsJTiPa6YrdeAFZaIweIdy4nWUiK46adoycMoCbTMy2s1lmYYGSPcO6tB88zUDcLbNnA/fI4fr/N7ihW1wzrwxPrP6aQsNh6WD7Eq8epxAs2jzNKKAyiQDfRZNhXf7KHS9ibeKh/ZvLKja4qa6XN7aKbC0ZT/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760191470; c=relaxed/simple;
	bh=RsWkhnnlQT/1CN4nxGAHOXUWQuAXvABWTm5I4BUjNdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=epVJ3nZyjc1oU5AAfiu7P62bwdn8kI6sZr9OMrb8LVBd49U2TP+bGi1C4v1/VkQJSgsTUFBfBK+hPiYJJF3lCTiysFGivNnMac7SNiEzg+cTLIlpIDTdhIAr8SYOhRf6HYNJsoK/tg9kQhOAK2EGgQbBJQbN2g1JJtKW2u51daE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id A8B0E60742; Sat, 11 Oct 2025 15:58:41 +0200 (CEST)
Date: Sat, 11 Oct 2025 15:58:41 +0200
From: Florian Westphal <fw@strlen.de>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
Subject: Re: iptables: zero dereference parsing bitwise operations
Message-ID: <aOpigXfhOrj02Qa5@strlen.de>
References: <s5LZtLzqFmQhlD4mtmgcKbrgkfQ-X7k7vvg7s7XnXHekGJSKOMyOdmoiONo7MzuLVqYTFPntt74igf8Q0ERSPy5R9f8L1EfwrhOZbs_nhO8=@protonmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5LZtLzqFmQhlD4mtmgcKbrgkfQ-X7k7vvg7s7XnXHekGJSKOMyOdmoiONo7MzuLVqYTFPntt74igf8Q0ERSPy5R9f8L1EfwrhOZbs_nhO8=@protonmail.com>

Remy D. Farley <one-d-wide@protonmail.com> wrote:
> While messing around with manually encoding nftables expressions, I noticed
> that iptables binary v1.8.11 segfaults with -L and -D <chain> options, if
> there's a rule containing a bitwise operation of a type other than
> mask-and-xor. As I understand, iptables and nft tools only generate rules with
> mask-xor, though the kernel seems to happily accept other types as well.

No, nftables supports this, but iptables does not.
iptables should not segfault, however.  Care to make a patch?

Thanks.

