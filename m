Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3E5BE704
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Sep 2022 15:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiITN1c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Sep 2022 09:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiITN1c (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Sep 2022 09:27:32 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452812E6AB
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Sep 2022 06:27:31 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oadHd-0008LQ-B5; Tue, 20 Sep 2022 15:27:29 +0200
Date:   Tue, 20 Sep 2022 15:27:29 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: un-break rule insert with intervals
Message-ID: <20220920132729.GC30575@breakpoint.cc>
References: <20220920125726.5818-1-fw@strlen.de>
 <Yym+A27DQyryYtwE@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yym+A27DQyryYtwE@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> On Tue, Sep 20, 2022 at 02:57:26PM +0200, Florian Westphal wrote:
> > 'rule inet dscpclassify dscp_match  meta l4proto { udp }  th dport { 3478 }  th sport { 3478-3497, 16384-16387 } goto ct_set_ef'
> > works with 'nft add', but not 'nft insert', the latter yields: "BUG: unhandled op 4".
> 
> That's my fault, thanks for the fix.
> 
> Acked-by: Pablo Neira Ayuso <pablo@netfilter.org>
> 
> P.S: Please add a simple test for this regression.

Done.
