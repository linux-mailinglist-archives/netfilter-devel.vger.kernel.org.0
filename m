Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A258D6D7B31
	for <lists+netfilter-devel@lfdr.de>; Wed,  5 Apr 2023 13:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjDELXs (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Apr 2023 07:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237503AbjDELXs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:23:48 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AE5131
        for <netfilter-devel@vger.kernel.org>; Wed,  5 Apr 2023 04:23:46 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pk1Ev-0005jR-6w
        for netfilter-devel@vger.kernel.org; Wed, 05 Apr 2023 13:23:45 +0200
Date:   Wed, 5 Apr 2023 13:23:45 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] tests: shell: Test for false-positive rule check
Message-ID: <ZC1aQaF8IftsLeQq@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230405112120.9065-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230405112120.9065-1-phil@nwl.cc>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Apr 05, 2023 at 01:21:20PM +0200, Phil Sutter wrote:
> Rule comparison in legacy ip6tables was broken by commit eb2546a846776
> ("xshared: Share make_delete_mask() between ip{,6}tables"): A part of
> the rules' data was masked out for comparison by accident.
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Patch applied.
