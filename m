Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEBA6F4910
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 May 2023 19:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjEBRTs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 May 2023 13:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjEBRTp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 May 2023 13:19:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20B79AB
        for <netfilter-devel@vger.kernel.org>; Tue,  2 May 2023 10:19:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pttfC-00063F-KH; Tue, 02 May 2023 19:19:42 +0200
Date:   Tue, 2 May 2023 19:19:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>,
        netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] doc: add nat examples
Message-ID: <20230502171942.GB22029@breakpoint.cc>
References: <20230501101009.386454-1-fw@strlen.de>
 <ZFDBbQ+u85XkfWMx@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFDBbQ+u85XkfWMx@calendula>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Mon, May 01, 2023 at 12:10:09PM +0200, Florian Westphal wrote:
> > nftables nat is much more capable than what the existing
> > documentation describes.
> > 
> > In particular, nftables can fully emulate iptables
> > NETMAP target and can perform n:m address mapping.
> > 
> > Add a new example section extracted from commit log
> > messages when those features got added.
> 
> LGTM, thanks for documenting this, I should have done this myself.

No problem, I've pushed this with your suggested change.
