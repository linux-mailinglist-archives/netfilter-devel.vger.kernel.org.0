Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0FA69B28B
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Feb 2023 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjBQStL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Feb 2023 13:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjBQStK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Feb 2023 13:49:10 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8910211E6
        for <netfilter-devel@vger.kernel.org>; Fri, 17 Feb 2023 10:49:09 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pT5nA-0005dv-5Q
        for netfilter-devel@vger.kernel.org; Fri, 17 Feb 2023 19:49:08 +0100
Date:   Fri, 17 Feb 2023 19:49:08 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH 1/2] tests: xlate: Properly split input in
 replay mode
Message-ID: <Y+/MJLMWuHXiPvaE@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20230217134855.17247-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230217134855.17247-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 17, 2023 at 02:48:54PM +0100, Phil Sutter wrote:
> Source command may contain quotes, using shlex.split() does the right
> thing there.
> 
> Fixes: 7705b2daa3bdc ("tests: xlate: Use --check to verify replay")
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series also applied.
