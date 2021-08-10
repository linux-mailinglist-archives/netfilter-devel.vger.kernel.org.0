Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAFC3E7D32
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Aug 2021 18:09:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhHJQJe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Aug 2021 12:09:34 -0400
Received: from mail.netfilter.org ([217.70.188.207]:42520 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbhHJQJc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Aug 2021 12:09:32 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 4BD0460030;
        Tue, 10 Aug 2021 18:08:28 +0200 (CEST)
Date:   Tue, 10 Aug 2021 18:09:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v2] src: Stop users from accidentally
 using legacy linux_nfnetlink_queue.h
Message-ID: <20210810160906.GD8978@salvia>
References: <20210806021513.32560-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210806021513.32560-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 06, 2021 at 12:15:13PM +1000, Duncan Roe wrote:
> If a user coded
>   #include <libnetfilter_queue/libnetfilter_queue.h>
>   #include <linux/netfilter/nfnetlink_queue.h>
> then instead of nfnetlink_queue.h they would get linux_nfnetlink_queue.h.
> In the library, this only affects libnetfilter_queue.c

Emit a warning to deprecate linux_nfnetlink_queue.h (which is a copy
of the original nfnetlink_queue.h), users instead should be using
<linux/netfilter/nfnetlink_queue.h>.

To ensure that a project compiles standalone (without the need for the
system kernel header files), you can cache a copy of the header in
your software tree (we use this trick for a while in userspace
netfilter software).

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20210810160813.26984-1-pablo@netfilter.org/
