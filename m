Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 332BC412ABB
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Sep 2021 03:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236231AbhIUB5Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Sep 2021 21:57:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39654 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237212AbhIUBww (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Sep 2021 21:52:52 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 081FF63EB2;
        Tue, 21 Sep 2021 03:50:06 +0200 (CEST)
Date:   Tue, 21 Sep 2021 03:51:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, youling 257 <youling257@gmail.com>
Subject: Re: [PATCH nf] netfilter: iptable_raw: drop bogus net_init annotation
Message-ID: <YUk6mXvdw0Vww/XT@salvia>
References: <20210917095625.1338-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210917095625.1338-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Sep 17, 2021 at 11:56:25AM +0200, Florian Westphal wrote:
> This is a leftover from the times when this function was wired up via
> pernet_operations.  Now its called when userspace asks for the table.
> 
> With CONFIG_NET_NS=n, iptable_raw_table_init memory has been discarded
> already and we get a kernel crash.
> 
> Other tables are fine, __net_init annotation was removed already.

Applied, thanks.
