Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA864ABFFB
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 14:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiBGNso (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 08:48:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381204AbiBGN3R (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:29:17 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639EFC043181
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 05:29:17 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nH44x-00079g-Tj; Mon, 07 Feb 2022 14:29:15 +0100
Date:   Mon, 7 Feb 2022 14:29:15 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] json: add flow statement json export + parser
Message-ID: <20220207132915.GB25000@breakpoint.cc>
References: <20220207132816.21129-1-fw@strlen.de>
 <20220207132816.21129-2-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220207132816.21129-2-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> flow statement has no export, its shown as:
> ".. }, "flow add @ft" ] } }"
> 
> With this patch:
> 
> ".. }, {"flow": {"op": "add", "flowtable": "@ft"}}]}}"

This is based on the 'set' statement.  If you prefer the @ to
be removed let me know.
