Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC5C6E4EC
	for <lists+netfilter-devel@lfdr.de>; Fri, 19 Jul 2019 13:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfGSLRK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 19 Jul 2019 07:17:10 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:37774 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbfGSLRJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 19 Jul 2019 07:17:09 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1hoQsu-0006e1-1m; Fri, 19 Jul 2019 13:17:08 +0200
Date:   Fri, 19 Jul 2019 13:17:08 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: Re: [PATCH nft v2 2/2] rule: removed duplicate member initializer.
Message-ID: <20190719111707.GN1628@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jeremy Sowden <jeremy@azazel.net>,
        Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>
References: <20190719103205.GM1628@orbyte.nwl.cc>
 <20190719111010.14421-1-jeremy@azazel.net>
 <20190719111010.14421-3-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190719111010.14421-3-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 19, 2019 at 12:10:10PM +0100, Jeremy Sowden wrote:
> Initialization of a netlink_ctx included two initializers for .nft.
> Removed one of them.

Oh, good catch! The fact that I stared ad this code ten minutes
ago and didn't see it speaks for itself. :)

> Fixes: 2dc07bcd7eaa ("src: pass struct nft_ctx through struct netlink_ctx")
> Signed-off-by: Jeremy Sowden <jeremy@azazel.net>

Acked-by: Phil Sutter <phil@nwl.cc>
