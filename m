Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369D353AB9A
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 19:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355636AbiFAROy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 13:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244187AbiFAROy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 13:14:54 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6B11A3094
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 10:14:52 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nwRvl-0006xI-Kc; Wed, 01 Jun 2022 19:14:49 +0200
Date:   Wed, 1 Jun 2022 19:14:49 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Nick <vincent@systemli.org>
Cc:     netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jan Engelhardt <jengelh@inai.de>
Subject: Re: [PATCH] Revert "Simplify static build extension loading"
Message-ID: <YpeeibvCnRYeifhF@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Nick <vincent@systemli.org>,
        netfilter-devel@vger.kernel.org,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jan Engelhardt <jengelh@inai.de>
References: <20220601134743.14415-1-vincent@systemli.org>
 <YpdvYPV5L7Mxs3VQ@orbyte.nwl.cc>
 <1678505c-aa11-6fcf-87b4-eeaa0113af62@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1678505c-aa11-6fcf-87b4-eeaa0113af62@systemli.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 01, 2022 at 04:22:49PM +0200, Nick wrote:
> More Information:
> https://github.com/openwrt/openwrt/pull/9886#issuecomment-1143191713
> 
> I have to debug further.

Well, it looks like firewall3 does a static build and calls
init_extensions*(). It includes xtables.h without defining ALL_INCLUSIVE
or NO_SHARED_LIBS, so ends up with the empty function definitions.

Given that these functions are for internal use only, it is only harmful
to declare them in the "official" libxtables header.

Unless someone objects, I'll prepare a patch moving the declarations
into xshared.h.

Cheers, Phil
