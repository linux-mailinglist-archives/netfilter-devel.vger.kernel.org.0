Return-Path: <netfilter-devel+bounces-221-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A1778070D0
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 14:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A63281CA4
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 13:24:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABD90381AB;
	Wed,  6 Dec 2023 13:24:44 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 624CBD47
	for <netfilter-devel@vger.kernel.org>; Wed,  6 Dec 2023 05:24:41 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rArtH-0008ET-Rq; Wed, 06 Dec 2023 14:24:39 +0100
Date: Wed, 6 Dec 2023 14:24:39 +0100
From: Florian Westphal <fw@strlen.de>
To: Thomas Haller <thaller@redhat.com>
Cc: Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org,
	Maciej =?utf-8?Q?=C5=BBenczykowski?= <zenczykowski@gmail.com>
Subject: Re: [PATCH v2 nft] parser: tcpopt: fix tcp option parsing with NUM +
 length field
Message-ID: <20231206132439.GM8352@breakpoint.cc>
References: <20231205115610.19791-1-fw@strlen.de>
 <fcb3ef457002c89246c24a79290d25498ef7b0b0.camel@redhat.com>
 <20231206113836.GE8352@breakpoint.cc>
 <5aece71107a2716d9e6742cbc4e159c8c65a5ba0.camel@redhat.com>
 <20231206115906.GF8352@breakpoint.cc>
 <20231206120447.GG8352@breakpoint.cc>
 <9d11bf95bd1b07e15cd7160ab310794ea5d4b8b0.camel@redhat.com>
 <20231206121653.GH8352@breakpoint.cc>
 <1f932f8ddf653979454537b5be2739182ba3cab7.camel@redhat.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f932f8ddf653979454537b5be2739182ba3cab7.camel@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Thomas Haller <thaller@redhat.com> wrote:
> > "metainfo": {
> > -        "json_schema_version": 1,
> > +        "version": "VERSION",
> > "release_name": "RELEASE_NAME",
> > -        "version": "VERSION"
> > +        "json_schema_version": 1
> > }
> > },
> > 
> > i.e. it fails validation because the on-record file has a different
> > layout/ordering than what is expected.
> 
> Does this mean all tests on `master` have this problem?

No, those are all raw binary-like oneline dumps.

> > But if you feed it into nft, nft list ruleset will generate the
> > expected
> > (non-json) output.
> 
> where do you encounter that? How to reproduce this?
> 
> Is this an old libjansson? Since 2.8 (2016), JSON_PRESERVE_ORDER is
> implied. Maybe libnftables needs to set JSON_PRESERVE_ORDER flag at a
> few places.

Just format any existing json dump file with a different formatting
tool, e.g. json_pp.

