Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43DB9766F0A
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jul 2023 16:10:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235624AbjG1OKR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jul 2023 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232825AbjG1OKQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:10:16 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A8EF35A8
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Jul 2023 07:10:15 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qPOAX-00070m-S0; Fri, 28 Jul 2023 16:10:13 +0200
Date:   Fri, 28 Jul 2023 16:10:13 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, arturo@netfilter.org,
        jengelh@inai.de
Subject: Re: [PATCH nft 2/2] py: remove setup.py integration with autotools
Message-ID: <ZMPMRUvcG//ZJF9W@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        netfilter-devel@vger.kernel.org, arturo@netfilter.org,
        jengelh@inai.de
References: <20230718120119.172757-1-pablo@netfilter.org>
 <20230718120119.172757-2-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718120119.172757-2-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jul 18, 2023 at 02:01:19PM +0200, Pablo Neira Ayuso wrote:
> With Python distutils and setuptools going deprecated, remove
> integration with autotools. This integration is causing issues
> in modern environments.
> 
> Note that setup.py is still left in place under the py/ folder.
> 
> Update INSTALL file to refer to Python support and setup.py.
> 
> Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>

Acked-by: Phil Sutter <phil@nwl.cc>
