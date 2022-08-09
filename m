Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 852CB58DD58
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbiHIRkA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 13:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRj7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 13:39:59 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F38F125C44
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Aug 2022 10:39:58 -0700 (PDT)
Date:   Tue, 9 Aug 2022 19:39:55 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v4] netfilter: nf_tables: validate variable length
 element extension
Message-ID: <YvKb6+QRfsZFwQ6S@salvia>
References: <20220809092543.232202-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220809092543.232202-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Aug 09, 2022 at 11:25:43AM +0200, Pablo Neira Ayuso wrote:
> Update template to validate variable length extensions. This patch adds
> a new .ext_len[id] field to the template to store the expected extension
> length. This is used to sanity check the initialization of the variable
> length extension.
> 
> Use PTR_ERR() in nft_set_elem_init() to report errors since, after this
> update, there are two reason why this might fail, either because of
> ENOMEM or insufficient room in the extension field (EINVAL).
> 
> Kernels up until 7e6bc1f6cabc ("netfilter: nf_tables: stricter
> validation of element data") allowed to copy more data to the extension
> than was allocated. This ext_len field allows to validate if the
> destination has the correct size as additional check.

I have applied this to nf.git
