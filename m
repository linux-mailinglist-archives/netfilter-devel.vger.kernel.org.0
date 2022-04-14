Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BC501918
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Apr 2022 18:51:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241507AbiDNQxj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 14 Apr 2022 12:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343911AbiDNQxU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 14 Apr 2022 12:53:20 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CFCD13BAC1
        for <netfilter-devel@vger.kernel.org>; Thu, 14 Apr 2022 09:22:27 -0700 (PDT)
Date:   Thu, 14 Apr 2022 18:22:24 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] intervals: Simplify element sanity checks
Message-ID: <YlhKQHpyME9YLIK3@salvia>
References: <20220414113924.15553-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220414113924.15553-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Apr 14, 2022 at 01:39:24PM +0200, Phil Sutter wrote:
> Since setelem_delete() assigns to 'prev' pointer only if it doesn't have
> EXPR_F_REMOVE flag set, there is no need to check that flag in called
> functions.

Applied, thanks
