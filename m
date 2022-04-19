Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26964506790
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Apr 2022 11:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbiDSJVJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Apr 2022 05:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbiDSJVI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Apr 2022 05:21:08 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A858826AFB
        for <netfilter-devel@vger.kernel.org>; Tue, 19 Apr 2022 02:18:26 -0700 (PDT)
Date:   Tue, 19 Apr 2022 11:18:23 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next v4 00/10] netfilter: conntrack: remove percpu
 lists
Message-ID: <Yl5+X5PAGRONMruH@salvia>
References: <20220411110125.4854-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220411110125.4854-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Apr 11, 2022 at 01:01:15PM +0200, Florian Westphal wrote:
> This series removes the unconfirmed and dying percpu lists.
> 
> Dying list is replaced by pernet list, only used when reliable event
> delivery mode was requested.
> 
> Unconfirmed list is replaced by a generation id for the conntrack
> extesions, to detect when pointers to external objects (timeout policy,
> helper, ...) has gone stale.
> 
> An alternative to the genid would be to always take references on
> such external objects, let me know if that is the preferred solution.

Pushed it out to nf-next, thanks
