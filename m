Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 096F75EE2F0
	for <lists+netfilter-devel@lfdr.de>; Wed, 28 Sep 2022 19:20:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbiI1RUe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 28 Sep 2022 13:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234268AbiI1RUb (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 28 Sep 2022 13:20:31 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFCDB41D1E
        for <netfilter-devel@vger.kernel.org>; Wed, 28 Sep 2022 10:20:29 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1odajT-0002Ff-UA
        for netfilter-devel@vger.kernel.org; Wed, 28 Sep 2022 19:20:27 +0200
Date:   Wed, 28 Sep 2022 19:20:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 5/5] ebtables: Support '-p Length'
Message-ID: <YzSCW00VUZXnZzZn@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20220927221512.7400-1-phil@nwl.cc>
 <20220927221512.7400-6-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927221512.7400-6-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 28, 2022 at 12:15:12AM +0200, Phil Sutter wrote:
> To match on Ethernet frames using the etherproto field as length value,
> ebtables accepts the special protocol name "LENGTH". Implement this in
> ebtables-nft using a native match for 'ether type < 0x0600'.
> 
> Since extension 802_3 matches are valid only with such Ethernet frames,
> add a local add_match() wrapper which complains if the extension is used
> without '-p Length' parameter. Legacy ebtables does this within the
> extension's final_check callback, but it's not possible here due for lack of
> fw->bitmask field access.
> 
> While being at it, add xlate support, adjust tests and make ebtables-nft
> print the case-insensitive argument with capital 'L' like legacy
> ebtables does.

Missed needed adjustment in ebtables/0002-ebtables-save-restore_0 shell
testcase, folded this into the commit.
