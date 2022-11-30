Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23BE463D337
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Nov 2022 11:22:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiK3KWc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Nov 2022 05:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234531AbiK3KWQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:22:16 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE241F9E7
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Nov 2022 02:21:55 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 8D70358730FB7; Wed, 30 Nov 2022 11:21:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8B8F160D4541A;
        Wed, 30 Nov 2022 11:21:53 +0100 (CET)
Date:   Wed, 30 Nov 2022 11:21:53 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 v2 v2 07/34] src: remove zero-valued config-key
 fields
In-Reply-To: <20221129214749.247878-8-jeremy@azazel.net>
Message-ID: <8246q2r-95pr-4sn5-s215-sp6p778o74@vanv.qr>
References: <20221129214749.247878-1-jeremy@azazel.net> <20221129214749.247878-8-jeremy@azazel.net>
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
>@@ -35,13 +35,10 @@ static struct config_keyset libulog_kset = {
> 		[MARK_MARK] = {
> 			.key 	 = "mark",
> 			.type 	 = CONFIG_TYPE_INT,
>-			.options = CONFIG_OPT_NONE,
>-			.u.value = 0,
> 		},

The struct is *aggregate-initialized*, which means two things:

 - unspecified elements are *empty-initialized*
 - since the cost of initialization has already been paid,
   one might as well be explicit about .options
   and not rely on CONFIG_OPT_NONE being 0.


NB: these structs could use a "const" qualifier.
