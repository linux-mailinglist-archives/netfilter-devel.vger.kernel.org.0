Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC2E3658D9
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Apr 2021 14:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhDTMZr (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Apr 2021 08:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbhDTMZr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Apr 2021 08:25:47 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72F01C06174A
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Apr 2021 05:25:15 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lYpRK-0008Dn-4X; Tue, 20 Apr 2021 14:25:14 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 00/12] netfilter: remove xtables pointers from struct net
Date:   Tue, 20 Apr 2021 14:24:55 +0200
Message-Id: <20210420122507.505-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This change removes all xt_table pointers from struct net.

The various ip(6)table_foo incarnations are updated to expect
that the table is passed as 'void *priv' argument that netfilter core
passes to the hook functions.

This reduces the struct net size by 2 cachelines on x86_64.

Florian Westphal (12):
  netfilter: ebtables: remove the 3 ebtables pointers from struct net
  netfilter: x_tables: remove ipt_unregister_table
  netfilter: add xt_find_table
  netfilter: iptables: unregister the tables by name
  netfilter: ip6tables: unregister the tables by name
  netfilter: arptables: unregister the tables by name
  netfilter: x_tables: remove paranoia tests
  netfilter: xt_nat: pass table to hookfn
  netfilter: ip_tables: pass table pointer via nf_hook_ops
  netfilter: arp_tables: pass table pointer via nf_hook_ops
  netfilter: ip6_tables: pass table pointer via nf_hook_ops
  netfilter: remove all xt_table anchors from struct net

 include/linux/netfilter/x_tables.h        |  4 ++
 include/linux/netfilter_arp/arp_tables.h  |  6 +-
 include/linux/netfilter_bridge/ebtables.h |  9 ++-
 include/linux/netfilter_ipv4/ip_tables.h  |  9 +--
 include/linux/netfilter_ipv6/ip6_tables.h |  9 +--
 include/net/netns/ipv4.h                  | 10 ----
 include/net/netns/ipv6.h                  |  9 ---
 include/net/netns/x_tables.h              |  8 ---
 net/bridge/netfilter/ebtable_broute.c     | 10 ++--
 net/bridge/netfilter/ebtable_filter.c     | 26 +++------
 net/bridge/netfilter/ebtable_nat.c        | 27 +++------
 net/bridge/netfilter/ebtables.c           | 42 ++++++++++----
 net/ipv4/netfilter/arp_tables.c           | 57 +++++++++++++------
 net/ipv4/netfilter/arptable_filter.c      | 17 ++----
 net/ipv4/netfilter/ip_tables.c            | 69 +++++++++++++++--------
 net/ipv4/netfilter/iptable_filter.c       | 17 ++----
 net/ipv4/netfilter/iptable_mangle.c       | 23 +++-----
 net/ipv4/netfilter/iptable_nat.c          | 59 ++++++++++++-------
 net/ipv4/netfilter/iptable_raw.c          | 17 ++----
 net/ipv4/netfilter/iptable_security.c     | 17 ++----
 net/ipv6/netfilter/ip6_tables.c           | 68 +++++++++++++---------
 net/ipv6/netfilter/ip6table_filter.c      | 17 ++----
 net/ipv6/netfilter/ip6table_mangle.c      | 24 +++-----
 net/ipv6/netfilter/ip6table_nat.c         | 58 +++++++++++++------
 net/ipv6/netfilter/ip6table_raw.c         | 17 ++----
 net/ipv6/netfilter/ip6table_security.c    | 17 ++----
 net/netfilter/x_tables.c                  | 18 ++++++
 27 files changed, 334 insertions(+), 330 deletions(-)

-- 
2.26.3

