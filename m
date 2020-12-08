Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48052D35FA
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Dec 2020 23:13:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731431AbgLHWKA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Dec 2020 17:10:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731430AbgLHWKA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Dec 2020 17:10:00 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3A49C061282
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Dec 2020 14:09:03 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1kmlAK-0007Vz-LU; Tue, 08 Dec 2020 23:09:00 +0100
Date:   Tue, 8 Dec 2020 23:09:00 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Brett Mastbergen <brett.mastbergen@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_ct: Remove confirmation check for
 NFT_CT_ID
Message-ID: <20201208220900.GD31101@breakpoint.cc>
References: <20201208213924.3106-1-brett.mastbergen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208213924.3106-1-brett.mastbergen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Brett Mastbergen <brett.mastbergen@gmail.com> wrote:
> Since commit 656c8e9cc1ba ("netfilter: conntrack: Use consistent ct id
> hash calculation") the ct id will not change from initialization to
> confirmation.  Removing the confirmation check allows for things like
> adding an element to a 'typeof ct id' set in prerouting upon reception
> of the first packet of a new connection, and then being able to
> reference that set consistently both before and after the connection
> is confirmed.

Acked-by: Florian Westphal <fw@strlen.de>
