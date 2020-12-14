Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A51D82D98BC
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Dec 2020 14:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439166AbgLNNZl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Dec 2020 08:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436942AbgLNNZi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Dec 2020 08:25:38 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D3C0613CF
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 05:24:58 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1konqR-0008WC-0P; Mon, 14 Dec 2020 14:24:55 +0100
Date:   Mon, 14 Dec 2020 14:24:54 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH v3 0/9] nft: Sorted chain listing et al.
Message-ID: <20201214132454.GF6484@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20201210130636.26379-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201210130636.26379-1-phil@nwl.cc>
Sender:  <n0-1@orbyte.nwl.cc>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Dec 10, 2020 at 02:06:27PM +0100, Phil Sutter wrote:
[...]
> * Drop getters previously introduced along with struct nft_chain to
>   reduce size of patch 5. Extracting data from embedded nftnl_chain into
>   nft_chain and back if needed is future work.

In addition to a "common" review of my patches, I would like to ask you
to consider patch 5 and the code it adds separately as a direct result
of the premise to not add a sorting function to libnftnl (patch here[1])
in order to keep the library's size small.

A consequent continuation of patch 5 is the implementation of converters
from nftnl_chain to nft_chain and vice versa. While this should reduce
cache size a bit (struct nftnl_chain is pretty big), it adds overhead to
cache fetch and commit operations.

After all, I'm not sure if the direction is feasible given the
code-duplication it caused to manage a list of chains in iptables
instead of using the chain list functionality of libnftnl.

Cheers, Phil

[1] https://lore.kernel.org/netfilter-devel/20200711084505.23825-1-phil@nwl.cc/
