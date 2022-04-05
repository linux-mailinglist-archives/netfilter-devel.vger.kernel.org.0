Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E8574F3F38
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 Apr 2022 22:57:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237166AbiDEOJj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 Apr 2022 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386845AbiDEM6M (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:58:12 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D515DF956D
        for <netfilter-devel@vger.kernel.org>; Tue,  5 Apr 2022 05:02:39 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nbhtO-0004VZ-BD; Tue, 05 Apr 2022 14:02:38 +0200
Date:   Tue, 5 Apr 2022 14:02:38 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Lukas Straub <lukasstraub2@web.de>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: meta time broken
Message-ID: <20220405120238.GF12048@breakpoint.cc>
References: <20220405011705.1257ac40@gecko>
 <20220405013128.0bb907e2@gecko>
 <20220405111645.GB12048@breakpoint.cc>
 <20220405114115.33c7d5d0@gecko>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405114115.33c7d5d0@gecko>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Lukas Straub <lukasstraub2@web.de> wrote:
> On Tue, 5 Apr 2022 13:16:45 +0200
> Florian Westphal <fw@strlen.de> wrote:
> 
> > Lukas Straub <lukasstraub2@web.de> wrote:
> > > Hmm, after staring at the code for a bit. I could imagine it's due to
> > > time_t being 32 bit on my platform and nftables trying to stuff a unix
> > > timstamp with nanosecond resolution in it...  
> > 
> > Will you send a patch?
> 
> Yes, I already sent one. The mailing list seems to be a bit flacky, did
> you get it?

No, but its in patchwork.  Patch gives following warning:

meta.c:449:56: warning: comparison of integer expressions of different
signedness: 'uint64_t' {aka 'long unsigned int'} and 'int' [-Wsign-compare]
  449 |         if ((tstamp = parse_iso_date(sym->identifier)) != -1)


Would you mind sending a v2?

I'd suggest to change parse_iso_date() to split return value and
converted value, for example:

static time_t parse_iso_date(const char *sym)
->
static bool parse_iso_data(uint64_t *res, const char *sym)

or similar.
