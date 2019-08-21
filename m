Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E260D97FF0
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 18:23:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfHUQXn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 12:23:43 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:41388 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726857AbfHUQXn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 12:23:43 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1i0TOf-0005RW-Dx; Wed, 21 Aug 2019 18:23:41 +0200
Date:   Wed, 21 Aug 2019 18:23:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Ander Juaristi <a@juaristi.eus>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v8 2/2] meta: Introduce new conditions 'time', 'day'
 and 'hour'
Message-ID: <20190821162341.GB20113@breakpoint.cc>
References: <20190821151802.6849-1-a@juaristi.eus>
 <20190821151802.6849-2-a@juaristi.eus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821151802.6849-2-a@juaristi.eus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Ander Juaristi <a@juaristi.eus> wrote:
> These keywords introduce new checks for a timestamp, an absolute date (which is converted to a timestamp),
> an hour in the day (which is converted to the number of seconds since midnight) and a day of week.
> 
> When converting an ISO date (eg. 2019-06-06 17:00) to a timestamp,
> we need to substract it the GMT difference in seconds, that is, the value
> of the 'tm_gmtoff' field in the tm structure. This is because the kernel
> doesn't know about time zones. And hence the kernel manages different timestamps
> than those that are advertised in userspace when running, for instance, date +%s.
> 
> The same conversion needs to be done when converting hours (e.g 17:00) to seconds since midnight
> as well.
> 
> The result needs to be computed modulo 86400 in case GMT offset (difference in seconds from UTC)
> is negative.
> 
> We also introduce a new command line option (-t, --seconds) to show the actual
> timestamps when printing the values, rather than the ISO dates, or the hour.

Pablo, please see this "-t" option -- should be just re-use -n instead?

Other than this, this patch looks good and all tests pass for me.
