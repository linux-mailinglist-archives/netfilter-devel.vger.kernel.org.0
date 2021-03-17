Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEA0A33FBF5
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 00:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQXlw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 19:41:52 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49752 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCQXlX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 19:41:23 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7B6B762BB1;
        Thu, 18 Mar 2021 00:41:19 +0100 (CET)
Date:   Thu, 18 Mar 2021 00:41:20 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Simon Horman <simon.horman@netronome.com>
Cc:     netfilter-devel@vger.kernel.org, oss-drivers@netronome.com,
        Yinjun Zhang <yinjun.zhang@corigine.com>,
        Louis Peens <louis.peens@corigine.com>
Subject: Re: [PATCH nf] netfilter: flowtable: Make sure GC works periodically
 in idle system
Message-ID: <20210317234120.GA14924@salvia>
References: <20210317124224.16665-1-simon.horman@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317124224.16665-1-simon.horman@netronome.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 17, 2021 at 01:42:24PM +0100, Simon Horman wrote:
> From: Yinjun Zhang <yinjun.zhang@corigine.com>
> 
> Currently flowtable's GC work is initialized as deferrable, which
> means GC cannot work on time when system is idle. So the hardware
> offloaded flow may be deleted for timeout, since its used time is
> not timely updated.
> 
> Resolve it by initializing the GC work as delayed work instead of
> deferrable.

Applied, thanks.
