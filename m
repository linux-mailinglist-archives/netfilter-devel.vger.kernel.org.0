Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472B555EA72
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Jun 2022 19:03:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiF1RDA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 28 Jun 2022 13:03:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiF1RCd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 28 Jun 2022 13:02:33 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3014119292
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Jun 2022 10:02:33 -0700 (PDT)
Date:   Tue, 28 Jun 2022 19:02:30 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_dynset: restore set element counter
 when failing to update
Message-ID: <Yrs0JistID/VWqzZ@salvia>
References: <20220622093219.194566-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220622093219.194566-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 22, 2022 at 11:32:19AM +0200, Pablo Neira Ayuso wrote:
> This patch fixes a race condition.
> 
> nft_rhash_update() might fail for two reasons:
> 
> - Element already exists in the hashtable.
> - Another packet won race to insert an entry in the hashtable.
> 
> In both cases, new() has already bumped the counter via atomic_add_unless().
> Decrement the set element counter in this case.

For the record: I'll place this in nf.git.
