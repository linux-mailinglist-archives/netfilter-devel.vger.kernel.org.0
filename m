Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536B074844C
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Jul 2023 14:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbjGEMh3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 08:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbjGEMh2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 08:37:28 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 98C49116
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Jul 2023 05:37:27 -0700 (PDT)
Date:   Wed, 5 Jul 2023 14:37:23 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, faicker.mo@ucloud.cn
Subject: Re: [PATCH nf] netfilter: conntrack: gre: don't set assured flag for
 clash entries
Message-ID: <ZKVkA08uTHPBl1cq@calendula>
References: <20230703114318.20997-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230703114318.20997-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 03, 2023 at 01:43:18PM +0200, Florian Westphal wrote:
> Now that conntrack core is allowd to insert clashing entries, make sure
> GRE won't set assured flag on NAT_CLASH entries, just like UDP.
> 
> Doing so prevents early_drop logic for these entries.

Applied, thanks.
