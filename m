Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58C794F42C0
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Apr 2022 23:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238519AbiDEOJ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Apr 2022 10:09:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358541AbiDEL4h (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 07:56:37 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68B982BB0D
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 04:16:47 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nbhAz-0003zi-Ng; Tue, 05 Apr 2022 13:16:45 +0200
Date:   Tue, 5 Apr 2022 13:16:45 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: meta time broken
Message-ID: <20220405111645.GB12048@breakpoint.cc>
References: <20220405011705.1257ac40@gecko>
 <20220405013128.0bb907e2@gecko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405013128.0bb907e2@gecko>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Lukas Straub <lukasstraub2@web.de> wrote:
> Hmm, after staring at the code for a bit. I could imagine it's due to
> time_t being 32 bit on my platform and nftables trying to stuff a unix
> timstamp with nanosecond resolution in it...

Will you send a patch?
