Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0DA7D6771
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Oct 2023 11:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229606AbjJYJsl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Oct 2023 05:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234154AbjJYJsk (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:48:40 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DBFB4
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Oct 2023 02:48:38 -0700 (PDT)
Received: from [78.30.35.151] (port=50366 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qvaV8-00CiEq-K9
        for netfilter-devel@vger.kernel.org; Wed, 25 Oct 2023 11:48:36 +0200
Date:   Wed, 25 Oct 2023 11:48:33 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf-next 0/5] nf_tables set updates
Message-ID: <ZTjkcdBmeNrnsd50@calendula>
References: <20231024083359.24742-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231024083359.24742-1-pablo@netfilter.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 24, 2023 at 10:33:54AM +0200, Pablo Neira Ayuso wrote:
> Hi,
> 
> This is a first batch of nf_tables set updates:
> 
> 1) Use nft_set_ext already accesible as parameter via .flush(), no
>    need for pipapo_deactivate() call.
> 
> 2) Turn .flush into void, this never fails.
> 
> 3) Add and use struct nft_elem_priv placeholder, suggested by Florian.
> 
> 4) Shrink memory usage for set elements in transactions, as well as
>    stack usage.
> 
> 5) Use struct nft_elem_priv in .insert, in preparation for set timeout
>    updates, this will come in a later patch.
> 
> This batch has survived hours of 30s-stress runs and tests/shell,
> I am still stress testing the set element updates, that will come in
> a follow up batch.

Series applied to nf-next
