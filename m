Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CB102851EB
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Oct 2020 20:52:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbgJFSwZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Oct 2020 14:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJFSwZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Oct 2020 14:52:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9F0C061755
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Oct 2020 11:52:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kPs4U-00077S-Jp; Tue, 06 Oct 2020 20:52:22 +0200
Date:   Tue, 6 Oct 2020 20:52:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org,
        Laura Garcia Liebana <nevola@gmail.com>
Subject: Re: [iptables PATCH] extensions: libipt_icmp: Fix translation of
 type 'any'
Message-ID: <20201006185222.GH5213@breakpoint.cc>
References: <20201006171301.6192-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006171301.6192-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> By itself, '-m icmp --icmp-type any' is a noop, it matches any icmp
> types. Yet nft_ipv4_xlate() does not emit an 'ip protocol' match if
> there's an extension with same name present in the rule. Luckily, legacy
> iptables demands icmp match to be prepended by '-p icmp', so we can
> assume this is present and just emit the 'ip protocol' match from icmp
> xlate callback.

Reviewed-by: Florian Westphal <fw@strlen.de>
