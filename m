Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D54E97B5994
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Oct 2023 20:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbjJBSGt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Oct 2023 14:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjJBSGr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Oct 2023 14:06:47 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A397CAD
        for <netfilter-devel@vger.kernel.org>; Mon,  2 Oct 2023 11:06:44 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qnNJa-0002Ot-IY; Mon, 02 Oct 2023 20:06:42 +0200
Date:   Mon, 2 Oct 2023 20:06:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: do not refresh timeout when
 resetting element
Message-ID: <ZRsGslT23xzSsbgd@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20231002090516.3200649-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002090516.3200649-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 02, 2023 at 11:05:16AM +0200, Pablo Neira Ayuso wrote:
> The dump and reset command should not refresh the timeout, this command
> is intended to allow users to list existing stateful objects and reset
> them, element expiration should be refresh via transaction instead with
> a specific command to achieve this, otherwise this is entering combo
> semantics that will be hard to be undone later (eg. a user asking to
> retrieve counters but _not_ requiring to refresh expiration).

From a users' perspective, what is special about the element expires
value disqualifying it from being reset along with any counter/quota
values?

Do you have a PoC for set element reset via transaction yet? Can we
integrate non-timeout resets with it, too? Because IIUC, that's an
alternative to the pending reset locking.

What we have now is a broad 'reset element', not specifying what to
reset. If the above is a feature being asked for, I'd rather implement
'reset element counter', 'reset element timeout', 'reset element quota',
etc. commands.

Cheers, Phil
