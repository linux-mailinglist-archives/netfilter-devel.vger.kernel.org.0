Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB21B3688F1
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Apr 2021 00:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236660AbhDVWRy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Apr 2021 18:17:54 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45290 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232844AbhDVWRx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Apr 2021 18:17:53 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 36F5C6308B
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Apr 2021 00:16:44 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next 0/5] nfnetlink housekeeping
Date:   Fri, 23 Apr 2021 00:17:07 +0200
Message-Id: <20210422221712.399156-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

This patchset contains updates for the nfnetlink infrastructure
and its users.

1) Add nft_pernet() helper to obtain the nftables pernet area.

2) Add the nfnl_info structure to reduce the footprint of the
   nfnetlink callbacks. Update the rcu, mutex and batch callbacks
   to use it.

3) Add a callback type field to consolidate the nfnetlink subsystem
   callbacks.

Whenever possible, I have applied reverse xmas tree to variable
definitions.

Pablo Neira Ayuso (5):
  netfilter: nftables: add nft_pernet() helper function
  netfilter: nfnetlink: add struct nfnl_info and pass it to callbacks
  netfilter: nfnetlink: pass struct nfnl_info to rcu callbacks
  netfilter: nfnetlink: pass struct nfnl_info to batch callbacks
  netfilter: nfnetlink: consolidate callback types

 include/linux/netfilter/nfnetlink.h  |  33 +-
 include/net/netfilter/nf_tables.h    |   8 +
 net/netfilter/ipset/ip_set_core.c    | 165 ++++---
 net/netfilter/nf_conntrack_netlink.c | 302 ++++++------
 net/netfilter/nf_tables_api.c        | 663 ++++++++++++++-------------
 net/netfilter/nf_tables_offload.c    |  10 +-
 net/netfilter/nfnetlink.c            |  58 ++-
 net/netfilter/nfnetlink_acct.c       |  80 ++--
 net/netfilter/nfnetlink_cthelper.c   |  57 +--
 net/netfilter/nfnetlink_cttimeout.c  | 146 +++---
 net/netfilter/nfnetlink_log.c        |  42 +-
 net/netfilter/nfnetlink_osf.c        |  21 +-
 net/netfilter/nfnetlink_queue.c      |  84 ++--
 net/netfilter/nft_chain_filter.c     |   5 +-
 net/netfilter/nft_compat.c           |  32 +-
 net/netfilter/nft_dynset.c           |   5 +-
 16 files changed, 898 insertions(+), 813 deletions(-)

-- 
2.30.2

