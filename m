Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39A1F35352B
	for <lists+netfilter-devel@lfdr.de>; Sat,  3 Apr 2021 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236133AbhDCSSB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 3 Apr 2021 14:18:01 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57100 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230516AbhDCSR7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 3 Apr 2021 14:17:59 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0F6D663E3E;
        Sat,  3 Apr 2021 20:17:37 +0200 (CEST)
Date:   Sat, 3 Apr 2021 20:17:51 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, lvs-devel@vger.kernel.org,
        ja@ssi.bg, horms@verge.net.au
Subject: Re: [PATCH nf-next] netfilter: ipvs: do not printk on netns creation
Message-ID: <20210403181751.GA4780@salvia>
References: <20210330064232.11960-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210330064232.11960-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 30, 2021 at 08:42:32AM +0200, Florian Westphal wrote:
> This causes dmesg spew during normal operation, so remove this.

Applied, thanks
