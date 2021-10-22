Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE05C437684
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Oct 2021 14:10:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbhJVMMW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 22 Oct 2021 08:12:22 -0400
Received: from mail.netfilter.org ([217.70.188.207]:36718 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhJVMMV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 22 Oct 2021 08:12:21 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8B6D663F37;
        Fri, 22 Oct 2021 14:08:19 +0200 (CEST)
Date:   Fri, 22 Oct 2021 14:09:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nfnetlink_queue: fix OOB when mac header
 was cleared
Message-ID: <YXKqF1BUqLztB0hH@salvia>
References: <20211020160810.10226-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211020160810.10226-1-fw@strlen.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 20, 2021 at 06:08:10PM +0200, Florian Westphal wrote:
> On 64bit platforms the MAC header is set to 0xffff on allocation and
> also when a helper like skb_unset_mac_header() is called.

Applied
