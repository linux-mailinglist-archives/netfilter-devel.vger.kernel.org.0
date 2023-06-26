Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D841473E307
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jun 2023 17:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbjFZPRo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jun 2023 11:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbjFZPRn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jun 2023 11:17:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC3BE191;
        Mon, 26 Jun 2023 08:17:42 -0700 (PDT)
Date:   Mon, 26 Jun 2023 17:17:40 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] linux/netfilter.h: fix kernel-doc warnings
Message-ID: <ZJmsFCv3CjVmXsWr@calendula>
References: <20230623061101.32513-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230623061101.32513-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 22, 2023 at 11:11:01PM -0700, Randy Dunlap wrote:
> kernel-doc does not support DECLARE_PER_CPU(), so don't mark it with
> kernel-doc notation.
> 
> One comment block is not kernel-doc notation, so just use
> "/*" to begin the comment.
> 
> Quietens these warnings:
> 
> netfilter.h:493: warning: Function parameter or member 'bool' not described in 'DECLARE_PER_CPU'
> netfilter.h:493: warning: Function parameter or member 'nf_skb_duplicated' not described in 'DECLARE_PER_CPU'
> netfilter.h:493: warning: expecting prototype for nf_skb_duplicated(). Prototype was for DECLARE_PER_CPU() instead
> netfilter.h:496: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
>  * Contains bitmask of ctnetlink event subscribers, if any.

Applied to nf.git, thanks
