Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8717346CE
	for <lists+netfilter-devel@lfdr.de>; Sun, 18 Jun 2023 17:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjFRPVm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 18 Jun 2023 11:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjFRPVm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 18 Jun 2023 11:21:42 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5A29FB4;
        Sun, 18 Jun 2023 08:21:41 -0700 (PDT)
Date:   Sun, 18 Jun 2023 17:21:38 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     nft.ogxzcrqhuhgchbvxcs4j7wws@qmail.sunbirdgrove.com,
        netfilter@vger.kernel.org,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: nft list sets changed behavior
Message-ID: <ZI8hArHRm2ke+Awz@calendula>
References: <60e59333-3d37-5b66-e0ed-8e7d4c01d956@qmail.sunbirdgrove.com>
 <20230618122216.3bdd0e34776293adb0655516@plushkava.net>
 <962b1e4f-63e2-bc3b-bf27-5569c6402c0f@qmail.sunbirdgrove.com>
 <20230618133509.GA869@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230618133509.GA869@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jun 18, 2023 at 03:35:09PM +0200, Florian Westphal wrote:
> moving to nf-devel
> 
> nft.ogxzcrqhuhgchbvxcs4j7wws@qmail.sunbirdgrove.com <nft.ogxzcrqhuhgchbvxcs4j7wws@qmail.sunbirdgrove.com> wrote:
[...]
> > > > After updating to Debian 12 my tools relying on 'nft -j list sets' fail.
> > > > It now does not include the elements in those lists like it did on 11.
> 
> I see three possible solutions:
> 1 - accept the breakage.
> 2 - repair the inconsistency so we get 1.0.0 and
>     earlier behaviour back.
> 3 - make "list sets" *always* include set elements,
>     unless --terse was given.
> 
> Thoughts? I'd go with 3, I dislike the
> different behaviour that 2) implies and we already
> have --terse, we just need to make use of it here.

I'd go with 3 too, so --terse is honored.
