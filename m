Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CB9734F4AF
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Mar 2021 00:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhC3W4l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 18:56:41 -0400
Received: from mail.netfilter.org ([217.70.188.207]:46542 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233133AbhC3W4f (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 18:56:35 -0400
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 796E063E55;
        Wed, 31 Mar 2021 00:56:18 +0200 (CEST)
Date:   Wed, 31 Mar 2021 00:56:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     Wan Jiabing <wanjiabing@vivo.com>, Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, kael_w@yeah.net
Subject: Re: [PATCH] netfilter: ipset: Remove duplicate declaration
Message-ID: <20210330225630.GA14620@salvia>
References: <20210327025454.917202-1-wanjiabing@vivo.com>
 <508fa09b-b2a2-b88f-35b1-d6d3d2a24254@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <508fa09b-b2a2-b88f-35b1-d6d3d2a24254@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Mar 28, 2021 at 09:30:49PM +0200, Jozsef Kadlecsik wrote:
> On Sat, 27 Mar 2021, Wan Jiabing wrote:
> 
> > struct ip_set is declared twice. One is declared at 79th line,
> > so remove the duplicate.
> 
> Yes, it's a duplicate. Pablo, could you apply it?

Applied, thanks Jozsef.
