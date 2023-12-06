Return-Path: <netfilter-devel+bounces-205-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 433A9806F8B
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 13:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECA291F21209
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 12:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37383364A7;
	Wed,  6 Dec 2023 12:18:33 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2249A
	for <netfilter-devel@vger.kernel.org>; Wed,  6 Dec 2023 04:18:30 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1rAqrE-0007pZ-IA; Wed, 06 Dec 2023 13:18:28 +0100
Date: Wed, 6 Dec 2023 13:18:28 +0100
From: Florian Westphal <fw@strlen.de>
To: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Thomas Haller <thaller@redhat.com>, Florian Westphal <fw@strlen.de>,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: shell: flush ruleset with -U after feature
 probing
Message-ID: <20231206121828.GI8352@breakpoint.cc>
References: <20231205154306.154220-1-pablo@netfilter.org>
 <20231205192929.GB8352@breakpoint.cc>
 <80b4cbbb54cf17a83ccbadaa3cd194790f87f67f.camel@redhat.com>
 <ZXBlvcV3jUfJCnMs@calendula>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXBlvcV3jUfJCnMs@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> > The mode without unshare exists for historic reasons, as unshare was
> > added initially. At this point, what is the use of supporting or using
> > that?
> 
> This provides an easy way for me to test 'nft monitor'.
> 
> I can keep it out of tree if you prefer -U remains broken.

No no no, I was just asking if '-U' should still run the
feature probes without a netns, which is what its doing right
now.

Perhaps -U should just disable the unshare for the actual shell
tests, not for the feature probe scripts.

