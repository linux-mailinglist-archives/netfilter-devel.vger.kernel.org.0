Return-Path: <netfilter-devel+bounces-8-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8397F6120
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 15:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E25AB2138A
	for <lists+netfilter-devel@lfdr.de>; Thu, 23 Nov 2023 14:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E802FC23;
	Thu, 23 Nov 2023 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B7E3D40;
	Thu, 23 Nov 2023 06:10:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1r6APr-0005Nx-Ab; Thu, 23 Nov 2023 15:10:51 +0100
Date: Thu, 23 Nov 2023 15:10:51 +0100
From: Florian Westphal <fw@strlen.de>
To: Simon Horman <horms@kernel.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	lorenzo@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH nf-next 1/8] netfilter: flowtable: move nf_flowtable out
 of container structures
Message-ID: <20231123141051.GA13062@breakpoint.cc>
References: <20231121122800.13521-1-fw@strlen.de>
 <20231121122800.13521-2-fw@strlen.de>
 <20231123135213.GE6339@kernel.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123135213.GE6339@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)

Simon Horman <horms@kernel.org> wrote:
> > -	err = nf_flow_table_init(&ct_ft->nf_ft);
> > +	ct_ft->nf_ft = kzalloc(sizeof(*ct_ft->nf_ft), GFP_KERNEL);
> > +	if (!ct_ft->nf_ft)
> > +		goto err_alloc;
> 
> Hi Florian,
> 
> This branch will cause the function to return err, but err is 0 here.
> Perhaps it should be set to a negative error value instead?

Yes, this should fail with -ENOMEM.

