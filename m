Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5104037ABF7
	for <lists+netfilter-devel@lfdr.de>; Tue, 11 May 2021 18:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhEKQdH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 11 May 2021 12:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhEKQdH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 11 May 2021 12:33:07 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A659FC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 11 May 2021 09:32:00 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1lgVIc-0004PH-P9; Tue, 11 May 2021 18:31:58 +0200
Date:   Tue, 11 May 2021 18:31:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables,v3 2/2] src: add set element catch-all support
Message-ID: <20210511163158.GU12403@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20210511152752.123885-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210511152752.123885-1-pablo@netfilter.org>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, May 11, 2021 at 05:27:52PM +0200, Pablo Neira Ayuso wrote:
> Add a catchall expression (EXPR_SET_ELEM_CATCHALL).
> 
> Use the asterisk (*) to represent the catch-all set element, e.g.
> 
>  table x {
>      set y {
> 	type ipv4_addr
> 	counter
> 	elements = { 1.2.3.4 counter packets 0 bytes 0, * counter packets 0 bytes 0 }
>      }
>  }
> 
> Special handling for segtree: zap the catch-all element from the set
> element list and re-add it after processing.
> 
> Remove wildcard_expr deadcode in src/parser_bison.y
> 
> This patch also adds several tests for the tests/py and tests/shell
> infrastructures.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>

Thanks, Phil
