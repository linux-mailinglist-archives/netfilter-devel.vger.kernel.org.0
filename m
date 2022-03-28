Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E25E4E9018
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Mar 2022 10:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbiC1I1F (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Mar 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiC1I1E (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:27:04 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31AA7DEBF
        for <netfilter-devel@vger.kernel.org>; Mon, 28 Mar 2022 01:25:24 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 2D3FE63004;
        Mon, 28 Mar 2022 10:22:16 +0200 (CEST)
Date:   Mon, 28 Mar 2022 10:25:21 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [conntrack-tools PATCH 0/8] Fixes for a recent Coverity tool run
Message-ID: <YkFw8ebsj2nyNioX@salvia>
References: <20220325105003.26621-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325105003.26621-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

LGTM

On Fri, Mar 25, 2022 at 11:49:55AM +0100, Phil Sutter wrote:
> Phil Sutter (8):
>   hash: Flush tables when destroying
>   cache: Fix features array allocation
>   Fix potential buffer overrun in snprintf() calls
>   helpers: ftp: Avoid ugly casts
>   read_config_yy: Drop extra argument from dlog() call
>   Don't call exit() from signal handler
>   Drop pointless assignments
>   connntrack: Fix for memleak when parsing -j arg
> 
>  src/cache.c          |  4 ++--
>  src/conntrack.c      |  2 ++
>  src/hash.c           |  1 +
>  src/helpers/ftp.c    | 20 +++++++++-----------
>  src/helpers/ssdp.c   |  1 -
>  src/main.c           |  2 +-
>  src/process.c        |  2 +-
>  src/queue.c          |  4 ++--
>  src/read_config_yy.y |  2 +-
>  src/run.c            |  2 +-
>  10 files changed, 20 insertions(+), 20 deletions(-)
> 
> -- 
> 2.34.1
> 
