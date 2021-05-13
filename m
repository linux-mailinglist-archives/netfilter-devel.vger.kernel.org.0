Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D46383800E7
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 May 2021 01:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbhEMXbu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 May 2021 19:31:50 -0400
Received: from mail.netfilter.org ([217.70.188.207]:34040 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbhEMXbu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 May 2021 19:31:50 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C9E4B6415A;
        Fri, 14 May 2021 01:29:48 +0200 (CEST)
Date:   Fri, 14 May 2021 01:30:36 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Marco Oliverio <marco.oliverio@tanaza.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nftables PATCH] cache: check errno before invoking
 cache_release()
Message-ID: <20210513233036.GA26534@salvia>
References: <20210513141031.213490-1-marco.oliverio@tanaza.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210513141031.213490-1-marco.oliverio@tanaza.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, May 13, 2021 at 04:10:32PM +0200, Marco Oliverio wrote:
> if genid changes during cache_init(), check_genid() sets errno to EINTR to force
> a re-init of the cache.
> 
> cache_release() may inadvertly change errno by calling free().  Indeed free()
> may invoke madvise() that changes errno to ENOSYS on system where kernel is
> configured without support for this syscall.

Applied, thanks.
