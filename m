Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE8544BDE2D
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Feb 2022 18:46:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378374AbiBUOvh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 21 Feb 2022 09:51:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378444AbiBUOvf (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 21 Feb 2022 09:51:35 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DE62220E9
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Feb 2022 06:51:04 -0800 (PST)
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C3BD360225;
        Mon, 21 Feb 2022 15:50:06 +0100 (CET)
Date:   Mon, 21 Feb 2022 15:51:01 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf] netfilter: nft_limit: fix stateful object memory leak
Message-ID: <YhOm1dzUXkg6Wqvh@salvia>
References: <20220218121705.3475-1-fw@strlen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220218121705.3475-1-fw@strlen.de>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Feb 18, 2022 at 01:17:05PM +0100, Florian Westphal wrote:
> We need to provide a destroy callback to release the extra fields.

Applied to nf, thanks
