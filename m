Return-Path: <netfilter-devel+bounces-261-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802980B398
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Dec 2023 11:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00452281016
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Dec 2023 10:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED35711184;
	Sat,  9 Dec 2023 10:29:36 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9086210DA
	for <netfilter-devel@vger.kernel.org>; Sat,  9 Dec 2023 02:29:33 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rBuaO-0004yD-SD; Sat, 09 Dec 2023 11:29:28 +0100
Date: Sat, 9 Dec 2023 11:29:28 +0100
From: Florian Westphal <fw@strlen.de>
To: Duncan Roe <duncan_roe@optusnet.com.au>
Cc: pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue 1/1] whitespace: replace spaces with
 tab in indent
Message-ID: <20231209102928.GA9216@breakpoint.cc>
References: <20231209023020.5534-1-duncan_roe@optusnet.com.au>
 <20231209023020.5534-2-duncan_roe@optusnet.com.au>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209023020.5534-2-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)

Duncan Roe <duncan_roe@optusnet.com.au> wrote:
> i.e. this one:
> > -^I^I^I          struct nfq_data *nfad, char *name);$
> > +^I^I^I^I  struct nfq_data *nfad, char *name);$

Applied, thanks.

