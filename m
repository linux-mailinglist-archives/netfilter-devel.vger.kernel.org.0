Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB57A78E975
	for <lists+netfilter-devel@lfdr.de>; Thu, 31 Aug 2023 11:33:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbjHaJdH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 31 Aug 2023 05:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241930AbjHaJdH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 31 Aug 2023 05:33:07 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756AECF3
        for <netfilter-devel@vger.kernel.org>; Thu, 31 Aug 2023 02:33:03 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id C12CF586D41F6; Thu, 31 Aug 2023 11:33:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id BEF9361939799;
        Thu, 31 Aug 2023 11:33:01 +0200 (CEST)
Date:   Thu, 31 Aug 2023 11:33:01 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Ian Kumlien <ian.kumlien@gmail.com>
cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org
Subject: Re: MASQ leak?
In-Reply-To: <CAA85sZsLFsThq4jz1gx0UZj5ab+6SUbhPxy+gsM1d7o2S49LdA@mail.gmail.com>
Message-ID: <86o37onn-8431-noor-1p0p-8764n0855n74@vanv.qr>
References: <CAA85sZsLFsThq4jz1gx0UZj5ab+6SUbhPxy+gsM1d7o2S49LdA@mail.gmail.com>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2023-08-31 11:14, Ian Kumlien wrote:
>
>Anyway, it turns out that netfilter masq can leak internal information.
>
>It was fixed by doing:
>table inet filter {
>...
>       chain forward {
>               type filter hook forward priority 0
>                ct state invalid counter drop # <- this one
>
>It just seems odd to me that traffic can go through without being NAT:ed

MASQ requires connection tracking; if tracking is disabled for a connection,
addresses cannot be changed.

>And since i thought it was quite bad to just drop internal traffic

Now you know why drop policies are in place in every serious installation.
