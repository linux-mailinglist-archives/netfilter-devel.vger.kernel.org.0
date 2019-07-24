Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22F0D7415F
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 00:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbfGXW0T (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Jul 2019 18:26:19 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51970 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728027AbfGXW0T (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Jul 2019 18:26:19 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hqPi8-0003Jc-2l; Thu, 25 Jul 2019 00:26:12 +0200
Date:   Thu, 25 Jul 2019 00:26:12 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the netfilter
 tree
Message-ID: <20190724222612.GD14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        NetFilter <netfilter-devel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20190725071803.6beb44f9@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725071803.6beb44f9@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Jul 25, 2019 at 07:18:03AM +1000, Stephen Rothwell wrote:
> Commit
> 
>   5f5ff5ca2e18 ("netfilter: nf_tables: Make nft_meta expression more robust")
> 
> is missing a Signed-off-by from its author.

Argh, my SoB ended in the changelog I put below the commit message and
hence was dropped during git-am. Thanks for the heads-up, Stephen!

Pablo, can we fix this somehow?

Sorry for the mess, Phil
