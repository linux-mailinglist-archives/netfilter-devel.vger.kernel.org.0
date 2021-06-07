Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8095A39DC0E
	for <lists+netfilter-devel@lfdr.de>; Mon,  7 Jun 2021 14:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbhFGMSF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Jun 2021 08:18:05 -0400
Received: from mail.netfilter.org ([217.70.188.207]:53478 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230288AbhFGMSE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Jun 2021 08:18:04 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C2F0964182;
        Mon,  7 Jun 2021 14:15:00 +0200 (CEST)
Date:   Mon, 7 Jun 2021 14:16:09 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Oz Shlomo <ozsh@nvidia.com>
Cc:     Paul Blakey <paulb@nvidia.com>, netfilter-devel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH nf-next 0/3] Control nf flow table timeouts
Message-ID: <20210607121609.GA7908@salvia>
References: <20210603121235.13804-1-ozsh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210603121235.13804-1-ozsh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 03, 2021 at 03:12:32PM +0300, Oz Shlomo wrote:
> TCP and UDP connections may be offloaded from nf conntrack to nf flow table.
> Offloaded connections are aged after 30 seconds of inactivity. 
> Once aged, ownership is returned to conntrack with a hard coded tcp/udp
> pickup time of 120/30 seconds, after which the connection may be deleted. 
> 
> The current hard-coded pickup intervals may introduce a very aggressive
> aging policy. For example, offloaded tcp connections in established state
> will timeout from nf conntrack after just 150 seconds of inactivity, 
> instead of 5 days. In addition, the hard-coded 30 second offload timeout
> period can significantly increase the hardware insertion rate requirements
> in some use cases.
> 
> This patchset provides the user with the ability to configure protocol
> specific offload timeout and pickup intervals via sysctl.
> The first and second patches introduce the sysctl configuration for
> tcp and udp protocols. The last patch modifies nf flow table aging
> mechanisms to use the configured time intervals.

Series applied, thanks.
