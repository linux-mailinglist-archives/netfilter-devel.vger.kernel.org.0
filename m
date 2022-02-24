Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81084C2ECE
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Feb 2022 15:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235350AbiBXO7I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Feb 2022 09:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiBXO7I (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:59:08 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A103919D74F
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Feb 2022 06:58:37 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id A4352642F2;
        Thu, 24 Feb 2022 15:57:28 +0100 (CET)
Date:   Thu, 24 Feb 2022 15:58:33 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_queue: don't assume sk is full socket
Message-ID: <YhedGbZ/1HfA498r@salvia>
References: <20220223201004.30615-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220223201004.30615-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Feb 23, 2022 at 09:10:04PM +0100, Florian Westphal wrote:
> There is no guarantee that state->sk refers to a full socket.
> 
> If refcount transitions to 0, sock_put calls sk_free which then ends up
> with garbage fields.
> 
> I'd like to thank Oleksandr Natalenko and Jiri Benc for considerable
> debug work and pointing out state->sk oddities.

Applied, thanks
