Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64905705C5
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Jul 2022 16:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiGKOiR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 11 Jul 2022 10:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiGKOiQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:38:16 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1485365D7D
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Jul 2022 07:38:16 -0700 (PDT)
Date:   Mon, 11 Jul 2022 16:38:12 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v2 0/3] netfilter: conntrack sparse annotations
Message-ID: <Ysw11PfeElTzlr7i@salvia>
References: <20220622090047.24586-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622090047.24586-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:00:44AM +0200, Florian Westphal wrote:
> This series reduces the number of generated sparse warnings
> in the netfilter codebase.
> 
> In some cases its just due to a missing '__rcu' annotation
> of the base pointer, but in some other cases there is a
> direct access to a __rcu annotated base pointer.

Series applied, thanks
