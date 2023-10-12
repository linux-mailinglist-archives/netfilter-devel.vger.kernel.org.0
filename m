Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97967C75BC
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Oct 2023 20:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjJLSRU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Oct 2023 14:17:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347359AbjJLSRU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Oct 2023 14:17:20 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FC4BE
        for <netfilter-devel@vger.kernel.org>; Thu, 12 Oct 2023 11:17:18 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1qr0FI-0000Lh-Kb
        for netfilter-devel@vger.kernel.org; Thu, 12 Oct 2023 20:17:16 +0200
Date:   Thu, 12 Oct 2023 20:17:16 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [iptables PATCH] extensions: string: Clarify description of --to
Message-ID: <ZSg4LO0AHnQy7JsW@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org
References: <20231012160842.18584-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231012160842.18584-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Oct 12, 2023 at 06:08:42PM +0200, Phil Sutter wrote:
> String match indeed returns a match as long as the given pattern starts
> in the range of --from and --to, update the text accordingly.
> Also add a note regarding fragment boundaries.
> 
> Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1707
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Also applied.
