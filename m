Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 986604259A1
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Oct 2021 19:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242884AbhJGRkQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 7 Oct 2021 13:40:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60098 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242882AbhJGRkJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 7 Oct 2021 13:40:09 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 87E1F6005C;
        Thu,  7 Oct 2021 19:36:37 +0200 (CEST)
Date:   Thu, 7 Oct 2021 19:38:04 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Juhee Kang <claudiajkang@gmail.com>
Cc:     kadlec@netfilter.org, fw@strlen.de,
        netfilter-devel@vger.kernel.org, manojbm@codeaurora.org
Subject: Re: [PATCH nf v2] netfilter: xt_IDLETIMER: fix panic that occurs
 when timer_type has garbage value
Message-ID: <YV8wfOlVcvJz71Y2@salvia>
References: <20211004121438.1839-1-claudiajkang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211004121438.1839-1-claudiajkang@gmail.com>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 04, 2021 at 09:14:38PM +0900, Juhee Kang wrote:
> Currently, when the rule related to IDLETIMER is added, idletimer_tg timer 
> structure is initialized by kmalloc on executing idletimer_tg_create 
> function. However, in this process timer->timer_type is not defined to 
> a specific value. Thus, timer->timer_type has garbage value and it occurs 
> kernel panic. So, this commit fixes the panic by initializing 
> timer->timer_type using kzalloc instead of kmalloc.

Applied, thanks.
