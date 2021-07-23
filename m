Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77233D3A21
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jul 2021 14:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234769AbhGWLnJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Jul 2021 07:43:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:56886 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234601AbhGWLnJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Jul 2021 07:43:09 -0400
Received: from netfilter.org (unknown [78.30.39.111])
        by mail.netfilter.org (Postfix) with ESMTPSA id CE95B64119;
        Fri, 23 Jul 2021 14:23:15 +0200 (CEST)
Date:   Fri, 23 Jul 2021 14:23:44 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: conntrack: adjust stop timestamp to real
 expiry value
Message-ID: <20210723122344.GA14579@salvia>
References: <20210718163600.220854-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210718163600.220854-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Jul 18, 2021 at 06:36:00PM +0200, Florian Westphal wrote:
> In case the entry is evicted via garbage collection there is
> delay between the timeout value and the eviction event.
> 
> This adjusts the stop value based on how much time has passed.

Applied, thanks.
