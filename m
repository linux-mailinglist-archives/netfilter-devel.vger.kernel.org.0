Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEFB74912A
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Jul 2023 00:56:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231833AbjGEW4y (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Jul 2023 18:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbjGEW4y (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Jul 2023 18:56:54 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D220CF7;
        Wed,  5 Jul 2023 15:56:53 -0700 (PDT)
Date:   Thu, 6 Jul 2023 00:56:50 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Cc:     netfilter-devel@vger.kernel.org, netdev@vger.kernel.org,
        Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH v2] netfilter: nf_tables: prevent OOB access in
 nft_byteorder_eval
Message-ID: <ZKX1Mt2pjVTpjA24@calendula>
References: <20230705201232.GG3751@breakpoint.cc>
 <20230705210535.943194-1-cascardo@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230705210535.943194-1-cascardo@canonical.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jul 05, 2023 at 06:05:35PM -0300, Thadeu Lima de Souza Cascardo wrote:
> When evaluating byteorder expressions with size 2, a union with 32-bit and
> 16-bit members is used. Since the 16-bit members are aligned to 32-bit,
> the array accesses will be out-of-bounds.

Applied to nf, thanks
