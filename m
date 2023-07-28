Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D54C7676A7
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jul 2023 21:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjG1T4R (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jul 2023 15:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjG1T4R (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:56:17 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D1083C07
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Jul 2023 12:56:16 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qPTZO-0004z9-Sq
        for netfilter-devel@vger.kernel.org; Fri, 28 Jul 2023 21:56:14 +0200
Date:   Fri, 28 Jul 2023 21:56:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: nftables: syntax ambiguity with objref map and ct helper objects
Message-ID: <20230728195614.GA18109@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

I wanted to allow creating objref maps that
return "ct timeout" or "ct helper" templates.

However:
  map .. {
    type ipv4_addr : ct timeout

  The above is fine, but this is not:

  map .. {
    type ipv4_addr : ct helper


It caues ambiguity in parser due to existing
"ct helper" expression, as in
"nft describe ct helper", not the freestanding
objref name.

I could just allow:
    type ipv4_addr : helper

... without "ct", but then we'd require different
keywords for the definition and the use as data
element in the key definition, and its inconsistent
with "ct timeout".

Should we add a new explicit keyword for
*both* objref names and the data element usage?

Perhaps:

object type ct helper "sip-external" {
    ....

And
    type ipv4_addr : object type ct helper

?

Any better ideas or suggesions on a sane syntax to avoid this?
