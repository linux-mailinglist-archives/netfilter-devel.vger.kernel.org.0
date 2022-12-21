Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 560B3653420
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Dec 2022 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234467AbiLUQe2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Dec 2022 11:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234528AbiLUQe0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:34:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8975A29A
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Dec 2022 08:34:25 -0800 (PST)
Date:   Wed, 21 Dec 2022 17:34:21 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH nf] netfilter: conntrack: fix ipv6 exthdr error check
Message-ID: <Y6M1jWj/SJsAVj3s@salvia>
References: <202212151110.zPbmpj0L-lkp@intel.com>
 <20221215141633.13253-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221215141633.13253-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 15, 2022 at 03:16:33PM +0100, Florian Westphal wrote:
> smatch warnings:
> net/netfilter/nf_conntrack_proto.c:167 nf_confirm() warn: unsigned 'protoff' is never less than zero.
> 
> We need to check if ipv6_skip_exthdr() returned an error, but protoff is
> unsigned.  Use a signed integer for this.

Applied, thanks
