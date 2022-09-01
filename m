Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B82E5A8999
	for <lists+netfilter-devel@lfdr.de>; Thu,  1 Sep 2022 01:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbiHaXwE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Aug 2022 19:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiHaXwD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:52:03 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D2A1F14F0
        for <netfilter-devel@vger.kernel.org>; Wed, 31 Aug 2022 16:52:02 -0700 (PDT)
Date:   Thu, 1 Sep 2022 01:51:58 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     David Leadbeater <dgl@dgl.cx>
Cc:     Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: [PATCH 2/2] netfilter: nf_conntrack_irc: Fix forged IP logic
Message-ID: <Yw/0HiFXz+YIigrV@salvia>
References: <20220826045658.100360-1-dgl@dgl.cx>
 <20220826045658.100360-2-dgl@dgl.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220826045658.100360-2-dgl@dgl.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 26, 2022 at 02:56:58PM +1000, David Leadbeater wrote:
> Ensure the match happens in the right direction, previously the
> destination used was the server, not the NAT host, as the comment
> shows the code intended.
> 
> Additionally nf_nat_irc uses port 0 as a signal and there's no valid way
> it can appear in a DCC message, so consider port 0 also forged.

Applied, thanks
