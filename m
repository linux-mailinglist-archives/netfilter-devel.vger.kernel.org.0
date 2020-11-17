Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED172B5DF7
	for <lists+netfilter-devel@lfdr.de>; Tue, 17 Nov 2020 12:08:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgKQLH3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 17 Nov 2020 06:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgKQLH3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 17 Nov 2020 06:07:29 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F17C0613CF
        for <netfilter-devel@vger.kernel.org>; Tue, 17 Nov 2020 03:07:28 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1keypZ-0004AU-CE; Tue, 17 Nov 2020 12:07:25 +0100
Date:   Tue, 17 Nov 2020 12:07:25 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] ebtables: Fix for broken chain renaming
Message-ID: <20201117110725.GH22792@breakpoint.cc>
References: <20201117105114.5083-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201117105114.5083-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Loading extensions pollutes 'errno' value, hence before using it to
> indicate failure it should be sanitized. This was done by the called
> function before the parsing/netlink split and not migrated by accident.
> Move it into calling code to clarify the connection.
> 
> Fixes: a7f1e208cdf9c ("nft: split parsing from netlink commands")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Heh.  Thanks for adding a test -- LGTM, feel free to push this.
