Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05B463D346
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Nov 2022 11:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbiK3K03 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Nov 2022 05:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbiK3K02 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:26:28 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F982EF15
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Nov 2022 02:26:28 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 956CE58730FB7; Wed, 30 Nov 2022 11:26:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 9382D60D45410;
        Wed, 30 Nov 2022 11:26:26 +0100 (CET)
Date:   Wed, 30 Nov 2022 11:26:26 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 v2 v2 13/34] output: remove zero-initialized
 `struct ulogd_plugin` members
In-Reply-To: <20221129214749.247878-14-jeremy@azazel.net>
Message-ID: <83oq798n-8481-15s8-498r-4o82ssqr4873@vanv.qr>
References: <20221129214749.247878-1-jeremy@azazel.net> <20221129214749.247878-14-jeremy@azazel.net>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Tuesday 2022-11-29 22:47, Jeremy Sowden wrote:

>Struct members are zero-initialized as a matter of course.
>
>--- a/output/ipfix/ulogd_output_IPFIX.c
>+++ b/output/ipfix/ulogd_output_IPFIX.c
>@@ -486,22 +486,22 @@ again:
>+	.config_kset    = (struct config_keyset *) &ipfix_kset,

Here's an opportunity to remove casts, I think.
