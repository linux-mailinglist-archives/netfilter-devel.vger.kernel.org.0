Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCE451F518
	for <lists+netfilter-devel@lfdr.de>; Wed, 15 May 2019 15:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727187AbfEONLZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 May 2019 09:11:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40044 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725977AbfEONLZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 May 2019 09:11:25 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9585A3003715;
        Wed, 15 May 2019 13:11:24 +0000 (UTC)
Received: from egarver.localdomain (ovpn-123-218.rdu2.redhat.com [10.10.123.218])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A02F60CC0;
        Wed, 15 May 2019 13:11:22 +0000 (UTC)
Date:   Wed, 15 May 2019 09:11:21 -0400
From:   Eric Garver <eric@garver.life>
To:     Shekhar Sharma <shekhar250198@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] tests: py: fix python3.
Message-ID: <20190515131121.pbquqk7pbkfrhrhs@egarver.localdomain>
Mail-Followup-To: Eric Garver <eric@garver.life>,
        Shekhar Sharma <shekhar250198@gmail.com>,
        netfilter-devel@vger.kernel.org
References: <20190515070744.47828-1-shekhar250198@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190515070744.47828-1-shekhar250198@gmail.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 15 May 2019 13:11:24 +0000 (UTC)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Shekhar,

On Wed, May 15, 2019 at 12:37:44PM +0530, Shekhar Sharma wrote:
> This changes all the python2 files to python3.
> Signed-off-by: Shekhar Sharma <shekhar250198@gmail.com>
> ---
>  py/nftables.py              |  2 +-
>  tests/json_echo/run-test.py | 40 ++++++++++++++++++-------------------
>  tests/py/nft-test.py        | 32 ++++++++++++++---------------
>  3 files changed, 37 insertions(+), 37 deletions(-)
> 
> diff --git a/py/nftables.py b/py/nftables.py
> index 33cd2dfd..6503aedd 100644
> --- a/py/nftables.py
> +++ b/py/nftables.py
> @@ -297,7 +297,7 @@ class Nftables:
>          val = self.nft_ctx_output_get_debug(self.__ctx)
>  
>          names = []
> -        for n,v in self.debug_flags.items():
> +        for n,v in linst(self.debug_flags.items()):

typo, should be list()

[..]
