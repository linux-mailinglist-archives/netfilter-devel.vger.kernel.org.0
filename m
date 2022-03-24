Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B03EF4E6643
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Mar 2022 16:45:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348341AbiCXPrJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Mar 2022 11:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiCXPrI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:47:08 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DCCA1447
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Mar 2022 08:45:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nXPeY-0007gj-Nt; Thu, 24 Mar 2022 16:45:34 +0100
Date:   Thu, 24 Mar 2022 16:45:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf-next PATCH] netfilter: nf_log_syslog: Consolidate entry
 checks
Message-ID: <20220324154534.GG24666@breakpoint.cc>
References: <20220324153422.8497-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220324153422.8497-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Every syslog logging callback has to perform the same check to cover for
> rogue containers, introduce a helper for clarity. Drop the FIXME as
> there is a viable solution since commit 2851940ffee31 ("netfilter: allow
> logging from non-init namespaces").

Thanks, this looks good to me.
