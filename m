Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237721E02C0
	for <lists+netfilter-devel@lfdr.de>; Sun, 24 May 2020 22:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbgEXUcr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 24 May 2020 16:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388116AbgEXUcr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 24 May 2020 16:32:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB153C061A0E
        for <netfilter-devel@vger.kernel.org>; Sun, 24 May 2020 13:32:46 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1jcxIY-0007UF-Gz; Sun, 24 May 2020 22:32:42 +0200
Date:   Sun, 24 May 2020 22:32:42 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, mkubecek@suse.cz,
        jacobraz@chromium.org, fw@strlen.de
Subject: Re: [PATCH nf 2/2] netfilter: nfnetlink_cthelper: unbreak userspace
 helper support
Message-ID: <20200524203242.GA2915@breakpoint.cc>
References: <20200524195410.28502-1-pablo@netfilter.org>
 <20200524195410.28502-3-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524195410.28502-3-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> Restore helper data size initialization and fix memcopy of the helper
> data size.

Ouch, thanks for fixing this.

Reviewed-by: Florian Westphal <fw@strlen.de>

