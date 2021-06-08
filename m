Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B12539F588
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 13:48:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232063AbhFHLuT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231872AbhFHLuT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 07:50:19 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64722C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 04:48:26 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lqaDY-0000oE-AC; Tue, 08 Jun 2021 13:48:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] netfilter: nft_fib: ignore icmpv6 packets from ::
Date:   Tue,  8 Jun 2021 13:48:16 +0200
Message-Id: <20210608114818.23397-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Quoting nf bugzilla:
--------
Using the following for
reverse path filtering breaks IPv6 duplicate address detection:

table inet ip46_firewall {
    chain ip46_rpfilter {
        type filter hook prerouting priority raw;
        fib saddr . iif oif missing log prefix "RPFILTER: " drop
    }
}

This is because packets from :: to ff02::1:ff00/104 will be dropped and thus
other hosts on the network cannot detect that this host already has the same
address assigned. The problem can be worked around in nft rules by handling
such packets specially but I guess it should work as is.

In the kernel in ip6t_rpfilter.c the function rpfilter_mt() checks for
saddrtype == IPV6_ADDR_ANY. nft_fib_ipv6.c doesn't seem to have an equivalent
check for this special case.
--------

First patch adds a test case for this, second patch makes icmpv6 from
any to link-local bypass the fib lookup, just like loopback packets.

Florian Westphal (2):
  selftests: netfilter: add fib test case
  netfilter: ipv6: skip ipv6 packets from any to link-local

 net/ipv6/netfilter/nft_fib_ipv6.c            |  22 +-
 tools/testing/selftests/netfilter/Makefile   |   2 +-
 tools/testing/selftests/netfilter/nft_fib.sh | 221 +++++++++++++++++++
 3 files changed, 240 insertions(+), 5 deletions(-)
 create mode 100755 tools/testing/selftests/netfilter/nft_fib.sh

-- 
2.31.1

