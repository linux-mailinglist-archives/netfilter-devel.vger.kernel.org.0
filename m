Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 557C86F07D
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 21:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbfGTTga (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 15:36:30 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48670 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfGTTga (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 15:36:30 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hov9g-0000nz-Ro; Sat, 20 Jul 2019 21:36:28 +0200
Date:   Sat, 20 Jul 2019 21:36:28 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 2/2] nfnl_osf: Silence string truncation gcc warnings
Message-ID: <20190720193628.fysp5cdofer2vi32@breakpoint.cc>
References: <20190720185226.8876-1-phil@nwl.cc>
 <20190720185226.8876-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720185226.8876-2-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Albeit a bit too enthusiastic, gcc is right in that these strings may be
> truncated since the destination buffer is smaller than the source one.
> Get rid of the warnings (and the potential problem) by specifying a
> string "precision" of one character less than the destination. This
> ensures a terminating nul-character may be written as well.

Fernando sent a patch for this already, with the notable difference
of altering the size of the destination buffer by one.

