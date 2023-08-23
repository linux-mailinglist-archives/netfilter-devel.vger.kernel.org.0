Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C93D785C0E
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Aug 2023 17:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbjHWP10 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Aug 2023 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237215AbjHWP1Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Aug 2023 11:27:25 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E925CDF;
        Wed, 23 Aug 2023 08:27:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qYplL-0001jJ-UL; Wed, 23 Aug 2023 17:27:15 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netdev@vger.kernel.org>
Cc:     Paolo Abeni <pabeni@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        <netfilter-devel@vger.kernel.org>
Subject: [PATCH net 0/6] netfilter updates for net
Date:   Wed, 23 Aug 2023 17:26:48 +0200
Message-ID: <20230823152711.15279-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hello,

This PR contains nf_tables updates for your *net* tree.

First patch fixes table validation, I broke this in 6.4 when tracking
validation state per table, reported by Pablo, fixup from myself.

Second patch makes sure objects waiting for memory release have been
released, this was broken in 6.1, patch from Pablo Neira Ayuso.

Patch three is a fix-for-fix from previous PR: In case a transaction
gets aborted, gc sequence counter needs to be incremented so pending
gc requests are invalidated, from Pablo.

Same for patch 4: gc list needs to use gc list lock, not destroy lock,
also from Pablo.

Patch 5 fixes a UaF in a set backend, but this should only occur when
failslab is enabled for GFP_KERNEL allocations, broken since feature
was added in 5.6, from myself.

Patch 6 fixes a double-free bug that was also added via previous PR:
We must not schedule gc work if the previous batch is still queued.

The following changes since commit bfedba3b2c7793ce127680bc8f70711e05ec7a17:

  ibmveth: Use dcbf rather than dcbfl (2023-08-23 11:51:16 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/netfilter/nf tags/nf-23-08-23

for you to fetch changes up to 8e51830e29e12670b4c10df070a4ea4c9593e961:

  netfilter: nf_tables: defer gc run if previous batch is still pending (2023-08-23 16:12:59 +0200)

----------------------------------------------------------------
netfilter pull request 2023-08-23

----------------------------------------------------------------
Florian Westphal (3):
      netfilter: nf_tables: validate all pending tables
      netfilter: nf_tables: fix out of memory error handling
      netfilter: nf_tables: defer gc run if previous batch is still pending

Pablo Neira Ayuso (3):
      netfilter: nf_tables: flush pending destroy work before netlink notifier
      netfilter: nf_tables: GC transaction race with abort path
      netfilter: nf_tables: use correct lock to protect gc_list

 include/net/netfilter/nf_tables.h |  6 ++++++
 net/netfilter/nf_tables_api.c     | 23 +++++++++++++++--------
 net/netfilter/nft_set_hash.c      |  3 +++
 net/netfilter/nft_set_pipapo.c    | 13 ++++++++++---
 net/netfilter/nft_set_rbtree.c    |  3 +++
 5 files changed, 37 insertions(+), 11 deletions(-)
