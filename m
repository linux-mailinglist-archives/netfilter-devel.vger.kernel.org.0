Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14CC3712F20
	for <lists+netfilter-devel@lfdr.de>; Fri, 26 May 2023 23:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjEZVsK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 26 May 2023 17:48:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjEZVsK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 26 May 2023 17:48:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F89BC
        for <netfilter-devel@vger.kernel.org>; Fri, 26 May 2023 14:48:08 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1q2fI6-0001AN-9o; Fri, 26 May 2023 23:48:06 +0200
Date:   Fri, 26 May 2023 23:48:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next,v1 2/6] netfilter: nf_tables: remove fast bitwise
 and cmp operations
Message-ID: <20230526214806.GB2532@breakpoint.cc>
References: <20230525154024.222338-1-pablo@netfilter.org>
 <20230525154024.222338-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525154024.222338-3-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> This patch removes r10fdd6d80e4c ("netfilter: nf_tables: Implement fast
> bitwise expression") and 23f68d462984 ("netfilter: nft_cmp: optimize
> comparison for 16-bytes") which aim to speed up matching on 128-bits and
> <= 32-bits fields with bitwise operations in favour of the new combo
> match approach.

No objections from my side, I see you retained the payload_fast helper
so ip saddr @bla isn't impacted.

Acked-by: Florian Westphal <fw@strlen.de>

