Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAC97AD66C
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Sep 2023 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjIYKxO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Sep 2023 06:53:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYKxO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Sep 2023 06:53:14 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A9DB8
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Sep 2023 03:53:07 -0700 (PDT)
Received: from [78.30.34.192] (port=49648 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qkjD5-00Fy3e-Cg; Mon, 25 Sep 2023 12:53:05 +0200
Date:   Mon, 25 Sep 2023 12:53:02 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [nf PATCH 5/5] netfilter: nf_tables: Add locking for
 NFT_MSG_GETSETELEM_RESET requests
Message-ID: <ZRFmjoAn6Ltuk8ff@calendula>
References: <20230923013807.11398-1-phil@nwl.cc>
 <20230923013807.11398-6-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230923013807.11398-6-phil@nwl.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Sep 23, 2023 at 03:38:07AM +0200, Phil Sutter wrote:
> Introduce dedicated callbacks for nfnetlink and the asynchronous dump
> handling which perform the necessary locking.

I would describe here what this patchset fixes, basically, two
different threads that dump the set content with the _RESET command is
problematic since both threads are racing. You might find a better
wording for this.
