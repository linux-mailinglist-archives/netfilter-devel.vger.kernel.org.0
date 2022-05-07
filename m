Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 748A651E7BA
	for <lists+netfilter-devel@lfdr.de>; Sat,  7 May 2022 16:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359597AbiEGOVM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 7 May 2022 10:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbiEGOVM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 7 May 2022 10:21:12 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90471120AC
        for <netfilter-devel@vger.kernel.org>; Sat,  7 May 2022 07:17:24 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 3FD0058728EBE; Sat,  7 May 2022 16:17:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 3CD8F60ED3130;
        Sat,  7 May 2022 16:17:21 +0200 (CEST)
Date:   Sat, 7 May 2022 16:17:21 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH xtables-addons 1/2] doc: fix some typos in man-pages
In-Reply-To: <20220507115924.3590034-1-jeremy@azazel.net>
Message-ID: <4r6754-8qp9-47pp-88sq-rps0p59ppro@vanv.qr>
References: <20220507115924.3590034-1-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Saturday 2022-05-07 13:59, Jeremy Sowden wrote:
> extensions/ACCOUNT/libxt_ACCOUNT.man |  2 +-
> extensions/libxt_DELUDE.man          |  2 +-
> extensions/libxt_DHCPMAC.man         |  2 +-
> extensions/libxt_SYSRQ.man           | 12 ++++++------
> extensions/libxt_ipv4options.man     |  2 +-
> extensions/libxt_psd.man             |  2 +-
> 6 files changed, 11 insertions(+), 11 deletions(-)

Done
