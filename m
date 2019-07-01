Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46AED13485
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 May 2019 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726244AbfECUwm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 May 2019 16:52:42 -0400
Received: from Chamillionaire.breakpoint.cc ([146.0.238.67]:52914 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726022AbfECUwl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 May 2019 16:52:41 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@strlen.de>)
        id 1hMfAd-000608-5X; Fri, 03 May 2019 22:52:39 +0200
Date:   Fri, 3 May 2019 22:52:39 +0200
From:   Florian Westphal <fw@strlen.de>
To:     Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>
Cc:     fw@strlen.de, pablo@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf v2] netfilter: nf_conntrack_h323: Remove deprecated
 config check
Message-ID: <20190503205239.6buya377z7qwx5ov@breakpoint.cc>
References: <1556908748-22202-1-git-send-email-subashab@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556908748-22202-1-git-send-email-subashab@codeaurora.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Subash Abhinov Kasiviswanathan <subashab@codeaurora.org> wrote:
> CONFIG_NF_CONNTRACK_IPV6 has been deprecated so replace it with
> a check for IPV6 instead.
> 
> v1->v2: Use nf_ip6_route6() instead of v6ops->route() and keep
> the IS_MODULE() in nf_ipv6_ops as mentioned by Florian so that
> direct calls are used when IPV6 is builtin and indirect calls
> are used only when IPV6 is a module.
> 
> Fixes: a0ae2562c6c4b2 ("netfilter: conntrack: remove l3proto abstraction")
> Signed-off-by: Subash Abhinov Kasiviswanathan <subashab@codeaurora.org>

Reviewed-by: Florian Westphal <fw@strlen.de>
