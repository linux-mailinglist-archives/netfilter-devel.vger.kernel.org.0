Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A04BA2A2181
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Nov 2020 21:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgKAUVn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Nov 2020 15:21:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgKAUVn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Nov 2020 15:21:43 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDFE4C0617A6
        for <netfilter-devel@vger.kernel.org>; Sun,  1 Nov 2020 12:21:42 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kZJr7-0005ZR-00; Sun, 01 Nov 2020 21:21:37 +0100
Date:   Sun, 1 Nov 2020 21:21:36 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH] doc: correct chain name in example of adding a rule.
Message-ID: <20201101202136.GD15770@breakpoint.cc>
References: <20201101193313.10879-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201101193313.10879-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jeremy Sowden <jeremy@azazel.net> wrote:
> The example adds a rule to the `output` chain, not the `input` chain.

Applied, thanks.
