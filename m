Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C26D6F080
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 21:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbfGTTnY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 15:43:24 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:48682 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725940AbfGTTnY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 15:43:24 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hovGN-0000q5-0k; Sat, 20 Jul 2019 21:43:23 +0200
Date:   Sat, 20 Jul 2019 21:43:22 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 1/2] parser_bison: Get rid of (most) bison compiler
 warnings
Message-ID: <20190720194322.ehyg7jlzqtugnacw@breakpoint.cc>
References: <20190720185226.8876-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190720185226.8876-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Shut the complaints about POSIX incompatibility by passing -Wno-yacc to
> bison. An alternative would be to not pass -y, but that caused seemingly
> unsolveable problems with automake and expected file names.
> 
> Fix two warnings about deprecated '%pure-parser' and '%error-verbose'
> statements by replacing them with what bison suggests.
> 
> A third warning sadly left in place: Replacing '%name-prefix' by what
> is suggested leads to compilation errors.

Can you add those warnings to the changelog before pushing?

I don't see them, even without this patch.
