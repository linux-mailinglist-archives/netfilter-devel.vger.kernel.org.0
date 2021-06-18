Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B6F3AD4B8
	for <lists+netfilter-devel@lfdr.de>; Sat, 19 Jun 2021 00:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhFRWDM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 18 Jun 2021 18:03:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:51274 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbhFRWDM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 18 Jun 2021 18:03:12 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C274064133;
        Fri, 18 Jun 2021 23:59:40 +0200 (CEST)
Date:   Sat, 19 Jun 2021 00:00:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Oz Shlomo <ozsh@nvidia.com>
Cc:     Paul Blakey <paulb@nvidia.com>, netfilter-devel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>
Subject: Re: [PATCH nf-next] docs: networking: Update connection tracking
 offload sysctl parameters
Message-ID: <20210618220059.GA13185@salvia>
References: <20210617065006.5893-1-ozsh@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210617065006.5893-1-ozsh@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 17, 2021 at 09:50:06AM +0300, Oz Shlomo wrote:
> Document the following connection offload configuration parameters:
> - nf_flowtable_tcp_timeout
> - nf_flowtable_tcp_pickup
> - nf_flowtable_udp_timeout
> - nf_flowtable_udp_pickup

Applied, thanks.
