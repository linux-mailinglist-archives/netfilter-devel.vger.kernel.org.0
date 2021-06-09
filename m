Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352E03A1DC5
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Jun 2021 21:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbhFIThQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Jun 2021 15:37:16 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60090 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhFIThQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Jun 2021 15:37:16 -0400
Received: from netfilter.org (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 667836422C;
        Wed,  9 Jun 2021 21:34:07 +0200 (CEST)
Date:   Wed, 9 Jun 2021 21:35:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH nf-next] netfilter: move nf_tables base hook annotation
 to init helper
Message-ID: <20210609193517.GA4711@salvia>
References: <20210608210607.13325-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210608210607.13325-1-fw@strlen.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:06:07PM +0200, Florian Westphal wrote:
> coverity scanner says:
> 2187  if (nft_is_base_chain(chain)) {
> vvv   CID 1505166:  Memory - corruptions  (UNINIT)
> vvv   Using uninitialized value "basechain".
> 2188  basechain->ops.hook_ops_type = NF_HOOK_OP_NF_TABLES;
> 
> ... I don't see how nft_is_base_chain() can evaluate to true
> while basechain pointer is garbage.
> 
> However, it seems better to place the NF_HOOK_OP_NF_TABLES annotation
> in nft_basechain_hook_init() instead.

Applied, thanks.
