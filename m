Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18F5BF185A
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Nov 2019 15:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfKFOWe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 Nov 2019 09:22:34 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:33706 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbfKFOWe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 Nov 2019 09:22:34 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iSMCe-0002Tv-OA; Wed, 06 Nov 2019 15:22:32 +0100
Date:   Wed, 6 Nov 2019 15:22:32 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] libnftables: Store top_scope in struct nft_ctx
Message-ID: <20191106142232.GS15063@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191106140001.2539-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106140001.2539-1-phil@nwl.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Nov 06, 2019 at 03:00:01PM +0100, Phil Sutter wrote:
> Allow for interactive sessions to make use of defines. Since parser is
> initialized for each line, top scope defines didn't persist although
> they are actually useful for stuff like:
> 
> | # nft -i
> | define goodports = { 22, 23, 80, 443 }
> | add rule inet t c tcp dport $goodports accept
> | add rule inet t c tcp sport $goodports accept
> 
> While being at it, introduce scope_alloc() and scope_free().
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>
> ---
> Changes since v1:
> - Fix usage example in commit message.
> - Add scope_{alloc,free} functions.

Minor correction, this is actually v3 and above are the changes since
v2. /o\

Sorry for the mess,

Phil
