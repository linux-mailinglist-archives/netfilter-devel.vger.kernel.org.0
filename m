Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED2533F4C7F
	for <lists+netfilter-devel@lfdr.de>; Mon, 23 Aug 2021 16:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbhHWOhP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 23 Aug 2021 10:37:15 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33142 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbhHWOhK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 23 Aug 2021 10:37:10 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 11416601C4;
        Mon, 23 Aug 2021 16:35:35 +0200 (CEST)
Date:   Mon, 23 Aug 2021 16:36:24 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Xiao Liang <shaw.leon@gmail.com>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>, phil@nwl.cc
Subject: Re: [PATCH nftables] src: Optimize prefix match only if is big-endian
Message-ID: <20210823143624.GA6501@salvia>
References: <20210820161237.18821-1-shaw.leon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210820161237.18821-1-shaw.leon@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Aug 21, 2021 at 12:12:37AM +0800, Xiao Liang wrote:
> A prefix of integer type is big-endian in nature. Prefix match can be
> optimized to truncated 'cmp' only if it is big-endian.

Applied, thanks.
