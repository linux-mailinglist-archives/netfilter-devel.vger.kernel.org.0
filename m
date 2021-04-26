Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40C236AA43
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Apr 2021 03:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbhDZBWN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 25 Apr 2021 21:22:13 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49768 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhDZBWN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 25 Apr 2021 21:22:13 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id EFD9F605A8;
        Mon, 26 Apr 2021 03:20:55 +0200 (CEST)
Date:   Mon, 26 Apr 2021 03:21:29 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next] netfilter: nat: move nf_xfrm_me_harder to where
 it is used
Message-ID: <20210426012129.GA30979@salvia>
References: <20210419161649.24120-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210419161649.24120-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 19, 2021 at 06:16:49PM +0200, Florian Westphal wrote:
> remove the export and make it static.

Applied, thanks.
