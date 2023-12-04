Return-Path: <netfilter-devel+bounces-149-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E66E8035D6
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 15:03:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EC391C20AFB
	for <lists+netfilter-devel@lfdr.de>; Mon,  4 Dec 2023 14:03:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC52325761;
	Mon,  4 Dec 2023 14:03:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A981E5
	for <netfilter-devel@vger.kernel.org>; Mon,  4 Dec 2023 06:03:43 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rA9Xx-00005U-1O; Mon, 04 Dec 2023 15:03:41 +0100
Date: Mon, 4 Dec 2023 15:03:41 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: validate family when
 identifying table via handle
Message-ID: <20231204140341.GC29636@breakpoint.cc>
References: <20231204135444.3881-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204135444.3881-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Validate table family when looking up for it via NFTA_TABLE_HANDLE.
> 
> Reported-by: Xingyuan Mo <hdthky0@gmail.com>
> Fixes: 3ecbfd65f50e ("netfilter: nf_tables: allocate handle and delete objects via handle")
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
>  net/netfilter/nf_tables_api.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

This changes behaviour, before this change you can do

nft delete table handle 42

and it will delete the table with handle 42.

After this change, the command will only work if this table happens
to be in 'ip' family.

> -		table = nft_table_lookup_byhandle(net, attr, genmask,
> +		table = nft_table_lookup_byhandle(net, attr, family, genmask,
>  						  NETLINK_CB(skb).portid);

Perhaps leave as-is and:
	if (!IS_ERR(table))
		family = table->family?

(or ctx.family =, but then the strange ctx.family assignment at end
 of function needs to go).

