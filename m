Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 838175AE22A
	for <lists+netfilter-devel@lfdr.de>; Tue,  6 Sep 2022 10:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbiIFIMa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 6 Sep 2022 04:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiIFIMP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 6 Sep 2022 04:12:15 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D7A8845F66
        for <netfilter-devel@vger.kernel.org>; Tue,  6 Sep 2022 01:12:10 -0700 (PDT)
Date:   Tue, 6 Sep 2022 10:12:05 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft v2] json: fix empty statement list output in sets and
 maps
Message-ID: <YxcA1UPjZDaofklI@salvia>
References: <20220904171826.74525-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220904171826.74525-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Sep 04, 2022 at 07:18:26PM +0200, Fernando Fernandez Mancera wrote:
> JSON output of sets and map should not include the statements list if is
> empty. The statement output should be stateless also.
> 
> In addition, removes duplicated code.

Applied, thanks
