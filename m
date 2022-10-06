Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 564395F6519
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 13:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231258AbiJFLSQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Oct 2022 07:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbiJFLSP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Oct 2022 07:18:15 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7446C631D1;
        Thu,  6 Oct 2022 04:18:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1ogOtH-0007LY-RJ; Thu, 06 Oct 2022 13:18:11 +0200
Date:   Thu, 6 Oct 2022 13:18:11 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     Florian Westphal <fw@strlen.de>, pablo@netfilter.org,
        Paolo Abeni <pabeni@redhat.com>,
        netfilter-devel@vger.kernel.org,
        netfilter <netfilter@vger.kernel.org>
Subject: Re: Kernel 6.0.0 bug pptp not work
Message-ID: <20221006111811.GA3034@breakpoint.cc>
References: <3D70BC1B-A19E-45E3-B6BC-6B2719BA9B46@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D70BC1B-A19E-45E3-B6BC-6B2719BA9B46@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Martin Zaharinov <micron10@gmail.com> wrote:
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

Did you rely on
sysctl net.netfilter.nf_conntrack_helper=1, or are you assigning the
helper via ruleset?
