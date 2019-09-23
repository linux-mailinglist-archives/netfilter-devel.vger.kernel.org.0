Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3608CBAFE4
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Sep 2019 10:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbfIWIrp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 Sep 2019 04:47:45 -0400
Received: from a3.inai.de ([88.198.85.195]:42184 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731460AbfIWIro (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:47:44 -0400
Received: by a3.inai.de (Postfix, from userid 25121)
        id E07233B7CE15; Mon, 23 Sep 2019 10:47:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id DCC423B96F87;
        Mon, 23 Sep 2019 10:47:40 +0200 (CEST)
Date:   Mon, 23 Sep 2019 10:47:40 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: Re: [PATCH nftables 1/3] src, include: add upstream linenoise
 source.
In-Reply-To: <20190922070924.uzfjofvga3nufulb@salvia>
Message-ID: <nycvar.YFH.7.76.1909231041310.14433@n3.vanv.qr>
References: <20190921122100.3740-1-jeremy@azazel.net> <20190921122100.3740-2-jeremy@azazel.net> <nycvar.YFH.7.76.1909212114010.6443@n3.vanv.qr> <20190922070924.uzfjofvga3nufulb@salvia>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Sunday 2019-09-22 09:09, Pablo Neira Ayuso wrote:

>> > src/linenoise.c     | 1201 +++++++++++++++++++++++++++++++++++++++++++
>> 
>> That seems like a recipe to end up with stale code. For a distribution,
>> it's static linking worsened by another degree.
>> 
>> (https://fedoraproject.org/wiki/Bundled_Libraries?rd=Packaging:Bundled_Libraries)
>
>I thought this is like mini-gmp.c? Are distributors packaging this as
>a library?

Yes; No.

After an update to a static library, a distro would have to rebuild
dependent packages and then distribute that. Doable, but cumbersome.

But bundled code evades even that. If there is a problem, all instances
of the "static library" would need updating. Doable, but even more cumbersome.

Basically the question is: how is NF going to guarantee that linenoise (or
mini-gmp for that matter) are always up to date?
