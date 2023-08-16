Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E249577E5EF
	for <lists+netfilter-devel@lfdr.de>; Wed, 16 Aug 2023 18:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233062AbjHPQDT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Aug 2023 12:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344654AbjHPQCr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:02:47 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB21272D
        for <netfilter-devel@vger.kernel.org>; Wed, 16 Aug 2023 09:02:35 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qWIyf-000102-6i; Wed, 16 Aug 2023 18:02:33 +0200
Date:   Wed, 16 Aug 2023 18:02:33 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [nft PATCH v4 2/6] src: add input flag NFT_CTX_INPUT_NO_DNS to
 avoid blocking
Message-ID: <ZNzzGZs6O9fpNach@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Thomas Haller <thaller@redhat.com>,
        NetFilter <netfilter-devel@vger.kernel.org>
References: <20230803193940.1105287-1-thaller@redhat.com>
 <20230803193940.1105287-5-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803193940.1105287-5-thaller@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Aug 03, 2023 at 09:35:16PM +0200, Thomas Haller wrote:
> getaddrinfo() blocks while trying to resolve the name. Blocking the
> caller of the library is in many cases undesirable. Also, while
> reconfiguring the firewall, it's not clear that resolving names via
> the network will work or makes sense.
> 
> Add a new input flag NFT_CTX_INPUT_NO_DNS to opt-out from getaddrinfo()
> and only accept plain IP addresses.
> 
> We could also use AI_NUMERICHOST with getaddrinfo() instead of
> inet_pton(). By parsing via inet_pton(), we are better aware of
> what we expect and can generate a better error message in case of
> failure.
> 
> Signed-off-by: Thomas Haller <thaller@redhat.com>

Reviewed-by: Phil Sutter <phil@nwl.cc>
