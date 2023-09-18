Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD3547A5227
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Sep 2023 20:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjIRSjs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Sep 2023 14:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjIRSjr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Sep 2023 14:39:47 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71C45FC
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Sep 2023 11:39:41 -0700 (PDT)
Received: from [78.30.34.192] (port=50342 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qiJ9k-00BNNV-4j
        for netfilter-devel@vger.kernel.org; Mon, 18 Sep 2023 20:39:38 +0200
Date:   Mon, 18 Sep 2023 20:39:35 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: update mark datatype compatibility check
 from maps
Message-ID: <ZQiZZxAVJGVizn9Y@calendula>
References: <20230918181350.330701-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918181350.330701-1-pablo@netfilter.org>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Sep 18, 2023 at 08:13:50PM +0200, Pablo Neira Ayuso wrote:
> Wrap datatype compatibility check into a helper function and use it for
> map evaluation, otherwise the following bogus error message is
> displayed:
> 
>   Error: datatype mismatch, map expects packet mark, mapping expression has type integer
> 
> Add unit tests to improve coverage for this usecase.

Scratch this, I will send a v2.
