Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50D15893D7
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Aug 2022 22:56:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236941AbiHCU4h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Aug 2022 16:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236574AbiHCU4h (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Aug 2022 16:56:37 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B251EECD
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Aug 2022 13:56:35 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id C9EC95863A9C6; Wed,  3 Aug 2022 22:56:32 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id C7C1260C0485F;
        Wed,  3 Aug 2022 22:56:32 +0200 (CEST)
Date:   Wed, 3 Aug 2022 22:56:32 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Mark Mentovai <mark@mentovai.com>,
        Duncan Roe <duncan_roe@optusnet.com.au>
Subject: Re: [PATCH libmnl 5/6] doc: move man-page sym-link shell-script into
 a separate file
In-Reply-To: <20220803201247.3057365-6-jeremy@azazel.net>
Message-ID: <2spnnr6s-1q7s-12s1-n688-463n9q162np0@vanv.qr>
References: <20220803201247.3057365-1-jeremy@azazel.net> <20220803201247.3057365-6-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Wednesday 2022-08-03 22:12, Jeremy Sowden wrote:

>We use `$(SHELL)` to run the script and exec bash if `$(SHELL)` is something
>else.  We don't hard-code the path to bash.

Does it matter in practice? I don't recall seeing libmnl targeting
a BSD platform where bash prominently isn't /bin/bash.
