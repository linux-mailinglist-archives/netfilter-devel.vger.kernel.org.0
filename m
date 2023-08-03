Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D1FF76E8F0
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Aug 2023 14:59:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232809AbjHCM7L (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Aug 2023 08:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbjHCM7K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:59:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCE681BFA
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Aug 2023 05:59:09 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qRXv1-0004UF-Gy; Thu, 03 Aug 2023 14:59:07 +0200
Date:   Thu, 3 Aug 2023 14:59:07 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     "Fernando F. Mancera" <ffmancera@riseup.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] tests: shell: Review test-cases for destroy
 command
Message-ID: <ZMukm92GW0zAwvAc@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        "Fernando F. Mancera" <ffmancera@riseup.net>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20230803105725.5813-1-phil@nwl.cc>
 <87992425-c2c1-9ca9-bf4a-6bac9a005ba7@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87992425-c2c1-9ca9-bf4a-6bac9a005ba7@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 03, 2023 at 02:52:11PM +0200, Fernando F. Mancera wrote:
> Looks good to me, thank you!

Patch applied, thanks for your review!
