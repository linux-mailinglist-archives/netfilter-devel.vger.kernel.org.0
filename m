Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F283E4AC0E0
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Feb 2022 15:18:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235628AbiBGOR1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Feb 2022 09:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379133AbiBGOEU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Feb 2022 09:04:20 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C93AC043181
        for <netfilter-devel@vger.kernel.org>; Mon,  7 Feb 2022 06:04:20 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id F3BF66018C;
        Mon,  7 Feb 2022 15:04:15 +0100 (CET)
Date:   Mon, 7 Feb 2022 15:04:16 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft 1/3] json: add flow statement json export + parser
Message-ID: <YgEm4OBHhQ0L+0bD@salvia>
References: <20220207132816.21129-1-fw@strlen.de>
 <20220207132816.21129-2-fw@strlen.de>
 <20220207132915.GB25000@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220207132915.GB25000@breakpoint.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Feb 07, 2022 at 02:29:15PM +0100, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > flow statement has no export, its shown as:
> > ".. }, "flow add @ft" ] } }"
> > 
> > With this patch:
> > 
> > ".. }, {"flow": {"op": "add", "flowtable": "@ft"}}]}}"
> 
> This is based on the 'set' statement.  If you prefer the @ to
> be removed let me know.

Then, it is consistent with the existing syntax. So either we consider
deprecating the @ on the 'set' statement (while retaining backward
compatibility) or flowtable also includes it as in your patch.
