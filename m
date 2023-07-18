Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04137575BC
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Jul 2023 09:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjGRHxF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Jul 2023 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231833AbjGRHxD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Jul 2023 03:53:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEEA8E;
        Tue, 18 Jul 2023 00:53:01 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qLfVo-0005d0-Qm; Tue, 18 Jul 2023 09:52:48 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: nf_tables: use NLA_POLICY_MASK instead of manual checks
Date:   Tue, 18 Jul 2023 09:52:28 +0200
Message-ID: <20230718075234.3863-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_tables still uses manual attribute validation in multiple places.
Make NLA_POLICY_MASK available with NLA_BE16/NLA_BE32 and then start
using it for flag attribute validation.

Florian Westphal (2):
  netlink: allow be16 and be32 types in all uint policy checks
  netfilter: nf_tables: use NLA_POLICY_MASK to test for valid flag
    options

 include/net/netlink.h      | 10 +++-------
 lib/nlattr.c               |  6 ++++++
 net/netfilter/nft_fib.c    | 13 +++++++------
 net/netfilter/nft_lookup.c |  6 ++----
 net/netfilter/nft_masq.c   |  8 +++-----
 net/netfilter/nft_nat.c    |  8 +++-----
 net/netfilter/nft_redir.c  |  8 +++-----
 7 files changed, 27 insertions(+), 32 deletions(-)

-- 
2.41.0

