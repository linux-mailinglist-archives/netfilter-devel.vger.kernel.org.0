Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2B6A55C22E
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 14:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234096AbiF0KXV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Jun 2022 06:23:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbiF0KXV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:23:21 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5517F5FB0
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Jun 2022 03:23:19 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1o5ltk-0006Bb-Ln; Mon, 27 Jun 2022 12:23:16 +0200
Date:   Mon, 27 Jun 2022 12:23:16 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 0/3] parser: fix scope closing with > 1 nested scope
Message-ID: <20220627102316.GA23400@breakpoint.cc>
References: <20220624092555.1572-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624092555.1572-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> This resolves the parsing problem reported by Phil.
> First patch is his test case, second patch is an
> (unrelated) fix for SYNPROXY scoping (lack of close).
> 
> Last patch fixes closing with nested scopes, where we exited
> a scope too early.
> 
> Florian Westphal (2):
>   parser: add missing synproxy scope closure
>   scanner: don't pop active flex scanner scope
>
> Phil Sutter (1):
>   tests/py: Add a test for failing ipsec after counter

Pushed to nftables.git
