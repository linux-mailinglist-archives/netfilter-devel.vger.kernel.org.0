Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E04D4925C7
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jan 2022 13:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbiARMfz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jan 2022 07:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiARMfx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:35:53 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0A6C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Jan 2022 04:35:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1n9niI-0005fj-S2; Tue, 18 Jan 2022 13:35:50 +0100
Date:   Tue, 18 Jan 2022 13:35:50 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Kyle Bowman <kbowman@cloudflare.com>,
        Alex Forster <aforster@cloudflare.com>,
        Cloudflare Kernel Team <kernel-team@cloudflare.com>
Subject: Re: [PATCH iptables v2 2/8] extensions: libxt_NFLOG: use nft
 built-in logging instead of xt_NFLOG
Message-ID: <Yea0JgIGfO/KPlX5@strlen.de>
References: <20211001174142.1267726-1-jeremy@azazel.net>
 <20211001174142.1267726-3-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001174142.1267726-3-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> From: Kyle Bowman <kbowman@cloudflare.com>
> 
> Replaces the use of xt_NFLOG with the nft built-in log statement.
> 
> This additionally adds support for using longer log prefixes of 128
> characters in size. Until now NFLOG has truncated the log-prefix to the
> 64-character limit supported by iptables-legacy. We now use the struct
> xtables_target's udata member to store the longer 128-character prefix
> supported by iptables-nft.

Series applied, thanks for your patience.
