Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB07576A400
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Aug 2023 00:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjGaWPR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Jul 2023 18:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjGaWPQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Jul 2023 18:15:16 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7237CB2
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Jul 2023 15:15:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1qQbAX-0008SP-Ng; Tue, 01 Aug 2023 00:15:13 +0200
Date:   Tue, 1 Aug 2023 00:15:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: ulogd2 patch ping
Message-ID: <20230731221513.GA32288@breakpoint.cc>
References: <20230725191128.GE84273@celephais.dreamlands>
 <20230726143533.GB2963@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726143533.GB2963@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> I'll apply it on Friday in case noone objects until then.

Just for completeness: I did not apply it due to the unanswered
question from Pablo.

Also, don't we risk ambiguity here, or is there a guarantee that kernel
never emits mapped addresses?
