Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E5B4666286
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Jan 2023 19:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbjAKSJ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Jan 2023 13:09:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbjAKSJp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Jan 2023 13:09:45 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 736EB19024
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Jan 2023 10:09:31 -0800 (PST)
Date:   Wed, 11 Jan 2023 19:09:28 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org,
        Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: Re: [PATCH nf] selftests: netfilter: fix transaction test script
 timeout handling
Message-ID: <Y777WDRSvjKK7qE3@salvia>
References: <20230104115442.2427-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230104115442.2427-1-fw@strlen.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Jan 04, 2023 at 12:54:42PM +0100, Florian Westphal wrote:
> The kselftest framework uses a default timeout of 45 seconds for
> all test scripts.
> 
> Increase the timeout to two minutes for the netfilter tests, this
> should hopefully be enough,
> 
> Make sure that, should the script be canceled, the net namespace and
> the spawned ping instances are removed.

Applied to nf.git, thanks
