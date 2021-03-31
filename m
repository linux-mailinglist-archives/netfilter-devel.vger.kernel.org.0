Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DDC3500E7
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 15:06:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhCaNGE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Mar 2021 09:06:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:47900 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235600AbhCaNFs (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Mar 2021 09:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:Mime-Version:Message-Id:Subject:From
        :Date; bh=NErNNdtPdDk2GYCxJ+c6Y+iZbjWDTzrHZQ+QLz2ILUI=; b=tuyPiXcrGGiCbcURLQ7
        5GYokMEhBJuqWvju6ZrCP+4TnBpDbNgSNTtB7ZavMd06i1xnyVrJKhv447gih7BrfL0DY8duKssPO
        UJtWl/lTKhOj9QH0BNqNkPj3C4ru43UB9wq3IYCKj1tvYVcmZGVvIsK6xfNLUyJK3qbsRRDhIBs=
Received: from [192.168.15.221] (helo=alexm-laptop.lan)
        by relay.sw.ru with smtp (Exim 4.94)
        (envelope-from <alexander.mikhalitsyn@virtuozzo.com>)
        id 1lRaXb-000Cdh-H7; Wed, 31 Mar 2021 16:05:47 +0300
Date:   Wed, 31 Mar 2021 16:05:47 +0300
From:   Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [iptables PATCH v3 2/2] extensions: libxt_conntrack: print
 xlate status as set
Message-Id: <20210331160547.e2c73160420c79554a903be0@virtuozzo.com>
In-Reply-To: <20210331105852.GD17285@breakpoint.cc>
References: <20210331102934.848126-1-alexander.mikhalitsyn@virtuozzo.com>
        <20210331102934.848126-2-alexander.mikhalitsyn@virtuozzo.com>
        <20210331105852.GD17285@breakpoint.cc>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, 31 Mar 2021 12:58:52 +0200
Florian Westphal <fw@strlen.de> wrote:

> Alexander Mikhalitsyn <alexander.mikhalitsyn@virtuozzo.com> wrote:
> > At the moment, status_xlate_print function prints statusmask as comma-separated
> > sequence of enabled statusmask flags. But if we have inverted conntrack ctstatus
> > condition then we have to use more complex expression (if more than one flag enabled)
> > because nft not supports syntax like "ct status != expected,assured".
> > 
> > Examples:
> > ! --ctstatus CONFIRMED,ASSURED
> > should be translated as
> > ct status & (assured|confirmed) == 0
> > 
> > ! --ctstatus CONFIRMED
> > can be translated as
> > ct status != confirmed
> 
> "! --ctstatus CONFIRMED" means 'true if CONFIRMED bit is not set'
> But "ct status != confirmed" means 'true if ct status contains any value
> except confirmed.
> 
> Example: ct->status has confirmed and assured bits set.
> Then:
> "! --ctstatus CONFIRMED" won't match (the bit is set).
> ct status != confirmed returns true (3 != 1)
> ct (status & confirmed) == 0 won't match (the bit is set).
> 

Ah, sure. Fixed ;)

Alex.
