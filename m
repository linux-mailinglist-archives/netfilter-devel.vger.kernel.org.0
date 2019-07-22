Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0BA70004
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 14:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbfGVMrm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 08:47:42 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:53228 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726895AbfGVMrm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 08:47:42 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hpXjA-0002dF-K2; Mon, 22 Jul 2019 14:47:40 +0200
Date:   Mon, 22 Jul 2019 14:47:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, fw@strlen.de
Subject: Re: [PATCH nft] evaluate: missing location for chain nested in table
 definition
Message-ID: <20190722124740.ffu4jmcz3ivukl2w@breakpoint.cc>
References: <20190722115522.31726-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722115522.31726-1-pablo@netfilter.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Pablo Neira Ayuso <pablo@netfilter.org> wrote:
> error reporting may crash because location is unset.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
> ---
> This supersedes your patch 2/3. Regarding 1/3, I think it should be good
> to assume location must be always set, so BUG() is probably a good idea
> from erec_print() if unset.

I can confirm this works, instead of crash one now gets
crash.nft:7:13-16: Error: No such file or directory
      chain test {
            ^^^^
