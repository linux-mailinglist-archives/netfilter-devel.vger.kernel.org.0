Return-Path: <netfilter-devel+bounces-599-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6588982A45F
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 23:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 169921F23242
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 22:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8F54F886;
	Wed, 10 Jan 2024 22:57:43 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875E4F8B5
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jan 2024 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNhVy-0003YU-Bu; Wed, 10 Jan 2024 23:57:38 +0100
Date: Wed, 10 Jan 2024 23:57:38 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft 4/4] Revert "datatype: do not assert when value
 exceeds expected width"
Message-ID: <20240110225738.GB28014@breakpoint.cc>
References: <20240110194217.484064-1-pablo@netfilter.org>
 <20240110194217.484064-5-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240110194217.484064-5-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>  # nft -f ruleset.nft
>  ruleset.nft:3:28-35: Error: expression is not a concatenation
>                 ip protocol . th dport { tcp / 22,  }
>                                          ^^^^^^^^
> 
> Therefore, a852022d719e ("datatype: do not assert when value exceeds
> expected width") not needed anymore after two previous fixes.

We can't rely on the expression soup coming from nftables.

