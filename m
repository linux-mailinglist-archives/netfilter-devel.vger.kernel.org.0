Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEF94FA6A0
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 Apr 2022 11:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiDIKAM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 Apr 2022 06:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232630AbiDIKAK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:00:10 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72186C0E
        for <netfilter-devel@vger.kernel.org>; Sat,  9 Apr 2022 02:58:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nd7r0-0007Ra-S5; Sat, 09 Apr 2022 11:58:02 +0200
Date:   Sat, 9 Apr 2022 11:58:02 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Florian Westphal <fw@strlen.de>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [nf-next PATCH v2 1/5] netfilter: bitwise: keep track of
 bit-length of expressions
Message-ID: <20220409095802.GC19371@breakpoint.cc>
References: <20220404120417.188410-1-jeremy@azazel.net>
 <20220404120417.188410-2-jeremy@azazel.net>
 <20220408232703.GG7920@breakpoint.cc>
 <YlFUBZg+983PofgH@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlFUBZg+983PofgH@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> Good point.  I imagine I copied and pasted the types from `len`, which
> also has `NLA_U32` and `u8`.  It, however, is parsed correctly:
> 
>   err = nft_parse_u32_check(tb[NFTA_BITWISE_LEN], U8_MAX, &len);
>   if (err < 0)
>     return err;
> 
> Since `len` is `u8`, `nbits` will need to be `u16`.  My inclination is
> to leave the netlink type as NLA_U32 and parse it as follows:
> 
>   err = nft_parse_u32_check(tb[NFTA_BITWISE_NBITS], U8_MAX * BITS_PER_BYTE,
>                             &nbits);
>   if (err < 0)
>     return err;

Yes, thats fine as well.
