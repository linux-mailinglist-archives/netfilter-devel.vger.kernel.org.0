Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28058552D63
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jun 2022 10:49:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231635AbiFUItF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jun 2022 04:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFUItF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:49:05 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 73A5A26100
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jun 2022 01:49:03 -0700 (PDT)
Date:   Tue, 21 Jun 2022 10:48:57 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 0/2] netfilter: fix two nf_dup bugs with egress hook
Message-ID: <YrGF+bXbFWHVVRkI@salvia>
References: <20220620141731.7362-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220620141731.7362-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jun 20, 2022 at 04:17:29PM +0200, Florian Westphal wrote:
> We need to be more careful now that nf_dup is exposed to new
> egress hook.
> 
> When called from egress hook, we need to skip push of mac header,
> this is only ok for ingress invocation.
> 
> Also add a  recursion counter to prevent re-entry into the expression.

Series applied, thanks
