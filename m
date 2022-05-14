Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3F9527335
	for <lists+netfilter-devel@lfdr.de>; Sat, 14 May 2022 19:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234432AbiENREw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 14 May 2022 13:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiENREv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 14 May 2022 13:04:51 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6672D18E00
        for <netfilter-devel@vger.kernel.org>; Sat, 14 May 2022 10:04:50 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1npvCC-0007sK-KN; Sat, 14 May 2022 19:04:48 +0200
Date:   Sat, 14 May 2022 19:04:48 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Nick Hainke <vincent@systemli.org>
Cc:     netfilter-devel@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
Subject: Re: [PATCH iptables 1/2] xtables: fix compilation with musl
Message-ID: <Yn/hMODAkEEbzQno@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
        Nick Hainke <vincent@systemli.org>, netfilter-devel@vger.kernel.org,
        Maciej =?utf-8?Q?=C5=BBenczykowski?= <maze@google.com>
References: <20220514163325.54266-1-vincent@systemli.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220514163325.54266-1-vincent@systemli.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

On Sat, May 14, 2022 at 06:33:24PM +0200, Nick Hainke wrote:
> Only include <linux/if_ether.h> if glibc is used.

This looks like a bug in musl? OTOH explicit include of linux/if_ether.h
was added in commit c5d9a723b5159 ("fix build for missing ETH_ALEN
definition"), despite netinet/ether.h being included in line 2248 of
libxtables/xtables.c. So maybe *also* a bug in bionic?!

Cheers, Phil
