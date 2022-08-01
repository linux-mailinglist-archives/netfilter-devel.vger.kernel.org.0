Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C19B3586C51
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Aug 2022 15:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbiHANz7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Aug 2022 09:55:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiHANz6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Aug 2022 09:55:58 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AB8062DE8
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Aug 2022 06:55:55 -0700 (PDT)
Date:   Mon, 1 Aug 2022 15:55:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Oleksandr Natalenko <oleksandr@natalenko.name>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>,
        Loganaden Velvindron <logan@cyberstorm.mu>
Subject: Re: [PATCH v2] src: proto: support DF, LE PHB, VA for DSCP
Message-ID: <YufbY8F3NiJwqVzj@salvia>
References: <20220711104709.256302-1-oleksandr@natalenko.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220711104709.256302-1-oleksandr@natalenko.name>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Jul 11, 2022 at 12:47:09PM +0200, Oleksandr Natalenko wrote:
> Add a couple of aliases for well-known DSCP values.
> 
> As per RFC 4594, add "df" as an alias of "cs0" with 0x00 value.
> 
> As per RFC 5865, add "va" for VOICE-ADMIT with 0x2c value.
> 
> As per RFC 8622, add "lephb" for Lower-Effort Per-Hop Behavior with 0x01 value.
> 
> tc-cake(8) in diffserv8 mode would benefit from having "lephb" defined since
> it corresponds to "Tin 0".

Applied, thanks
