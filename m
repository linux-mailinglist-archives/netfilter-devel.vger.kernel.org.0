Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758EF4A931E
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Feb 2022 05:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353293AbiBDEmG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Feb 2022 23:42:06 -0500
Received: from mail.netfilter.org ([217.70.188.207]:49020 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBDEmF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Feb 2022 23:42:05 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 9C19E60195;
        Fri,  4 Feb 2022 05:41:59 +0100 (CET)
Date:   Fri, 4 Feb 2022 05:42:02 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jozsef Kadlecsik <kadlec@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 1/2] netfilter: conntrack: move synack init code to
 helper
Message-ID: <YfyumqYq6tioHIfi@salvia>
References: <20220129164701.175221-1-fw@strlen.de>
 <903cfb5c-693c-e085-aa3b-9a3fb4401a51@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <903cfb5c-693c-e085-aa3b-9a3fb4401a51@netfilter.org>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Jan 29, 2022 at 09:18:54PM +0100, Jozsef Kadlecsik wrote:
> On Sat, 29 Jan 2022, Florian Westphal wrote:
> 
> > It seems more readable to use a common helper in the followup fix rather
> > than copypaste or goto.
> > 
> > No functional change intended.  The function is only called for syn-ack
> > or syn in repy direction in case of simultaneous open.
> > 
> > Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
> > Signed-off-by: Florian Westphal <fw@strlen.de>
> 
> Acked-by: Jozsef Kadlecsik <kadlec@netfilter.org>

Applied, thanks
