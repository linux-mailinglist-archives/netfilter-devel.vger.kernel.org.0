Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53CF6E4521
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Apr 2023 12:24:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjDQKYm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Apr 2023 06:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbjDQKYl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Apr 2023 06:24:41 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 857795FD8
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Apr 2023 03:23:47 -0700 (PDT)
Date:   Mon, 17 Apr 2023 12:22:13 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel <netfilter-devel@vger.kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH nf] netfilter: nf_tables: fix ifdef to also consider
 nf_tables=m
Message-ID: <ZD0d1Y7/tbwipLYp@calendula>
References: <20230417082136.6123-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230417082136.6123-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 17, 2023 at 10:21:36AM +0200, Florian Westphal wrote:
> nftables can be built as a module, so fix the preprocessor conditional
> accordingly.

LGTM, applied to nf.git, thanks.
