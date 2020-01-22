Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF9AF145E9E
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jan 2020 23:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVW2K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jan 2020 17:28:10 -0500
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41830 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725911AbgAVW2K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:28:10 -0500
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iuOTo-0002rF-Og; Wed, 22 Jan 2020 23:28:08 +0100
Date:   Wed, 22 Jan 2020 23:28:08 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2] netfilter: nf_tables: autoload modules from the
 abort path
Message-ID: <20200122222808.GR795@breakpoint.cc>
References: <20200122211706.150042-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200122211706.150042-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> +	list_for_each_entry(req, &net->nft.module_list, list) {
> +		if (!strcmp(req->module, module_name) && req->done)
> +			return 0;
> +	}

If the module is already on this list, why does it need to be
added a second time?

Other than that I like this idea as it avoids the entire "drop
transaction mutex while inside a transaction" mess.

