Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD622C9545
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Oct 2019 01:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbfJBX4r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Oct 2019 19:56:47 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:40762 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728213AbfJBX4r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Oct 2019 19:56:47 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id C574C362765
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Oct 2019 09:56:34 +1000 (AEST)
Received: (qmail 15228 invoked by uid 501); 2 Oct 2019 23:56:34 -0000
Date:   Thu, 3 Oct 2019 09:56:34 +1000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Fix a missing doxygen section trailer in nlmsg.c
Message-ID: <20191002235634.GA8689@dimstar.local.net>
Mail-Followup-To: netfilter-devel@vger.kernel.org
References: <20191002064848.30620-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191002064848.30620-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=XobE76Q3jBoA:10
        a=bCYmSCWeFzNWC_Z3gRgA:9 a=CjuIK1q_8ugA:10
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 02, 2019 at 04:48:48PM +1000, Duncan Roe wrote:
> This corrects an oddity in the web doco (and presumably in the man pages as
> well) whereby "Netlink message batch helpers" was showing up as a sub-topic of
> "Netlink message helpers".
>
> This was included in my original (rejected) patch "Enable doxygen to generate
> Function Documentation" with a comment "(didn't think it warrantied an extra
> patch)" - clearly wrong
> ---
>  src/nlmsg.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/src/nlmsg.c b/src/nlmsg.c
> index fb99135..d398e63 100644
> --- a/src/nlmsg.c
> +++ b/src/nlmsg.c
> @@ -370,6 +370,10 @@ EXPORT_SYMBOL void mnl_nlmsg_fprintf(FILE *fd, const void *data, size_t datalen,
>  	}
>  }
>
> +/**
> + * @}
> + */
> +
>  /**
>   * \defgroup batch Netlink message batch helpers
>   *
> --
> 2.14.5
>
Sorry, should have mentioned: this patch is for libmnl

Cheers ... Duncan.
