Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B597A8F13
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Sep 2023 00:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjITWAd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 20 Sep 2023 18:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITWAd (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 20 Sep 2023 18:00:33 -0400
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C380C9
        for <netfilter-devel@vger.kernel.org>; Wed, 20 Sep 2023 15:00:25 -0700 (PDT)
Received: from [78.30.34.192] (port=49974 helo=gnumonks.org)
        by ganesha.gnumonks.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <pablo@gnumonks.org>)
        id 1qj5F5-005wgD-SA; Thu, 21 Sep 2023 00:00:22 +0200
Date:   Thu, 21 Sep 2023 00:00:18 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Thomas Haller <thaller@redhat.com>
Cc:     NetFilter <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nft] datatype: return const pointer from datatype_get()
Message-ID: <ZQtrcts0lPxZioka@calendula>
References: <20230920200922.867334-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230920200922.867334-1-thaller@redhat.com>
X-Spam-Score: -1.8 (-)
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Sep 20, 2023 at 10:09:19PM +0200, Thomas Haller wrote:
> "struct datatype" is for the most part immutable, and most callers deal
> with const pointers. That's why datatype_get() accepts a const pointer
> to increase the reference count (mutating the refcnt field).
> 
> It should also return a const pointer. In fact, all callers are fine
> with that already.

Applied, thanks Thomas
