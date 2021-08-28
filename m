Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE3B13FA4A1
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 11:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbhH1JKa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 05:10:30 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49372 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233446AbhH1JK3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:10:29 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id EFA3560119;
        Sat, 28 Aug 2021 11:08:40 +0200 (CEST)
Date:   Sat, 28 Aug 2021 11:09:34 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue v3 1/6] build: doc: Fix man pages
Message-ID: <20210828090934.GA31560@salvia>
References: <20210828033508.15618-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210828033508.15618-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 28, 2021 at 01:35:03PM +1000, Duncan Roe wrote:
> Split off shell script from within doxygen/Makefile.am into
> doxygen/build_man.sh.
> 
> This patch by itself doesn't fix anything.
> The patch is only for traceability, because diff patch format is not very good
> at catching code updates and moving code together.
> Therefore the script is exactly as it was; it still looks a bit different
> because of having to un-double doubled-up $ signs, remove trailing ";/" and so
> on.

Applied.
