Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E2BB352F6F
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Apr 2021 20:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbhDBStB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Apr 2021 14:49:01 -0400
Received: from relay.sw.ru ([185.231.240.75]:51110 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230092AbhDBStA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Apr 2021 14:49:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:Mime-Version:Message-Id:Subject:From
        :Date; bh=S+vkVQo7Q4//VwqbjkJXJSTkVCDS7X3EfPoizMWl5b8=; b=wBFjNVG42gp6MJyhvLs
        owav4b6ILfdG8ZidmjKAxF4zXTuDeEu2YBqTcZWGBEzU88/3mWpbs+8uIjn+zPUvxpXCrEv6fhf8m
        Iz7gyQDy2i959EKI4Eea53k+z5JEXgX8Ntjwv8kMsmeqoST07Lh2bLRasjaVovLBcOCPClXkF2k=
Received: from [192.168.15.193] (helo=alexm-laptop.lan)
        by relay.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1lSOqm-000Gbf-BB; Fri, 02 Apr 2021 21:48:56 +0300
Date:   Fri, 2 Apr 2021 21:48:55 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH v5 2/2] extensions: libxt_conntrack: print
 xlate status as set
Message-Id: <20210402214855.6604a81483eb38aed1611e05@virtuozzo.com>
In-Reply-To: <20210402150835.GK13699@breakpoint.cc>
References: <20210401134708.34288-1-alexander.mikhalitsyn@virtuozzo.com>
        <20210401134708.34288-2-alexander.mikhalitsyn@virtuozzo.com>
        <20210402150835.GK13699@breakpoint.cc>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, 2 Apr 2021 17:08:35 +0200
Florian Westphal <fw@strlen.de> wrote:

> Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
> > At the moment, status_xlate_print function prints statusmask as comma-separated
> > sequence of enabled statusmask flags. But if we have inverted conntrack ctstatus
> > condition then we have to use more complex expression (if more than one flag enabled)
> > because nft not supports syntax like "ct status != expected,assured".
> 
> Also applied.

Thank you for your help and review!

Regards,
Alex
