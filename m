Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6F4C6BDCF6
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Mar 2023 00:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCPXg0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Mar 2023 19:36:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCPXg0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:36:26 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B5811E93
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Mar 2023 16:36:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1pcx8t-000304-LN; Fri, 17 Mar 2023 00:36:19 +0100
Date:   Fri, 17 Mar 2023 00:36:19 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 v3 0/2] pcap: prevent crashes when output `FILE *`
 is null
Message-ID: <20230316233619.GA26650@breakpoint.cc>
References: <20230316110754.260967-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230316110754.260967-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> If ulogd2 receives a signal it will attempt to re-open the pcap output
> file.  If this fails (because the permissions or ownership have changed
> for example), the FILE pointer will be null and when the next packet
> comes in, the null pointer will be passed to fwrite and ulogd will
> crash.
> 
> The first patch simplifies the logic of the code that opens the output
> file, and the second avoids closing the existing stream if `fopen`
> fails.
> 
> Link: https://bugs.launchpad.net/ubuntu/+source/ulogd2/+bug/1429778
> 
> Change since v2
> 
>  * The first patch is new.
>  * In the second patch, just keep the old stream open, rather than
>    disabling output and trying to reopen at intervals.

Applied, please double-check the mangling done in patch #1 and send
a followup fix if needed.
