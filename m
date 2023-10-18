Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44EC37CD848
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 11:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjJRJgr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Oct 2023 05:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229897AbjJRJgp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Oct 2023 05:36:45 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFD8FA;
        Wed, 18 Oct 2023 02:36:41 -0700 (PDT)
Received: from [78.30.34.192] (port=60938 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qt2yk-00C52B-6t; Wed, 18 Oct 2023 11:36:40 +0200
Date:   Wed, 18 Oct 2023 11:36:37 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     imnozi@gmail.com
Cc:     netfilter-devel@vger.kernel.org, netfilter@vger.kernel.org
Subject: Re: [nftables/nft] nft equivalent of "ipset test"
Message-ID: <ZS+nJS/4dolCsIk8@calendula>
References: <652EC034.7090501@mutluit.com>
 <20231017213507.GD5770@breakpoint.cc>
 <652F02EC.2050807@mutluit.com>
 <20231017220539.GE5770@breakpoint.cc>
 <652F0C75.8010006@mutluit.com>
 <20231017200057.57cfce21@playground>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231017200057.57cfce21@playground>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 17, 2023 at 08:00:57PM -0400, imnozi@gmail.com wrote:
> On Wed, 18 Oct 2023 00:36:37 +0200
> "U.Mutlu" <um@mutluit.com> wrote:
> 
> > ...
> > Actualy I need to do this monster:   :-)
> > 
> > IP="1.2.3.4"
> > ! nft "get element inet mytable myset  { $IP }" > /dev/null 2>&1 && \
> > ! nft "get element inet mytable myset2 { $IP }" > /dev/null 2>&1 && \
> >    nft "add element inet mytable myset  { $IP }"
> 
> Try using '||', akin to:

Please, use 'nft create' for this, no need for an explicit test and
then add from command line.

The idiom above is an antipattern, because it is not atomic, the
'create' command provides a way to first test if the element exists
(if so it fails) then add it.
