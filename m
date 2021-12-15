Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4098476680
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Dec 2021 00:27:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbhLOX1X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Dec 2021 18:27:23 -0500
Received: from mail.netfilter.org ([217.70.188.207]:56518 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbhLOX1X (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Dec 2021 18:27:23 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 102C360022;
        Thu, 16 Dec 2021 00:24:53 +0100 (CET)
Date:   Thu, 16 Dec 2021 00:27:18 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_queue] build: doc: Warn user if html docs
 will be missing diagrams
Message-ID: <Ybp51ify8OtcAESi@salvia>
References: <20211201003938.4220-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211201003938.4220-1-duncan_roe@optusnet.com.au>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 01, 2021 at 11:39:38AM +1100, Duncan Roe wrote:
> libnetfilter_queue is unique among the netfilter libraries in having a
> module hierarchy.
> If 'dot' is available, Doxygen will make an interactive diagram for a module
> with a child or a parent, allowing users to conveniently move up and down the
> hierarchy.
> Update configure to output a warning if 'dot' is not installed and html was
> requested.

Applied, thanks
