Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D616BE72D
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfIYVbS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:31:18 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43068 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbfIYVbR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:31:17 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1iDEsV-0007Y2-Js; Wed, 25 Sep 2019 23:31:15 +0200
Date:   Wed, 25 Sep 2019 23:31:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v2 01/24] xtables_error() does not return
Message-ID: <20190925213115.GA12491@breakpoint.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
 <20190925212605.1005-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190925212605.1005-2-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> It's a define which resolves into a callback which in turn is declared
> with noreturn attribute. It will never return, therefore drop all
> explicit exit() calls or other dead code immediately following it.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Acked-by: Florian Westphal <fw@strlen.de>

Feel free to push this already.
