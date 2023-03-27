Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8D16CA249
	for <lists+netfilter-devel@lfdr.de>; Mon, 27 Mar 2023 13:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjC0LXE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Mar 2023 07:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjC0LXE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Mar 2023 07:23:04 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAB1544AD
        for <netfilter-devel@vger.kernel.org>; Mon, 27 Mar 2023 04:23:02 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pgkwG-00047F-BD; Mon, 27 Mar 2023 13:23:00 +0200
Date:   Mon, 27 Mar 2023 13:23:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nftables] exthdr: add boolean DCCP option matching
Message-ID: <20230327112300.GB8780@breakpoint.cc>
References: <20230312143707.158928-1-jeremy@azazel.net>
 <20230312200003.GB26312@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312200003.GB26312@breakpoint.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> Jeremy Sowden <jeremy@azazel.net> wrote:
> > - * @TCPE_DCCP_PKTTYPE:	DCCP packet type (integer subtype)
> > + * @TYPE_DCCP_PKTTYPE:	DCCP packet type (integer subtype)
> 
> Can you isolate this as a spelling fix?
> 
> I'm reluctant to add dccp support because there have been discussions
> wrt. removing dccp from kernel altogether.

Scratch the last sentence, I have no objections wrt. this anymore. I'll
review this patchset later this week.
