Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4D9A4F44AC
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Apr 2022 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237736AbiDEOJM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Apr 2022 10:09:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382806AbiDEMQ6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:16:58 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6277D3ADC
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 04:28:51 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nbhMg-0004FV-8l; Tue, 05 Apr 2022 13:28:50 +0200
Date:   Tue, 5 Apr 2022 13:28:50 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [nf-next PATCH v2 1/5] netfilter: bitwise: keep track of
 bit-length of expressions
Message-ID: <20220405112850.GE12048@breakpoint.cc>
References: <20220404120417.188410-1-jeremy@azazel.net>
 <20220404120417.188410-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220404120417.188410-2-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> Some bitwise operations are generated in user space when munging paylod
> expressions.  During delinearization, user space attempts to eliminate
> these operations.  However, it does this before deducing the byte-order
> or the correct length in bits of the operands, which means that it
> doesn't always handle multi-byte host-endian operations correctly.
> Therefore, add support for storing the bit-length of the expression,
> even though the kernel doesn't use it, in order to be able to pass it
> back to user space.

Can rule udata be used for this, or is that too much work?
The udata infra is already used to store comments and it would not need
kernel changes.
