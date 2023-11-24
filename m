Return-Path: <netfilter-devel+bounces-19-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B42DA7F70B7
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Nov 2023 11:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E62231C20988
	for <lists+netfilter-devel@lfdr.de>; Fri, 24 Nov 2023 10:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C021773B;
	Fri, 24 Nov 2023 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E042F1AB
	for <netfilter-devel@vger.kernel.org>; Fri, 24 Nov 2023 02:02:57 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <n0-1@orbyte.nwl.cc>)
	id 1r6T1S-0001IQ-Lf; Fri, 24 Nov 2023 11:02:54 +0100
Date: Fri, 24 Nov 2023 11:02:54 +0100
From: Phil Sutter <phil@nwl.cc>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [nft PATCH] tests/shell: Treat json-nft dumps as binary in git
Message-ID: <ZWB0zqIFbTw4oHCO@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Thomas Haller <thaller@redhat.com>
References: <20231123143712.17341-1-phil@nwl.cc>
 <20231124084951.GA8873@breakpoint.cc>
 <ZWBt/seCFvaAdvcO@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWBt/seCFvaAdvcO@calendula>

On Fri, Nov 24, 2023 at 10:33:50AM +0100, Pablo Neira Ayuso wrote:
> On Fri, Nov 24, 2023 at 09:49:51AM +0100, Florian Westphal wrote:
> > Phil Sutter <phil@nwl.cc> wrote:
> > > The stored JSON dumps containing a single line of a thusand characters
> > > in average mess up diffs in history and patches if they change. Mitigate
> > > this by treating them as binary files.
> > > 
> > > In order to get useable diffs back, one may undo/override the attribute
> > > within $GIT_DIR/info/attributes, preferrably by defining a custom diff
> > > driver converting the single-line dumps into something digestable by
> > > diff:
> > 
> > I'd say we convert the single-line dumps to jq format one-by-one
> > if they need updating.

This might work without a transitioning mechanism if jq output piped
through jq does not change. The testsuite could just pipe the dump
through jq before comparing regardless of whether it's pretty-printed
already or not.

> I am also fine with .json-nft dumps in pretty format too, which is
> friendlier to git diff.

Discuss that with Thomas, please. I tried and failed, alleviating the
effects is my last resort.

Cheers, Phil

