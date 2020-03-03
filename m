Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3E81769C4
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Mar 2020 02:02:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgCCBCy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 20:02:54 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54038 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgCCBCy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:02:54 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1j8vxU-0005vP-4I; Tue, 03 Mar 2020 02:02:52 +0100
Date:   Tue, 3 Mar 2020 02:02:52 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/4] nft: cache: Fix nft_release_cache() under
 stress
Message-ID: <20200303010252.GB5627@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20200302175358.27796-1-phil@nwl.cc>
 <20200302175358.27796-2-phil@nwl.cc>
 <20200302191930.5evt74vfrqd7zura@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200302191930.5evt74vfrqd7zura@salvia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Mar 02, 2020 at 08:19:30PM +0100, Pablo Neira Ayuso wrote:
> On Mon, Mar 02, 2020 at 06:53:55PM +0100, Phil Sutter wrote:
> > iptables-nft-restore calls nft_action(h, NFT_COMPAT_COMMIT) for each
> > COMMIT line in input. When restoring a dump containing multiple large
> > tables, chances are nft_rebuild_cache() has to run multiple times.
> 
> Then, fix nft_rebuild_cache() please.

This is not the right place to fix the problem: nft_rebuild_cache()
simply rebuilds the cache, switching to a secondary instance if not done
so before to avoid freeing objects referenced from batch jobs.

When creating batch jobs (e.g., adding a rule or chain), code is not
aware of which cache instance is currently in use. It will just add
those objects to nft_handle->cache pointer.

It is the job of nft_release_cache() to return things back to normal
after each COMMIT line, which includes restoring nft_handle->cache
pointer to point at first cache instance.

If you see a flaw in my reasoning, I'm all ears. Also, if you see a
better solution, please elaborate - IMO, nft_release_cache() should undo
what nft_rebuild_cache() may have done. From nft_action() perspective,
they are related.

Cheers, Phil
