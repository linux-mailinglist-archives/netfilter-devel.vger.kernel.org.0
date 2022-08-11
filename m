Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E24E958FE78
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Aug 2022 16:41:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234087AbiHKOlu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Aug 2022 10:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbiHKOlt (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Aug 2022 10:41:49 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1EC808E0F6
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Aug 2022 07:41:49 -0700 (PDT)
Date:   Thu, 11 Aug 2022 16:41:43 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, alexanderduyck@fb.com,
        edumazet@google.com
Subject: Re: [PATCH nf 0/4] netfilter: conntrack: remove 64kb max size
 assumptions
Message-ID: <YvUVJwW4QhCVcHik@salvia>
References: <20220809131635.3376-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220809131635.3376-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 09, 2022 at 03:16:31PM +0200, Florian Westphal wrote:
> Some of our dated conntrack helpers assume skbs can't contain
> tcp packets larger than 64kb.
> 
> Update those.  For SANE, I don't see a reason for the
> 'full-packet-copy', just extract the sane header.
> 
> For h323, packet gets capped at 64k; larger one will be
> seen as truncated.
> 
> For irc, cap at 4k: a line length should not exceed 512 bytes.
> For ftp, use skb_linearize(), its the most simple way to resolve this.

Applied, thanks.
