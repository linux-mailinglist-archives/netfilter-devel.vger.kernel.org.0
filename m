Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462AE53A6A2
	for <lists+netfilter-devel@lfdr.de>; Wed,  1 Jun 2022 15:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353624AbiFANya (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 Jun 2022 09:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353690AbiFANyQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 Jun 2022 09:54:16 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721688A33E
        for <netfilter-devel@vger.kernel.org>; Wed,  1 Jun 2022 06:54:02 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1nwOn2-0005GP-Tt; Wed, 01 Jun 2022 15:53:36 +0200
Date:   Wed, 1 Jun 2022 15:53:36 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Nick Hainke <vincent@systemli.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] Revert "Simplify static build extension loading"
Message-ID: <YpdvYPV5L7Mxs3VQ@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Nick Hainke <vincent@systemli.org>, netfilter-devel@vger.kernel.org
References: <20220601134743.14415-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220601134743.14415-1-vincent@systemli.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jun 01, 2022 at 03:47:43PM +0200, Nick Hainke wrote:
> This reverts commit 6c689b639cf8e2aeced8685eca2915892d76ad86.
> 
> The stubs broke the libiptext used in firewall3 by OpenWrt.

What's the problem?
