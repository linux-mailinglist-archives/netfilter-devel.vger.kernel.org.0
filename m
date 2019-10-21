Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBE68DF1F6
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Oct 2019 17:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJUPrQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Oct 2019 11:47:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:51610 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727607AbfJUPrP (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Oct 2019 11:47:15 -0400
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iMZtq-0007O4-06; Mon, 21 Oct 2019 17:47:14 +0200
Date:   Mon, 21 Oct 2019 17:47:13 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] main: misleading error reporting in chain definitions
Message-ID: <20191021154713.GC17858@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191021153835.30123-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191021153835.30123-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Pablo,

On Mon, Oct 21, 2019 at 05:38:35PM +0200, Pablo Neira Ayuso wrote:
>  # nft add chain x y { type filter hook input priority -30\; }
>  nft: invalid option -- '3'
> 
> Fix this by restricting getopt_long() to the first curly brace.

Wouldn't it suffice to set the first char of OPTSTRING to '+'? Exporting
POSIXLY_CORRECT=1 prior to calling the above command works at least.

Cheers, Phil
