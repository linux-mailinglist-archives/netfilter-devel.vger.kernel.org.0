Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9885D63C013
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Nov 2022 13:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiK2McR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Nov 2022 07:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiK2McR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 07:32:17 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F5E5D6B7
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 04:32:15 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1ozzmW-0005ZQ-MB; Tue, 29 Nov 2022 13:32:12 +0100
Date:   Tue, 29 Nov 2022 13:32:12 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     netfilter-devel@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>
Subject: Re: [iptables PATCH 1/4] libxtables: xt_xlate_add() to take care of
 spacing
Message-ID: <Y4X7zMSBlaPmZGZN@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
References: <20221125161229.18406-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221125161229.18406-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Nov 25, 2022 at 05:12:26PM +0100, Phil Sutter wrote:
> Try to eliminate most of the whitespace issues by separating strings
> from separate xt_xlate_add() calls by whitespace if needed.
> 
> Cover the common case of consecutive range, list or MAC/IP address
> printing by inserting whitespace only if the string to be appended
> starts with an alphanumeric character or a brace. The latter helps to
> make spacing in anonymous sets consistent.
> 
> Provide *_nospc() variants which disable the auto-spacing for the
> mandatory exception to the rule.
> 
> Make things round by dropping any trailing whitespace before returning
> the buffer via xt_xlate_get().
> 
> Signed-off-by: Phil Sutter <phil@nwl.cc>

Series applied.
