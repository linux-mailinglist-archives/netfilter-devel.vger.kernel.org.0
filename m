Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1235448A7
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jun 2022 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiFIKU6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Jun 2022 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229933AbiFIKU5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Jun 2022 06:20:57 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6EEDD366AB
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Jun 2022 03:20:56 -0700 (PDT)
Date:   Thu, 9 Jun 2022 12:20:52 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Mikhail Sennikovsky <mikhail.sennikovskii@ionos.com>
Cc:     netfilter-devel@vger.kernel.org, mikhail.sennikovsky@gmail.com
Subject: Re: [PATCH 1/1] conntrack: use same modifier socket for bulk ops
Message-ID: <YqHJhO6K15gzqLnV@salvia>
References: <20220602163429.52490-1-mikhail.sennikovskii@ionos.com>
 <20220602163429.52490-2-mikhail.sennikovskii@ionos.com>
 <YqA/RNP5jQzIRpon@salvia>
 <CALHVEJZbcASEfTn4Qc0uAf6PpHLZZb_wHgfmMsjdEkaLSRHyQA@mail.gmail.com>
 <YqCDSFZkF9v+Ki8j@salvia>
 <YqCFrd8SDwnHr+rE@salvia>
 <CALHVEJZ1X+yige_5=daMGfjPcFjQeFmeb2RCDW1=_hSk7eR+wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALHVEJZ1X+yige_5=daMGfjPcFjQeFmeb2RCDW1=_hSk7eR+wA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Wed, Jun 08, 2022 at 04:16:34PM +0200, Mikhail Sennikovsky wrote:
> Hi Pablo,
> 
> Then I misunderstood you, my bad.
> Yes, _check is never used for events, and the socket->events is not
> used anywhere except the assert(events == socket->events); assertion
> check which I found useful as a sanity check for potential future uses
> of the nfct_mnl_socket_check_open.
> If you find it unneeded however, I'm fine with removing it.

If not used now for this usecase, I'd prefer if you remove it.
