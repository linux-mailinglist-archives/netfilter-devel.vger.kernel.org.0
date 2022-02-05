Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0EC94AAC4C
	for <lists+netfilter-devel@lfdr.de>; Sat,  5 Feb 2022 20:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349079AbiBETdO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 5 Feb 2022 14:33:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiBETdO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 5 Feb 2022 14:33:14 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EF5C061348
        for <netfilter-devel@vger.kernel.org>; Sat,  5 Feb 2022 11:33:11 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 6F5A158730CF1; Sat,  5 Feb 2022 20:33:08 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 693F460C2B6C5;
        Sat,  5 Feb 2022 20:33:08 +0100 (CET)
Date:   Sat, 5 Feb 2022 20:33:08 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [xtables-addons PATCH 0/2] 5.17 Kernel Support
In-Reply-To: <20220204132643.1212741-1-jeremy@azazel.net>
Message-ID: <77q0284q-572o-31n4-q47-o2ss27717351@vanv.qr>
References: <20220204132643.1212741-1-jeremy@azazel.net>
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

On Friday 2022-02-04 14:26, Jeremy Sowden wrote:

>The `PDE_DATA` procfs function has been replaced by another function,
>`pde_data`, in 5.17.  The first patch adds support for this.  The second
>bumps the maximum supported kernel version to 5.17.

Added, with some blank lines more removed.
