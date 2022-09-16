Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B912E5BA78B
	for <lists+netfilter-devel@lfdr.de>; Fri, 16 Sep 2022 09:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbiIPHjI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 16 Sep 2022 03:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiIPHjG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 16 Sep 2022 03:39:06 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8F7A1D74
        for <netfilter-devel@vger.kernel.org>; Fri, 16 Sep 2022 00:39:03 -0700 (PDT)
Date:   Fri, 16 Sep 2022 09:38:59 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Fernando Fernandez Mancera <ffmancera@riseup.net>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] json: add secmark object reference support
Message-ID: <YyQoE4/1O1IFh3Vf@salvia>
References: <20220910075948.58810-1-ffmancera@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220910075948.58810-1-ffmancera@riseup.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Sep 10, 2022 at 09:59:48AM +0200, Fernando Fernandez Mancera wrote:
> The secmark object reference requires a json parser function and it was
> missing. In addition, extends the shell testcases.

Applied, thanks
