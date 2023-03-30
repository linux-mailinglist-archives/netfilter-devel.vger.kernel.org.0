Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C866D03F6
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Mar 2023 13:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231524AbjC3LwM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Mar 2023 07:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbjC3Lvp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:51:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE98186
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Mar 2023 04:51:13 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 95829587438DA; Thu, 30 Mar 2023 13:51:10 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 8E89D61C7F2A5;
        Thu, 30 Mar 2023 13:51:10 +0200 (CEST)
Date:   Thu, 30 Mar 2023 13:51:10 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Sriram Yagnaraman <sriram.yagnaraman@est.tech>
cc:     netfilter-devel@vger.kernel.org, Phil Sutter <phil@nwl.cc>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Subject: Re: [RFC PATCH] nft: autocomplete for libreadline
In-Reply-To: <20230330112535.31483-1-sriram.yagnaraman@est.tech>
Message-ID: <69r697s-n01r-s6qs-q766-1n31826q6s0@vanv.qr>
References: <20230330112535.31483-1-sriram.yagnaraman@est.tech>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org


On Thursday 2023-03-30 13:25, Sriram Yagnaraman wrote:

>-libnftables_LIBVERSION=2:0:1
>+libnftables_LIBVERSION=3:0:1

^ This looks very much incorrect.

>--- a/include/nftables/libnftables.h
>+++ b/include/nftables/libnftables.h
>+char **nft_get_expected_tokens(struct nft_ctx *nft, const char *line, const char *text);
>--- a/include/parser.h
>+++ b/include/parser.h
>+extern char **expected_matches (struct nft_ctx *nft, struct parser_state *state,
>+				const char *text);
