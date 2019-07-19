Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989FF6E4ED
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbfGSLR2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 07:17:28 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37782 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSLR2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:17:28 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hoQtC-0006em-K2; Fri, 19 Jul 2019 13:17:26 +0200
Date:   Fri, 19 Jul 2019 13:17:26 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nft v2 1/2] libnftables: got rid of repeated
 initialization of netlink_ctx variable in loop.
Message-ID: <20190719111726.GO1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20190719103205.GM1628@orbyte.nwl.cc>
 <20190719111010.14421-1-jeremy@azazel.net>
 <20190719111010.14421-2-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719111010.14421-2-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:10:09PM +0100, Jeremy Sowden wrote:
> Most members in the context doesn't change, so there is no need to
> memset it and reassign them on every iteration.  Moved that code out of
> the loop.
> 
> Fixes: a72315d2bad4 ("src: add rule batching support")
> Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Acked-by: Phil Sutter <phil@nwl.cc>
