Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEC973DCB0E
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Aug 2021 12:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbhHAKPK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Aug 2021 06:15:10 -0400
Received: from mail.netfilter.org ([217.70.188.207]:47720 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbhHAKPK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Aug 2021 06:15:10 -0400
Received: from netfilter.org (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id B266B60033;
        Sun,  1 Aug 2021 12:14:27 +0200 (CEST)
Date:   Sun, 1 Aug 2021 12:14:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 1/1] netfilter: ipset: Limit the maximal range of
 consecutive elements to add/delete
Message-ID: <20210801101455.GA20612@salvia>
References: <20210728150115.5107-1-kadlec@netfilter.org>
 <20210728150115.5107-2-kadlec@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210728150115.5107-2-kadlec@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 28, 2021 at 05:01:15PM +0200, Jozsef Kadlecsik wrote:
> The range size of consecutive elements were not limited. Thus one could
> define a huge range which may result soft lockup errors due to the long
> execution time. Now the range size is limited to 2^20 entries.

Applied, thanks.
