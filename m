Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD0B572294
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Jul 2019 00:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731934AbfGWWrV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jul 2019 18:47:21 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:33396 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731702AbfGWWrV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jul 2019 18:47:21 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hq3Z0-0005NI-IF; Wed, 24 Jul 2019 00:47:19 +0200
Date:   Wed, 24 Jul 2019 00:47:18 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Florian Westphal <fw@strlen.de>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: nf_tables: Make nft_meta expression more
 robust
Message-ID: <20190723224718.dggb4vzaqwbaublg@breakpoint.cc>
References: <20190723132753.13781-1-phil@nwl.cc>
 <20190723184321.of7uo36tymvhccwx@salvia>
 <20190723223306.ahfi5o5roumncm2u@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190723223306.ahfi5o5roumncm2u@breakpoint.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Florian Westphal <fw@strlen.de> wrote:
> If we change things now (set ifindex 0 / "" name), I do not think
> we can't revert it later.

Grrr, should not reply at this hour.  I meant
"I do not think we can revert it later" -- if we change it now
it will be set in stone.
