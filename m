Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D88F7A663C
	for <lists+netfilter-devel@lfdr.de>; Tue, 19 Sep 2023 16:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbjISOMm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 19 Sep 2023 10:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjISOMl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:12:41 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6301783
        for <netfilter-devel@vger.kernel.org>; Tue, 19 Sep 2023 07:12:36 -0700 (PDT)
Received: from [78.30.34.192] (port=41994 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qibSq-00G3oP-R8; Tue, 19 Sep 2023 16:12:34 +0200
Date:   Tue, 19 Sep 2023 16:12:32 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nf_tables: fix memory leak when more than
 255 elements expired
Message-ID: <ZQmsUBdJn2JH5tOt@calendula>
References: <20230919133616.20436-1-fw@strlen.de>
 <20230919135938.GC23945@breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230919135938.GC23945@breakpoint.cc>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Sep 19, 2023 at 03:59:38PM +0200, Florian Westphal wrote:
> Florian Westphal <fw@strlen.de> wrote:
> > When more than 255 elements expire we're supposed to switch to a new gc
> > container structure, but nft_trans_gc_space() always returns false in this
> 
> Grrr.  This should read 'always returns true' or 'never returns false',
> but not *THIS*.  I'll fix this up when applying this, probably tomorrow
> morning.

You could amend the fix when applying this.
