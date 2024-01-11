Return-Path: <netfilter-devel+bounces-606-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 168EA82AF52
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 14:16:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BB5F285A70
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 13:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E715E98;
	Thu, 11 Jan 2024 13:16:55 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92E215E96
	for <netfilter-devel@vger.kernel.org>; Thu, 11 Jan 2024 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rNuvT-0007yt-PN; Thu, 11 Jan 2024 14:16:51 +0100
Date: Thu, 11 Jan 2024 14:16:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: disable ct set with ranges
Message-ID: <20240111131651.GD28014@breakpoint.cc>
References: <20240111124649.27222-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111124649.27222-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)

Florian Westphal <fw@strlen.de> wrote:
> ... this will cause an assertion in netlink linearization, catch this
> at eval stage instead.
> 
> before:
> BUG: unknown expression type range
> nft: netlink_linearize.c:908: netlink_gen_expr: Assertion `0' failed.
> 
> after:
> /unknown_expr_type_range_assert:3:31-40: Error: ct expression cannot be a range
> ct mark set 0x001-3434
>             ^^^^^^^^^^

This isn't enough, we have a truckload of bugs like this.

e.g. 'tproxy to  1.1.1.10/0'.  This passes EXPR_RANGE check,
but we still hit the assertion because prefix is translated to a range
later on.

dup and fwd also have this issue, probably a lot more.

