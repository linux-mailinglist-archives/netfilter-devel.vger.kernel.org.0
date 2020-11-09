Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5982AC779
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Nov 2020 22:42:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729599AbgKIVmy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 9 Nov 2020 16:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729247AbgKIVmy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 9 Nov 2020 16:42:54 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E260BC0613CF
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Nov 2020 13:42:53 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kcEw8-0006MC-Hc; Mon, 09 Nov 2020 22:42:52 +0100
Date:   Mon, 9 Nov 2020 22:42:52 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Florian Westphal <fw@strlen.de>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] tests: py: remove duplicate payloads.
Message-ID: <20201109214252.GF23619@breakpoint.cc>
References: <20201109180710.161500-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201109180710.161500-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> nft-test.py only needs one payload per rule, but a number of rules have
> duplicates, typically one per address family, so just keep the last
> payload for rules listed more than once.
> 
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Right, nft-test.py shows no changes with those removed, applied, thanks!
