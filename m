Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9409B6340B8
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Nov 2022 17:01:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbiKVQBd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Nov 2022 11:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232516AbiKVQBc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Nov 2022 11:01:32 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DCD46B3B4
        for <netfilter-devel@vger.kernel.org>; Tue, 22 Nov 2022 08:01:31 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oxViC-0002q7-Sr; Tue, 22 Nov 2022 17:01:28 +0100
Date:   Tue, 22 Nov 2022 17:01:28 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables-nft RFC 4/5] xlate-test: extra-escape of '"' for
 replay mode
Message-ID: <20221122160128.GA10048@breakpoint.cc>
References: <20221121111932.18222-1-fw@strlen.de>
 <20221121111932.18222-5-fw@strlen.de>
 <Y3zwH69RX+1XjnTM@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3zwH69RX+1XjnTM@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Mon, Nov 21, 2022 at 12:19:31PM +0100, Florian Westphal wrote:
> > Before, nft fails to restore some rules because it sees:
> > insert rule ip filter INPUT iifname iifname ip ...
> > 
> > Add extra escaping for " so that the shell won't remove it and
> > nft will see 'iifname "iifname"'.
> 
> This is fixing up the wrong side, see:

Not sure what you mean here.

The quotes ARE printed, but the shell strips them away.

> struct xt_xlate_{mt,tg}_params::escape_quotes

Ick.

> this is set if iptables-translate was called and unset if
> iptables-restore-translate was called. I didn't invent this, but the
> logic seems to be escape quotes when printing a command, don't when
> printing a dump file content.
> 
> I have a patch in my queue which extends the conditional quoting to
> interface names. Will submit it later today along with other fixes in
> that corner.

I would prefer to rip this out, I don't think any of the tools should
print '\"' instead of '"'.
