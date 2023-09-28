Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C907B22FD
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Sep 2023 18:52:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjI1Qw4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 28 Sep 2023 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbjI1Qwx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 28 Sep 2023 12:52:53 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2D09193
        for <netfilter-devel@vger.kernel.org>; Thu, 28 Sep 2023 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=TCOEn2MIVtZx2iNX3YEblgH5EMUT9N2FV/ydItJNYKQ=; b=ajfaPEcGgsFw6Wjw6+98HLKAVQ
        f0NVaWXqsR4l/X52R43uocepwrayBxKGQDcC/BpekMEPMzd3WRgq9Gx4g1wsCJpBSn7zQi56YfBAs
        zHssmLDnWPHOtWkPURKm91E6LzrFLStbgjGKnoKtb/mX5jnShXKv3SEaGUsmKBqM0dZMfWGpJxn1R
        AW6tMAFACp60jHYWEVXjmnzR0HY8kfzIH5+5sUqX5HVx8A2HAMN3ThIKjYVYWWGQr5A5PKm8bhKHD
        TWU4mXkOeOE6eOSAf9KqvKF5EZDh869/hRsxz3pIgPWldoY5sNLH1WYkKekqJosP9I5/DRdn+ZDfJ
        WLHvFfEA==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qluFu-0004wq-8H; Thu, 28 Sep 2023 18:52:50 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Florian Westphal <fw@strlen.de>, netfilter-devel@vger.kernel.org
Subject: [nf PATCH v2 0/8] Introduce locking for reset requests
Date:   Thu, 28 Sep 2023 18:52:36 +0200
Message-ID: <20230928165244.7168-1-phil@nwl.cc>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Next try, this time with:
- commit_mutex instead of dedicated spinlock
- Subroutine creation split into separate patches
- Separate patch adding reset bit to nft_set_dump_ctx
- Improved commit descriptions
- Fixed leak in error path added by patch

Phil Sutter (8):
  netfilter: nf_tables: Don't allocate nft_rule_dump_ctx
  netfilter: nf_tables: Introduce nf_tables_getrule_single()
  netfilter: nf_tables: Add locking for NFT_MSG_GETRULE_RESET requests
  netfilter: nf_tables: Introduce struct nft_obj_dump_ctx
  netfilter: nf_tables: Introduce nf_tables_getobj_single
  netfilter: nf_tables: Add locking for NFT_MSG_GETOBJ_RESET requests
  netfilter: nf_tables: Pass reset bit in nft_set_dump_ctx
  netfilter: nf_tables: Add locking for NFT_MSG_GETSETELEM_RESET
    requests

 net/netfilter/nf_tables_api.c | 546 +++++++++++++++++++++++-----------
 1 file changed, 371 insertions(+), 175 deletions(-)

-- 
2.41.0

