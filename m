Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D6BA62950D
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Nov 2022 10:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238135AbiKOJ73 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Nov 2022 04:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiKOJ7Z (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:59:25 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AF1F1FD0E;
        Tue, 15 Nov 2022 01:59:23 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org,
        pabeni@redhat.com, edumazet@google.com
Subject: [PATCH net-next,v2 0/6] Netfilter updates for net-next
Date:   Tue, 15 Nov 2022 10:59:16 +0100
Message-Id: <20221115095922.139954-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

The following patchset contains Netfilter updates for net-next:

1) Fix sparse warning in the new nft_inner expression, reported
   by Jakub Kicinski.

2) Incorrect vlan header check in nft_inner, from Peng Wu.

3) Two patches to pass reset boolean to expression dump operation,
   in preparation for allowing to reset stateful expressions in rules.
   This adds a new NFT_MSG_GETRULE_RESET command. From Phil Sutter.

4) Inconsistent indentation in nft_fib, from Jiapeng Chong.

5) Speed up siphash calculation in conntrack, from Florian Westphal.

This batch includes two fixes for the new inner payload/meta match
coming in the previous nf-next pull request.

Coming in this v2 after Jakub's comments:
- sparse looks now clean after siphash conntrack update.
- no more bisectability breakage in new NFT_MSG_GETRULE_RESET command.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git

Thanks.

----------------------------------------------------------------

The following changes since commit 6f1a298b2e24c703bfcc643e41bc7c0604fe4830:

  Merge branch 'inet-add-drop-monitor-support' (2022-10-31 20:14:30 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git HEAD

for you to fetch changes up to d2c806abcf0b582131e1f93589d628dac0c07bf4:

  netfilter: conntrack: use siphash_4u64 (2022-11-15 10:53:19 +0100)

----------------------------------------------------------------
Florian Westphal (1):
      netfilter: conntrack: use siphash_4u64

Jiapeng Chong (1):
      netfilter: rpfilter/fib: clean up some inconsistent indenting

Pablo Neira Ayuso (1):
      netfilter: nft_payload: use __be16 to store gre version

Peng Wu (1):
      netfilter: nft_inner: fix return value check in nft_inner_parse_l2l3()

Phil Sutter (2):
      netfilter: nf_tables: Extend nft_expr_ops::dump callback parameters
      netfilter: nf_tables: Introduce NFT_MSG_GETRULE_RESET

 include/net/netfilter/nf_tables.h        |  5 ++--
 include/net/netfilter/nft_fib.h          |  2 +-
 include/net/netfilter/nft_meta.h         |  4 +--
 include/net/netfilter/nft_reject.h       |  3 +-
 include/uapi/linux/netfilter/nf_tables.h |  2 ++
 net/ipv4/netfilter/nft_dup_ipv4.c        |  3 +-
 net/ipv4/netfilter/nft_fib_ipv4.c        |  5 ++--
 net/ipv6/netfilter/nft_dup_ipv6.c        |  3 +-
 net/netfilter/nf_conntrack_core.c        | 30 +++++++++----------
 net/netfilter/nf_tables_api.c            | 49 +++++++++++++++++++++-----------
 net/netfilter/nft_bitwise.c              |  6 ++--
 net/netfilter/nft_byteorder.c            |  3 +-
 net/netfilter/nft_cmp.c                  |  9 ++++--
 net/netfilter/nft_compat.c               |  9 ++++--
 net/netfilter/nft_connlimit.c            |  3 +-
 net/netfilter/nft_counter.c              |  5 ++--
 net/netfilter/nft_ct.c                   |  6 ++--
 net/netfilter/nft_dup_netdev.c           |  3 +-
 net/netfilter/nft_dynset.c               |  7 +++--
 net/netfilter/nft_exthdr.c               |  9 ++++--
 net/netfilter/nft_fib.c                  |  2 +-
 net/netfilter/nft_flow_offload.c         |  3 +-
 net/netfilter/nft_fwd_netdev.c           |  6 ++--
 net/netfilter/nft_hash.c                 |  4 +--
 net/netfilter/nft_immediate.c            |  3 +-
 net/netfilter/nft_inner.c                |  7 +++--
 net/netfilter/nft_last.c                 |  3 +-
 net/netfilter/nft_limit.c                |  5 ++--
 net/netfilter/nft_log.c                  |  3 +-
 net/netfilter/nft_lookup.c               |  3 +-
 net/netfilter/nft_masq.c                 |  3 +-
 net/netfilter/nft_meta.c                 |  5 ++--
 net/netfilter/nft_nat.c                  |  3 +-
 net/netfilter/nft_numgen.c               |  6 ++--
 net/netfilter/nft_objref.c               |  6 ++--
 net/netfilter/nft_osf.c                  |  3 +-
 net/netfilter/nft_payload.c              |  9 ++++--
 net/netfilter/nft_queue.c                |  6 ++--
 net/netfilter/nft_quota.c                |  5 ++--
 net/netfilter/nft_range.c                |  3 +-
 net/netfilter/nft_redir.c                |  3 +-
 net/netfilter/nft_reject.c               |  3 +-
 net/netfilter/nft_rt.c                   |  2 +-
 net/netfilter/nft_socket.c               |  2 +-
 net/netfilter/nft_synproxy.c             |  3 +-
 net/netfilter/nft_tproxy.c               |  2 +-
 net/netfilter/nft_tunnel.c               |  2 +-
 net/netfilter/nft_xfrm.c                 |  2 +-
 48 files changed, 168 insertions(+), 105 deletions(-)
