Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66DE17AB561
	for <lists+netfilter-devel@lfdr.de>; Fri, 22 Sep 2023 18:03:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbjIVQDK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 22 Sep 2023 12:03:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230445AbjIVQDJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 22 Sep 2023 12:03:09 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8F5C099;
        Fri, 22 Sep 2023 09:03:02 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, sashal@kernel.org,
        stable@vger.kernel.org
Subject: [PATCH -stable,6.5 0/5] Netfilter stable fixes for 6.5
Date:   Fri, 22 Sep 2023 18:02:51 +0200
Message-Id: <20230922160256.150178-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi Greg, Sasha,

The following list shows patches that you can cherry-pick to -stable 6.5.
I am using original commit IDs for reference:

1) 7ab9d0827af8 ("netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention")

2) 4e5f5b47d8de ("netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC")

3) 1d16d80d4230 ("netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails")

4) 7606622f20da ("netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration")

5) 44a76f08f7ca ("netfilter: nf_tables: fix memleak when more than 255 elements expired")

Please, apply.

Thanks.

Florian Westphal (1):
  netfilter: nf_tables: fix memleak when more than 255 elements expired

Pablo Neira Ayuso (4):
  netfilter: nft_set_rbtree: use read spinlock to avoid datapath contention
  netfilter: nft_set_pipapo: call nft_trans_gc_queue_sync() in catchall GC
  netfilter: nft_set_pipapo: stop GC iteration if GC transaction allocation fails
  netfilter: nft_set_hash: try later when GC hits EAGAIN on iteration

 include/net/netfilter/nf_tables.h |  7 ++++---
 net/netfilter/nf_tables_api.c     | 32 ++++++++++++++++++++++++++-----
 net/netfilter/nft_set_hash.c      | 11 ++++-------
 net/netfilter/nft_set_pipapo.c    |  4 ++--
 net/netfilter/nft_set_rbtree.c    |  8 +++-----
 5 files changed, 40 insertions(+), 22 deletions(-)

-- 
2.30.2

