Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C578750A4F
	for <lists+netfilter-devel@lfdr.de>; Wed, 12 Jul 2023 16:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232180AbjGLOB3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jul 2023 10:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbjGLOB0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:01:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1E6BC1BE8
        for <netfilter-devel@vger.kernel.org>; Wed, 12 Jul 2023 07:01:08 -0700 (PDT)
Date:   Wed, 12 Jul 2023 16:01:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Igor Raits <igor@gooddata.com>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de, phil@nwl.cc
Subject: Re: [PATCH iptables] nft-bridge: pass context structure to
 ops->add() to improve anonymous set support
Message-ID: <ZK6yICOQBHDwPGHS@calendula>
References: <20230712095912.140792-1-pablo@netfilter.org>
 <CA+9S74i+UOzqjbTK7LBpspYUnQ3xFz__Q2gedA0tO1S7rg5FCw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+9S74i+UOzqjbTK7LBpspYUnQ3xFz__Q2gedA0tO1S7rg5FCw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 12, 2023 at 01:05:10PM +0200, Igor Raits wrote:
> Hi Pablo,
> 
> Thanks for the patch!
> 
> On Wed, Jul 12, 2023 at 11:59 AM Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> >
> > Add context structure to improve bridge among support which creates an
> > anonymous set. This context structure specifies the command and it
> > allows to optionally store a anonymous set.
> >
> > Use this context to generate native bytecode only if this is an
> > add/insert/replace command.
> >
> > This fixes a dangling anonymous set that is created on rule removal.
> >
> > Fixes: 26753888720d ("nft: bridge: Rudimental among extension support")
> > Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> Reported-and-tested-by: Igor Raits <igor@gooddata.com>

I have just pushed it out, thanks.
