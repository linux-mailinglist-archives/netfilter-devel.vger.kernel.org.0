Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE195113FBD
	for <lists+netfilter-devel@lfdr.de>; Thu,  5 Dec 2019 11:54:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbfLEKyz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 5 Dec 2019 05:54:55 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:60618 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728735AbfLEKyz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 5 Dec 2019 05:54:55 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1icomb-0004GG-IO; Thu, 05 Dec 2019 11:54:53 +0100
Date:   Thu, 5 Dec 2019 11:54:53 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Jan-Philipp Litza <jpl@plutex.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] nftables: Bump dependency on libnftnl to 1.1.5
Message-ID: <20191205105453.GD14469@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Jan-Philipp Litza <jpl@plutex.de>, netfilter-devel@vger.kernel.org
References: <34285bec-d708-d115-dd8c-207aa4a5f718@plutex.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34285bec-d708-d115-dd8c-207aa4a5f718@plutex.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Thu, Dec 05, 2019 at 10:46:34AM +0100, Jan-Philipp Litza wrote:
> The multidevice support was introduced in libnftnl commit e3ac19b5ec162,
> which is first included in version 1.1.5
> 
> With version 1.1.4, compile errors like the following occur:
> 
> netlink.c:423:38: error: 'NFTNL_CHAIN_DEVICES' undeclared (first use in
> this function); did you mean 'NFTNL_CHAIN_DEV'?
> 
> Fixes: 3fdc7541fba07 ("src: add multidevice support for netdev chain")
> Signed-off-by: Jan-Philipp Litza <janphilipp@litza.de>

You were beaten by Pablo by merely 8 minutes or so. :)
Thanks anyway for the patch!

Cheers, Phil
