Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0513C63AD84
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Nov 2022 17:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiK1QU0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Nov 2022 11:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232317AbiK1QU0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Nov 2022 11:20:26 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1AA6810566
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Nov 2022 08:20:24 -0800 (PST)
Date:   Mon, 28 Nov 2022 17:20:20 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] nft_set_pipapo: Actually validate intervals in fields
 after the first one
Message-ID: <Y4TfxJ/Ir6Jg1t9v@salvia>
References: <20221124120437.244114-1-sbrivio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221124120437.244114-1-sbrivio@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 24, 2022 at 01:04:37PM +0100, Stefano Brivio wrote:
> Embarrassingly, nft_pipapo_insert() checked for interval validity in
> the first field only.
> 
> The start_p and end_p pointers were reset to key data from the first
> field at every iteration of the loop which was supposed to go over
> the set fields.

Applied to nf, thanks
