Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92C2465B3A5
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Jan 2023 15:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbjABO7o (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Jan 2023 09:59:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235955AbjABO7e (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:59:34 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A301065EE
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Jan 2023 06:59:33 -0800 (PST)
Date:   Mon, 2 Jan 2023 15:59:31 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     mm@skelett.io, ecklm94@gmail.com, akp@cohaesio.com, fw@strlen.de,
        arturo@netfilter.org, phil@nwl.cc, eric@regit.org,
        sbrivio@redhat.com, ffmancera@riseup.net, nevola@gmail.com,
        ssuryaextr@gmail.com
Subject: Re: [PATCH nft] src: Add GPLv2+ header to .c files of recent creation
Message-ID: <Y7LxU+LdVD4H1B2O@salvia>
References: <20221207150815.73934-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221207150815.73934-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 07, 2022 at 04:08:15PM +0100, Pablo Neira Ayuso wrote:
[...]
> I have added the GPLv2+ header to the following files:
> 
>                         Authors
>                         -------
> src/cmd.c               Pablo
> src/fib.c               Florian
> src/hash.c              Pablo
> src/iface.c             Pablo
> src/json.c              Phil + fixes from occasional contributors
> src/libnftables.c       Eric Leblond and Phil
> src/mergesort.c         Elise Lenion
> src/misspell.c          Pablo
> src/mnl.c               Pablo + fixes from occasional contributors
> src/monitor.c           Arturo
> src/numgen.c            Pablo
> src/osf.c               Fernando
> src/owner.c             Pablo
> src/parser_json.c       Phil + fixes from occasional contributors
> src/print.c             Phil
> src/xfrm.c              Florian
> src/xt.c                Pablo

I have applied this patch.
