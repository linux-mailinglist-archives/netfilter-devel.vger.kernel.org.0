Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 611AF587B55
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Aug 2022 13:07:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236396AbiHBLH1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 2 Aug 2022 07:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbiHBLH1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 2 Aug 2022 07:07:27 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72AF3F33F
        for <netfilter-devel@vger.kernel.org>; Tue,  2 Aug 2022 04:07:25 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1oIpkC-0000nS-3U; Tue, 02 Aug 2022 13:07:24 +0200
Date:   Tue, 2 Aug 2022 13:07:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Nicolas MAFFRE <nicolas.maffre.external@airbus.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: iptables v1.6.2 EOS date
Message-ID: <20220802110724.GG29493@breakpoint.cc>
References: <CAHWqpUO3v0gtUYND=JNHwCU3W2qVaeVujYaKvZudvmmFqMpwpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHWqpUO3v0gtUYND=JNHwCU3W2qVaeVujYaKvZudvmmFqMpwpQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Nicolas MAFFRE <nicolas.maffre.external@airbus.com> wrote:
> I'm working on a project that uses iptables v1.6.2 and I need to know
> if there is an "End of support" date for this version of the software
> iptables ?

We only accept changes on top of the latest version
(https://git.netfilter.org/iptables/).

Of course we still fix bugs reported with older releases provided
the latest version is still affected.
