Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7A66B1FF9
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Mar 2023 10:27:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbjCIJ1X (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 Mar 2023 04:27:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbjCIJ1W (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 Mar 2023 04:27:22 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56344E190D
        for <netfilter-devel@vger.kernel.org>; Thu,  9 Mar 2023 01:27:21 -0800 (PST)
Date:   Thu, 9 Mar 2023 10:27:18 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH nf 0/4] NAT fixes
Message-ID: <ZAmmdikdFvL6rYhy@salvia>
References: <20230307232259.2681135-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230307232259.2681135-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:22:55PM +0000, Jeremy Sowden wrote:
> These bug-fixes were originally part of a larger series adding shifted
> port-ranges to nft NAT and targetting nf-next, but Florian suggested
> sending them via nf instead to get them upstream more quickly.

Applied to nf.git, thanks
