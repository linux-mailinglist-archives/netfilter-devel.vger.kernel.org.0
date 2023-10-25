Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4823A7D6768
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Oct 2023 11:47:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234938AbjJYJr3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Oct 2023 05:47:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234971AbjJYJrP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:47:15 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5A2D7D
        for <netfilter-devel@vger.kernel.org>; Wed, 25 Oct 2023 02:46:50 -0700 (PDT)
Received: from [78.30.35.151] (port=50132 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qvaTO-00Ci7d-Be; Wed, 25 Oct 2023 11:46:48 +0200
Date:   Wed, 25 Oct 2023 11:46:45 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH  nf-next] br_netfilter: use single forward hook for ip
 and arp
Message-ID: <ZTjkBck5AQBxX14p@calendula>
References: <20231020111429.29083-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231020111429.29083-1-fw@strlen.de>
X-Spam-Score: -1.9 (-)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Oct 20, 2023 at 01:14:25PM +0200, Florian Westphal wrote:
> br_netfilter registers two forward hooks, one for ip and one for arp.
> 
> Just use a common function for both and then call the arp/ip helper
> as needed.

Applied, thanks
