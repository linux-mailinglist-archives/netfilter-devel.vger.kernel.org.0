Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83C65F64BD
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbiJFLBg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Oct 2022 07:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbiJFLBf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:01:35 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AD72613FA3;
        Thu,  6 Oct 2022 04:01:32 -0700 (PDT)
Date:   Thu, 6 Oct 2022 13:01:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org,
        netfilter <netfilter@vger.kernel.org>
Subject: Re: Kernel 6.0.0 bug pptp not work
Message-ID: <Yz61iLY1dud0roEB@salvia>
References: <3D70BC1B-A19E-45E3-B6BC-6B2719BA9B46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3D70BC1B-A19E-45E3-B6BC-6B2719BA9B46@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 06, 2022 at 02:34:48AM +0300, Martin Zaharinov wrote:
> Hi Team
> 
> I make test image with kernel 6.0.0 and schem is :
> 
> internet <> router NAT <> windows client pptp
> 
> with l2tp all is fine and connections is establesh.
> 
> But when try to make pptp connection  stay on finish phase and not connect .
> 
> try to remove module : nf_conntrack_pptp and same not work.
> 
> 
> how to debug and find why not work ?

Can you see events via:

conntrack -E expect

?

With debugfs, you can also enable a few pr_debug() in
nf_conntrack_pptp.c, maybe they provide a hint.

Can you see the GRE flow?

I assume this is without the flowtable?
