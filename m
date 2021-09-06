Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B963E40209E
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 22:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhIFUFi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 16:05:38 -0400
Received: from mail.netfilter.org ([217.70.188.207]:40292 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbhIFUFh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 16:05:37 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id C97756001D;
        Mon,  6 Sep 2021 22:03:25 +0200 (CEST)
Date:   Mon, 6 Sep 2021 22:04:28 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Xiao Liang <shaw.leon@gmail.com>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] src: Check range bounds before converting to prefix
Message-ID: <20210906200428.GA23478@salvia>
References: <20210906030641.10958-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210906030641.10958-1-shaw.leon@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 06, 2021 at 11:06:41AM +0800, Xiao Liang wrote:
> The lower bound must be the first value of the prefix to be coverted.
> For example, range "10.0.0.15-10.0.0.240" can not be converted to
> "10.0.0.15/24". Validate it by checking if the lower bound value has
> enough trailing zeros.

Applied, thanks.
