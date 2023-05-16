Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19896704429
	for <lists+netfilter-devel@lfdr.de>; Tue, 16 May 2023 05:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjEPD6O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 15 May 2023 23:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjEPD6K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 15 May 2023 23:58:10 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B5DC30F3;
        Mon, 15 May 2023 20:58:07 -0700 (PDT)
Date:   Tue, 16 May 2023 05:58:03 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: Patch for -stable, 6.3.x
Message-ID: <ZGL/S2D68bm29hC4@calendula>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Greg, Sasha,

Could you cherry-pick the follow patch into 6.3.x? Thanks.

commit f057b63bc11d86a98176de31b437e46789f44d8f
Author: Florian Westphal <fw@strlen.de>
Date:   Wed May 3 12:00:18 2023 +0200

    netfilter: nf_tables: fix ct untracked match breakage
    
    "ct untracked" no longer works properly due to erroneous NFT_BREAK.
    We have to check ctinfo enum first.
    
    Fixes: d9e789147605 ("netfilter: nf_tables: avoid retpoline overhead for some ct expression calls")
    Reported-by: Rvfg <i@rvf6.com>
    Link: https://marc.info/?l=netfilter&m=168294996212038&w=2
    Signed-off-by: Florian Westphal <fw@strlen.de>
    Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
