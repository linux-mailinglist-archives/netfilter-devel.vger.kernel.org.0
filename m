Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA0D46D6D52
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 Apr 2023 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232313AbjDDTlG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 Apr 2023 15:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234726AbjDDTlE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 Apr 2023 15:41:04 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D83344AA
        for <netfilter-devel@vger.kernel.org>; Tue,  4 Apr 2023 12:41:02 -0700 (PDT)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
        (envelope-from <n0-1@orbyte.nwl.cc>)
        id 1pjmWZ-0006eQ-EZ; Tue, 04 Apr 2023 21:40:59 +0200
Date:   Tue, 4 Apr 2023 21:40:59 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Alyssa Ross <hi@alyssa.is>
Cc:     netfilter-devel@vger.kernel.org, Jeremy Sowden <jeremy@azazel.net>
Subject: Re: [PATCH iptables v2] build: use pkg-config for libpcap
Message-ID: <ZCx9S2UfYFrwYigO@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>, Alyssa Ross <hi@alyssa.is>,
        netfilter-devel@vger.kernel.org, Jeremy Sowden <jeremy@azazel.net>
References: <20230402232939.1060151-1-hi@alyssa.is>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230402232939.1060151-1-hi@alyssa.is>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sun, Apr 02, 2023 at 11:29:40PM +0000, Alyssa Ross wrote:
> If building statically, with libpcap built with libnl support, linking
> will fail, as the compiler won't be able to find the libnl symbols
> since static libraries don't contain dependency information.  To fix
> this, use pkg-config to find the flags for linking libpcap, since the
> pkg-config files contain the neccesary dependency information.
> 
> autoconf will add code to the configure script for initializing
> pkg-config the first time it seems PKG_CHECK_MODULES, so make the
> libnfnetlink check the first one in the script, so the initialization
> code is run unconditionally.
> 
> Signed-off-by: Alyssa Ross <hi@alyssa.is>

Patch applied, thanks!
