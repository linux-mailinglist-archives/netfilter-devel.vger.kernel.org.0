Return-Path: <netfilter-devel+bounces-211-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF289807029
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 13:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 740D01F21304
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 12:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5858E30FA1;
	Wed,  6 Dec 2023 12:47:47 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A25181
	for <netfilter-devel@vger.kernel.org>; Wed,  6 Dec 2023 04:47:43 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rArJV-00080a-I8; Wed, 06 Dec 2023 13:47:41 +0100
Date: Wed, 6 Dec 2023 13:47:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft] evaluate: reject set definition with no key
Message-ID: <20231206124741.GJ8352@breakpoint.cc>
References: <20231206124230.521196-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206124230.521196-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
>  tests/shell/testcases/bogons/nft-f/set_definition_with_no_key_assert
>  BUG: unhandled key type 2
>  nft: src/intervals.c:59: setelem_expr_to_range: Assertion `0' failed.
> 
> This patch adds a new unit tests/shell courtesy of Florian Westphal.
> 
> Fixes: 3975430b12d9 ("src: expand table command before evaluation")
> Reported-by: Florian Westphal <fw@strlen.de>
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Looks saner than what I did, thanks Pablo.

