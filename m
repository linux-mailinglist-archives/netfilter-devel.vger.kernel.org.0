Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950333BEB1A
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Jul 2021 17:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhGGPmq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Jul 2021 11:42:46 -0400
Received: from mail.netfilter.org ([217.70.188.207]:54960 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231639AbhGGPmq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Jul 2021 11:42:46 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 02E1E61836;
        Wed,  7 Jul 2021 17:39:52 +0200 (CEST)
Date:   Wed, 7 Jul 2021 17:40:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: uapi: refer to nfnetlink_conntrack.h, not
 nf_conntrack_netlink.h
Message-ID: <20210707154002.GA19799@salvia>
References: <20210706224657.GA12859@salvia>
 <20210707005751.12108-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210707005751.12108-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 07, 2021 at 10:57:51AM +1000, Duncan Roe wrote:
> nf_conntrack_netlink.h does not exist, refer to nfnetlink_conntrack.h instead.

Applied to nf, thanks.
