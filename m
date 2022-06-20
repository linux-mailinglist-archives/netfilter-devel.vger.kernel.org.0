Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB677551FBE
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 17:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243084AbiFTPHL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 11:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231402AbiFTPGu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 11:06:50 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6F81E22BF0
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 07:44:30 -0700 (PDT)
Date:   Mon, 20 Jun 2022 16:44:06 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Bill Wendling <morbo@google.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 12/12] netfilter: conntrack: use correct format characters
Message-ID: <YrCHtmZlK384yiCo@salvia>
References: <20220609221702.347522-1-morbo@google.com>
 <20220609221702.347522-13-morbo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220609221702.347522-13-morbo@google.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jun 09, 2022 at 10:16:31PM +0000, Bill Wendling wrote:
> From: Bill Wendling <isanbard@gmail.com>
> 
> When compiling with -Wformat, clang emits the following warnings:
> 
> net/netfilter/nf_conntrack_helper.c:168:18: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
>                 request_module(mod_name);
>                                ^~~~~~~~
> 
> Use a string literal for the format string.

Should I handle this through the netfilter tree? Or you prefer a
different path?

Thanks
