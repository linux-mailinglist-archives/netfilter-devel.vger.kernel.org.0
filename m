Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7C64C39BE
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Feb 2022 00:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233679AbiBXXiq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Feb 2022 18:38:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232457AbiBXXiq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 18:38:46 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A983118E3EE
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Feb 2022 15:38:15 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id F36E26433D;
        Fri, 25 Feb 2022 00:37:05 +0100 (CET)
Date:   Fri, 25 Feb 2022 00:38:12 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Sam James <sam@gentoo.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 2/2] build: explicitly pass --version-script to linker
Message-ID: <YhgW5Be32UGbMPG4@salvia>
References: <20220224194543.59581-1-sam@gentoo.org>
 <20220224194543.59581-2-sam@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220224194543.59581-2-sam@gentoo.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Feb 24, 2022 at 07:45:43PM +0000, Sam James wrote:
> --version-script is a linker option, so let's use -Wl, so that
> libtool handles it properly. It seems like the previous method gets silently
> ignored with GNU libtool in some cases(?) and downstream in Gentoo,
> we had to apply this change to make the build work with slibtool anyway.
> 
> But it's indeed correct in any case, so let's swap.

Also applied, thanks
