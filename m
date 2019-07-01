Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6DB551012
	for <lists+netfilter-devel@lfdr.de>; Mon, 24 Jun 2019 17:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbfFXPOt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 24 Jun 2019 11:14:49 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:54962 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbfFXPOt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 24 Jun 2019 11:14:49 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hfQgA-0002Jz-O0; Mon, 24 Jun 2019 17:14:46 +0200
Date:   Mon, 24 Jun 2019 17:14:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Phil Sutter <phil@nwl.cc>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] files: Move netdev-ingress.nft to /etc/nftables as
 well
Message-ID: <20190624151446.2umdf4bzem4h7yqj@breakpoint.cc>
References: <20190624151238.4869-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624151238.4869-1-phil@nwl.cc>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter <phil@nwl.cc> wrote:
> Commit 13535a3b40b62 ("files: restore base table skeletons") moved
> config skeletons back from examples/ to /etc/nftables/ directory, but
> ignored the fact that commit 6c9230e79339c ("nftables: rearrange files
> and examples") added a new file 'netdev-ingress.nft' which is referenced
> from 'all-in-one.nft' as well.

Right.  Do you think we should also add in inet-nat.nft example,
or even replace the ipvX- ones?
