Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DDE4B7AAF
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Feb 2022 23:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240261AbiBOWrW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Feb 2022 17:47:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiBOWrV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Feb 2022 17:47:21 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872E8D5F4D
        for <netfilter-devel@vger.kernel.org>; Tue, 15 Feb 2022 14:47:10 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@strlen.de>)
        id 1nK6b8-0001tc-AI; Tue, 15 Feb 2022 23:47:02 +0100
Date:   Tue, 15 Feb 2022 23:47:02 +0100
From:   Florian Westphal <fw@strlen.de>
To:     Jethro Beekman <jethro@fortanix.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] xshared: Implement xtables lock timeout using signals
Message-ID: <YgwtWrEDPNNAzz0k@strlen.de>
References: <e213920b-a90d-b543-2166-4fb5ec94bdde@fortanix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e213920b-a90d-b543-2166-4fb5ec94bdde@fortanix.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Jethro Beekman <jethro@fortanix.com> wrote:
> Previously, if a lock timeout is specified using `-wN `, flock() is
> called using LOCK_NB in a loop with a sleep. This results in two issues.

Applied, thank you.
