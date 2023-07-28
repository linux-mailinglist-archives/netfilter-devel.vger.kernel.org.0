Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1449D7668E8
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jul 2023 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234572AbjG1Jdh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jul 2023 05:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbjG1JdZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:33:25 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6329AA2
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Jul 2023 02:33:23 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qPJqb-0004T6-KW
        for netfilter-devel@vger.kernel.org; Fri, 28 Jul 2023 11:33:21 +0200
Date:   Fri, 28 Jul 2023 11:33:21 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] nft: Special casing for among match in
 compare_matches()
Message-ID: <ZMOLYZr+fvuBCs63@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230721201425.16448-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721201425.16448-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:14:24PM +0200, Phil Sutter wrote:
> When other extensions may have "garbage" appended to their data which
> should not be considered for match comparison, among match is the
> opposite in that it extends its data beyond the value in 'size' field.
> Add special casing to cover for this, avoiding false-positive rule
> comparison.
> 
> Fixes: 26753888720d8 ("nft: bridge: Rudimental among extension support")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
