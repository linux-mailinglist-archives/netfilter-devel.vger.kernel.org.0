Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D0D963D2BB
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Nov 2022 11:04:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiK3KEq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Nov 2022 05:04:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiK3KEl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Nov 2022 05:04:41 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B724097
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Nov 2022 02:04:34 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 0D31958730FB7; Wed, 30 Nov 2022 11:04:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 0B0EE60D22748;
        Wed, 30 Nov 2022 11:04:33 +0100 (CET)
Date:   Wed, 30 Nov 2022 11:04:33 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Jeremy Sowden <jeremy@azazel.net>
cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2 v2 v2 05/34] build: add checks to configure.ac
In-Reply-To: <20221129214749.247878-6-jeremy@azazel.net>
Message-ID: <4ssp4110-24p6-5614-o1o-85nqp1rqqs70@vanv.qr>
References: <20221129214749.247878-1-jeremy@azazel.net> <20221129214749.247878-6-jeremy@azazel.net>
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

>Autoscan complains about a number of missing function, header and type
>checks.
>
>+AC_CHECK_HEADER_STDBOOL
>+AC_CHECK_HEADERS([arpa/inet.h  \

I reject.

It does not make sense to perform checks and then not make use of the
outcome (HAVE_ARPA_INET_H) in source code. The same goes for all the
other checks.
