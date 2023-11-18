Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 212EB7F02E0
	for <lists+netfilter-devel@lfdr.de>; Sat, 18 Nov 2023 21:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229776AbjKRUZg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 18 Nov 2023 15:25:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229662AbjKRUZf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 18 Nov 2023 15:25:35 -0500
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBFBF196
        for <netfilter-devel@vger.kernel.org>; Sat, 18 Nov 2023 12:25:30 -0800 (PST)
Received: from [78.30.43.141] (port=53318 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1r4Rsd-00Bf4J-1D
        for netfilter-devel@vger.kernel.org; Sat, 18 Nov 2023 21:25:29 +0100
Date:   Sat, 18 Nov 2023 21:25:25 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Netfilter Development <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_queue v3 1/1] src: Add nfq_nlmsg_put2() -
 user specifies header flags
Message-ID: <ZVkdn0wPWdUwgP4U@calendula>
References: <ZVSkE1fzi68CN+uo@calendula>
 <20231115113011.6620-1-duncan_roe@optusnet.com.au>
 <ZVSuTwfVBEsCcthA@calendula>
 <ZVg5jArFjdXUuzPN@slk15.local.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZVg5jArFjdXUuzPN@slk15.local.net>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 18, 2023 at 03:11:56PM +1100, Duncan Roe wrote:
> Hi Pablo,
> 
> Can we please sort out just what you want before I send nfq_nlmsg_put2 v4?
> 
> And, where applicable, would you like the same changes made to nfq_nlmsg_put?

Just send a v4 with the changes I request for this patch, then once
applied, you can follow up to update nfq_nlmsg_put() in a separated
patch to amend that description too.

So, please, only one patch series at a time.

> On Wed, Nov 15, 2023 at 12:41:03PM +0100, Pablo Neira Ayuso wrote:
[...]
> > > + * attempt to configure NFQA_CFG_F_SECCTX on a system not runnine SELinux.
> > > + * \n
> > > + * NLM_F_ACK instructs the kernel to send a message in response
> > > + * to a successful command.
> >
> > As I said above, this is not accurate.
> > > + * The kernel always sends a message in response to a failed command.
>
> I dispute that my description was inaccurate, but admit it could be clearer,
> maybe if I change the order and elaborate a bit.
> propose
>
> > > + * The kernel always sends a message in response to a failed command.
> > > + * NLM_F_ACK instructs the kernel to also send a message in response
> > > + * to a successful command.

LGTM, however:

> > > + * This ensures a following read() will not block.

Remove this sentence, because the blocking behaviour you observe is
because !NLM_F_ACK and no failure means no message is sent, and if
your application is there to recv(), it will wait forever because
kernel will send nothing.
