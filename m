Return-Path: <netfilter-devel+bounces-315-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C9381186B
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 16:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AC61F21157
	for <lists+netfilter-devel@lfdr.de>; Wed, 13 Dec 2023 15:54:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B2985368;
	Wed, 13 Dec 2023 15:54:45 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC38B9
	for <netfilter-devel@vger.kernel.org>; Wed, 13 Dec 2023 07:54:40 -0800 (PST)
Received: from [78.30.43.141] (port=39692 helo=gnumonks.org)
	by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <pablo@gnumonks.org>)
	id 1rDRZD-004WfM-MN; Wed, 13 Dec 2023 16:54:37 +0100
Date: Wed, 13 Dec 2023 16:54:34 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Phil Sutter <phil@nwl.cc>, Eric Garver <eric@garver.life>,
	netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH] netfilter: nf_tables: Support updating table's
 owner flag
Message-ID: <ZXnTutEACvJPIEJx@calendula>
References: <20231208130103.26931-1-phil@nwl.cc>
 <ZXhbYs4vQMWX/q+d@calendula>
 <ZXiI58QCVek1rWiF@orbyte.nwl.cc>
 <ZXji-iRbse7yiGte@egarver-mac>
 <ZXmgAu3u2w+Xjh8+@orbyte.nwl.cc>
 <ZXnKpoMQnsoTK6sA@calendula>
 <ZXnS5k/iOj3g5f22@orbyte.nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZXnS5k/iOj3g5f22@orbyte.nwl.cc>
X-Spam-Score: -1.9 (-)

On Wed, Dec 13, 2023 at 04:51:02PM +0100, Phil Sutter wrote:
> On Wed, Dec 13, 2023 at 04:15:50PM +0100, Pablo Neira Ayuso wrote:
[...]
> I find it sensible to protect a table only as long as the owning process
> remains alive, at least to prevent zombie tables. This raises the
> question what shall happen to orphan tables upon 'nft flush ruleset'?
> Flush them like a regular one?

I think so, otherwise such orphaned table will become an inmortal
zombie that noone can remove :)

[...]
> > I think this 'persist' flag provides semantics the described above,
> > that is:
> > 
> > - keep it in place if process goes away.
> > - allow to retake ownership.
> 
> I'll give it a try.

Thanks.

