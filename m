Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE514EB549
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Mar 2022 23:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbiC2V3r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Mar 2022 17:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbiC2V3q (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Mar 2022 17:29:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C9266236BB2
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Mar 2022 14:28:03 -0700 (PDT)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id E59B963032;
        Tue, 29 Mar 2022 23:24:49 +0200 (CEST)
Date:   Tue, 29 Mar 2022 23:28:00 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [libnfnetlink PATCH 2/2] libnfnetlink: Check getsockname()
 return code
Message-ID: <YkN54N/bHp7zfcEz@salvia>
References: <20220325173426.11493-1-phil@nwl.cc>
 <20220325173426.11493-2-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220325173426.11493-2-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 25, 2022 at 06:34:26PM +0100, Phil Sutter wrote:
> The function may return -1 (and set errno). Assume it will leave
> addr_len value unchanged, so checking is necessary to not hide the
> error.

LGTM.

> Fixes: 4248314d40187 ("nfnl: fix compilation warning with gcc-4.7")
> Signed-off-by: Phil Sutter <phil@nwl.cc>
