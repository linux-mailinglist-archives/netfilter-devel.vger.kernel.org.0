Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51071408259
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Sep 2021 01:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236675AbhILXkT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 12 Sep 2021 19:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhILXkS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 12 Sep 2021 19:40:18 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A580C061574
        for <netfilter-devel@vger.kernel.org>; Sun, 12 Sep 2021 16:39:04 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1mPZ3s-00049t-Ip; Mon, 13 Sep 2021 01:39:00 +0200
Date:   Mon, 13 Sep 2021 01:39:00 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf] netfilter: ip6_tables: zero-initialize fragment offset
Message-ID: <20210912233900.GN23554@breakpoint.cc>
References: <20210912212433.45389-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210912212433.45389-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> ip6tables only sets the `IP6T_F_PROTO` flag on a rule if a protocol is
> specified (`-p tcp`, for example).  However, if the flag is not set,
> `ip6_packet_match` doesn't call `ipv6_find_hdr` for the skb, in which
> case the fragment offset is left uninitialized and a garbage value is
> passed to each matcher.

Fixes: f7108a20dee44 ("netfilter: xtables: move extension arguments into compound structure (1/6)"
Reviewed-by: Florian Westphal <fw@strlen.de>
