Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B215B22E3
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Sep 2022 17:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231467AbiIHP4N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Sep 2022 11:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231318AbiIHP4K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:56:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE04B0895
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Sep 2022 08:56:07 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oWJsr-0005vt-KV; Thu, 08 Sep 2022 17:56:05 +0200
Date:   Thu, 8 Sep 2022 17:56:05 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH iptables-nft 0/3] nft: prefer meta pkttype to
 libxt_pkttype
Message-ID: <20220908155605.GA16543@breakpoint.cc>
References: <20220908151242.26838-1-fw@strlen.de>
 <YxoMJxDrzmh0nQRM@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxoMJxDrzmh0nQRM@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> On Thu, Sep 08, 2022 at 05:12:39PM +0200, Florian Westphal wrote:
> > low hanging fruit: use native meta+cmp instead of libxt_pkttype.
> > First patch adds dissection, second patch switches to native expression.
> > 
> > Last patch adds support for 'otherhost' mnemonic, useless for iptables
> > but useful for ebtables.
> 
> Reviewed-by: Phil Sutter <phil@nwl.cc>

Thanks for the quick review, applied.
