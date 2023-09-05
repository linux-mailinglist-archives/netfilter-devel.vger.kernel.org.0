Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8F979296C
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Sep 2023 18:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351962AbjIEQ0a (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Sep 2023 12:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354761AbjIEOJZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Sep 2023 10:09:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6821197
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Sep 2023 07:09:21 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qdWk4-0007X2-KL; Tue, 05 Sep 2023 16:09:20 +0200
Date:   Tue, 5 Sep 2023 16:09:20 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/5] tests: add feature probing
Message-ID: <20230905140920.GC28401@breakpoint.cc>
References: <20230904090640.3015-1-fw@strlen.de>
 <20230904090640.3015-2-fw@strlen.de>
 <ZPcmZ4nqfG43SuM9@orbyte.nwl.cc>
 <20230905134406.GA28401@breakpoint.cc>
 <ZPc0z92PA6ZNXzM5@orbyte.nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZPc0z92PA6ZNXzM5@orbyte.nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Sure, because that's a short-cut for '[ -n false ]'. In what context is
> that problematic?

if [ $HAVE_NFT_foo ] ; then ...
