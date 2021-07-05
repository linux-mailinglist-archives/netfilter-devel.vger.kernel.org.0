Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2133BB99B
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Jul 2021 10:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbhGEIvo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Jul 2021 04:51:44 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47350 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbhGEIvn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:51:43 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 923AE6164E;
        Mon,  5 Jul 2021 10:48:56 +0200 (CEST)
Date:   Mon, 5 Jul 2021 10:49:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Duncan Roe <duncan_roe@optusnet.com.au>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nftables] build: get `make distcheck` to pass again
Message-ID: <20210705084903.GA16821@salvia>
References: <20210704063357.8588-1-duncan_roe@optusnet.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210704063357.8588-1-duncan_roe@optusnet.com.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jul 04, 2021 at 04:33:57PM +1000, Duncan Roe wrote:
> Commit 4694f7230195 introduced nfnetlink_hook.h but didn't update the
> automake system to take account of the new file.

Applied, thanks.
