Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B89E26671D5
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Jan 2023 13:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232138AbjALMOA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Jan 2023 07:14:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjALMN1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:13:27 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4209820B
        for <netfilter-devel@vger.kernel.org>; Thu, 12 Jan 2023 04:13:01 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:12:57 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Neels Hofmeyr <nhofmeyr@sysmocom.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: build failure since commit 'xt: Rewrite unsupported compat
 expression dumping'
Message-ID: <Y7/5SRnkcq3kUtOx@salvia>
References: <Y738EXSaHcvYLnoH@my.box>
 <Y759ZZioewP6Ohmf@salvia>
 <Y79uac8cN6W8i0LF@my.box>
 <Y7/4DRQArdtyMu3m@salvia>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7/4DRQArdtyMu3m@salvia>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 12, 2023 at 01:07:44PM +0100, Pablo Neira Ayuso wrote:
> On Thu, Jan 12, 2023 at 03:20:25AM +0100, Neels Hofmeyr wrote:
> > I took a closer look: dropped the build dir and did 'git clean -dxf' -- after
> > that indeed the build works! Possibly there is a missing dependency in the
> > makefiles. I suppose I should have tried that before writing the mail, sorry...
> 
> No problem, thanks for confirming things work fine there.

Still, for some reason there, it seems the .c files that are
autogenerated by bison and flex were not refreshed.
