Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 955BB6B766F
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Mar 2023 12:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbjCMLrB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Mar 2023 07:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbjCMLrA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Mar 2023 07:47:00 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998DAF8
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Mar 2023 04:46:34 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pbgcL-0003cS-Ex; Mon, 13 Mar 2023 12:45:29 +0100
Date:   Mon, 13 Mar 2023 12:45:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf-next v2 0/9] Support for shifted port-ranges in NAT
Message-ID: <20230313114529.GA13787@breakpoint.cc>
References: <20230307233056.2681361-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307233056.2681361-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> Jeremy Sowden (9):
>   netfilter: conntrack: fix typo
>   netfilter: nat: fix indentation of function arguments

These have been applied.

Could you resend a series only consisting of:

>   netfilter: nf_nat_redirect: use `struct nf_nat_range2` in ipv4 API
>   netfilter: nft_masq: deduplicate eval call-backs
>   netfilter: nft_redir: deduplicate eval call-backs

These look ok for nf-next.  This way we won't block
those patches until the "How to" wrt. shifted ranges are
done.
