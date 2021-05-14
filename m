Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 809AD3800FB
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 May 2021 01:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230217AbhEMXq2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 May 2021 19:46:28 -0400
Received: from mail.netfilter.org ([217.70.188.207]:34088 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbhEMXq1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 May 2021 19:46:27 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5D8B46415A
        for <netfilter-devel@vger.kernel.org>; Fri, 14 May 2021 01:44:25 +0200 (CEST)
Date:   Fri, 14 May 2021 01:45:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [pablo@netfilter.org: Re: [PATCH net 1/1] netfilter: flowtable:
 Remove redundant hw refresh bit]
Message-ID: <20210513234513.GA31893@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Forwarding this to netfilter-devel, for the record.

This patch is applied to the nf tree.

----- Forwarded message from Pablo Neira Ayuso <pablo@netfilter.org> -----

Date: Fri, 14 May 2021 01:42:07 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Roi Dayan <roid@nvidia.com>
Cc: netdev@vger.kernel.org, Oz Shlomo <ozsh@nvidia.com>, Paul Blakey <paulb@nvidia.com>
Subject: Re: [PATCH net 1/1] netfilter: flowtable: Remove redundant hw refresh bit
User-Agent: Mutt/1.10.1 (2018-07-13)

On Mon, May 10, 2021 at 02:50:24PM +0300, Roi Dayan wrote:
> Offloading conns could fail for multiple reasons and a hw refresh bit is
> set to try to reoffload it in next sw packet.
> But it could be in some cases and future points that the hw refresh bit
> is not set but a refresh could succeed.
> Remove the hw refresh bit and do offload refresh if requested.
> There won't be a new work entry if a work is already pending
> anyway as there is the hw pending bit.

Applied to nf, thanks.

----- End forwarded message -----
