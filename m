Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 034B03E2D44
	for <lists+netfilter-devel@lfdr.de>; Fri,  6 Aug 2021 17:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhHFPMO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 6 Aug 2021 11:12:14 -0400
Received: from mail.netfilter.org ([217.70.188.207]:33770 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231865AbhHFPMN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 6 Aug 2021 11:12:13 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id F08706003B;
        Fri,  6 Aug 2021 17:11:17 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net 0/9,v2] Netfilter fixes for net
Date:   Fri,  6 Aug 2021 17:11:40 +0200
Message-Id: <20210806151149.6356-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi,

The following patchset contains Netfilter fixes for net:

1) Restrict range element expansion in ipset to avoid soft lockup,
   from Jozsef Kadlecsik.

2) Memleak in error path for nf_conntrack_bridge for IPv4 packets,
   from Yajun Deng.

3) Simplify conntrack garbage collection strategy to avoid frequent
   wake-ups, from Florian Westphal.

4) Fix NFNLA_HOOK_FUNCTION_NAME string, do not include module name.

5) Missing chain family netlink attribute in chain description
   in nfnetlink_hook.

6) Incorrect sequence number on nfnetlink_hook dumps.

7) Use netlink request family in reply message for consistency.

8) Remove offload_pickup sysctl, use conntrack for established state
   instead, from Florian Westphal.

9) Translate NFPROTO_INET/ingress to NFPROTO_NETDEV/ingress, since
   NFPROTO_INET is not exposed through nfnetlink_hook.

Please, pull these changes from:

  git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git

v2: This batch includes the missing rcu_read_unlock() for patch 3/9.

Thanks!

----------------------------------------------------------------

The following changes since commit c7d102232649226a69dddd58a4942cf13cff4f7c:

  Merge tag 'net-5.14-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2021-07-30 16:01:36 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pablo/nf.git HEAD

for you to fetch changes up to 269fc69533de73a9065c0b7971bcd109880290b3:

  netfilter: nfnetlink_hook: translate inet ingress to netdev (2021-08-06 17:07:41 +0200)

----------------------------------------------------------------
Florian Westphal (2):
      netfilter: conntrack: collect all entries in one cycle
      netfilter: conntrack: remove offload_pickup sysctl again

Jozsef Kadlecsik (1):
      netfilter: ipset: Limit the maximal range of consecutive elements to add/delete

Pablo Neira Ayuso (5):
      netfilter: nfnetlink_hook: strip off module name from hookfn
      netfilter: nfnetlink_hook: missing chain family
      netfilter: nfnetlink_hook: use the sequence number of the request message
      netfilter: nfnetlink_hook: Use same family as request message
      netfilter: nfnetlink_hook: translate inet ingress to netdev

Yajun Deng (1):
      netfilter: nf_conntrack_bridge: Fix memory leak when error

 Documentation/networking/nf_conntrack-sysctl.rst | 10 ----
 include/linux/netfilter/ipset/ip_set.h           |  3 +
 include/net/netns/conntrack.h                    |  2 -
 include/uapi/linux/netfilter/nfnetlink_hook.h    |  9 +++
 net/bridge/netfilter/nf_conntrack_bridge.c       |  6 ++
 net/netfilter/ipset/ip_set_hash_ip.c             |  9 ++-
 net/netfilter/ipset/ip_set_hash_ipmark.c         | 10 +++-
 net/netfilter/ipset/ip_set_hash_ipport.c         |  3 +
 net/netfilter/ipset/ip_set_hash_ipportip.c       |  3 +
 net/netfilter/ipset/ip_set_hash_ipportnet.c      |  3 +
 net/netfilter/ipset/ip_set_hash_net.c            | 11 +++-
 net/netfilter/ipset/ip_set_hash_netiface.c       | 10 +++-
 net/netfilter/ipset/ip_set_hash_netnet.c         | 16 +++++-
 net/netfilter/ipset/ip_set_hash_netport.c        | 11 +++-
 net/netfilter/ipset/ip_set_hash_netportnet.c     | 16 +++++-
 net/netfilter/nf_conntrack_core.c                | 71 ++++++++----------------
 net/netfilter/nf_conntrack_proto_tcp.c           |  1 -
 net/netfilter/nf_conntrack_proto_udp.c           |  1 -
 net/netfilter/nf_conntrack_standalone.c          | 16 ------
 net/netfilter/nf_flow_table_core.c               | 11 +++-
 net/netfilter/nfnetlink_hook.c                   | 24 ++++++--
 21 files changed, 151 insertions(+), 95 deletions(-)
