Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5118105331
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 14:35:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfKUNf4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 08:35:56 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:41232 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbfKUNf4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 08:35:56 -0500
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.91)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1iXmck-0003Po-8b; Thu, 21 Nov 2019 14:35:54 +0100
Date:   Thu, 21 Nov 2019 14:35:54 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Michal Rostecki <mrostecki@opensuse.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] mnl: Fix -Wimplicit-function-declaration warnings
Message-ID: <20191121133554.GA3074@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Michal Rostecki <mrostecki@opensuse.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org
References: <20191121123332.5245-1-mrostecki@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191121123332.5245-1-mrostecki@opensuse.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 21, 2019 at 01:33:32PM +0100, Michal Rostecki wrote:
> This change fixes the following warnings:
> 
> mnl.c: In function ‘mnl_nft_flowtable_add’:
> mnl.c:1442:14: warning: implicit declaration of function ‘calloc’ [-Wimplicit-function-declaration]
>   dev_array = calloc(len, sizeof(char *));
>               ^~~~~~
> mnl.c:1442:14: warning: incompatible implicit declaration of built-in function ‘calloc’
> mnl.c:1442:14: note: include ‘<stdlib.h>’ or provide a declaration of ‘calloc’
> mnl.c:1449:2: warning: implicit declaration of function ‘free’ [-Wimplicit-function-declaration]
>   free(dev_array);
>   ^~~~
> mnl.c:1449:2: warning: incompatible implicit declaration of built-in function ‘free’
> mnl.c:1449:2: note: include ‘<stdlib.h>’ or provide a declaration of ‘free’
> 
> Signed-off-by: Michal Rostecki <mrostecki@opensuse.org>

Fixes: 1698fca7d49ff ("mnl: remove artifical cap on 8 devices per flowtable")
Acked-by: Phil Sutter <phil@nwl.cc>
