Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C96A6477B1
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 22:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiLHVHi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 16:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiLHVHh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:07:37 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FD859582
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 13:07:37 -0800 (PST)
Date:   Thu, 8 Dec 2022 22:07:33 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 2/4] filter: fix buffer sizes in filter plug-ins
Message-ID: <Y5JSFbQVlHUbMMM/@salvia>
References: <20221203190212.346490-1-jeremy@azazel.net>
 <20221203190212.346490-3-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221203190212.346490-3-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Dec 03, 2022 at 07:02:10PM +0000, Jeremy Sowden wrote:
[...]
> The arrays are indexed by subtracting `START_KEY` from the enum value of
> the key currently being processed: `hwmac_str[okey - START_KEY]`.
> However, this means that the last key (`KEY_MAC_ADDR` in this example)
> will run off the end of the array.  Increase the size of the arrays.

BTW, did you detect this via valgrind or such? If so, posting an
extract of the splat in the commit message is good to have.

Just a side note for your follow up patches, this batch is already on
git.netfilter.org

Thanks.
