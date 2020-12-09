Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF42D4845
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Dec 2020 18:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgLIRuQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Dec 2020 12:50:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727894AbgLIRuK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Dec 2020 12:50:10 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A19BC0613CF
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Dec 2020 09:49:30 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1kn3aj-0004QU-1t; Wed, 09 Dec 2020 18:49:29 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft 0/10] nft: add automatic icmp/icmpv6 dependencies
Date:   Wed,  9 Dec 2020 18:49:14 +0100
Message-Id: <20201209174924.27720-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

icmp and icmpv6 protocol header are special, they have overlapping
fields whose interpretation (or existence) depends on the icmp type.

This series allows nft to automatically add the dependency so that
the type-dependant field is not evaluated for any type.

Support for dependency removal is also added, but not for id/sequence.
Those need to check for both echo and echo reply, we'd have to extend
the delinearization step to also check relational expressions with
a non-constant RHS.

For now, the test cases are amended to expect the depenency, i.e.
'icmp id 42' will expect 'icmp type {echo-reply, echo-request} icmp id 42'
as the output.

Also add test cases to cover both id/sequence in same rule (payload
merging is used for those) and add a test with a rule that already
contains a type match.

Florian Westphal (10):
  exthdr: remove unused proto_key member from struct
  proto: reduce size of proto_desc structure
  src: add auto-dependencies for ipv4 icmp
  tests: fix exepcted payload of icmp expressions
  src: add auto-dependencies for ipv6 icmp6
  tests: fix exepcted payload of icmpv6 expressions
  payload: auto-remove simple icmp/icmpv6 dependency expressions
  tests: icmp, icmpv6: avoid remaining warnings
  tests: ip: add one test case to cover both id and sequence
  tests: icmp, icmpv6: check we don't add second dependency

 include/exthdr.h                  |   1 -
 include/payload.h                 |   7 +-
 include/proto.h                   |  34 +++--
 src/evaluate.c                    |  20 ++-
 src/exthdr.c                      |   4 -
 src/netlink_delinearize.c         |   3 +
 src/parser_bison.y                |   1 -
 src/payload.c                     | 210 +++++++++++++++++++++++++++++-
 src/proto.c                       |  45 ++++---
 tests/py/ip/icmp.t                |  38 +++---
 tests/py/ip/icmp.t.payload.ip     | 155 +++++++++++++++++++++-
 tests/py/ip6/icmpv6.t             |  42 +++---
 tests/py/ip6/icmpv6.t.payload.ip6 | 116 +++++++++++++++--
 13 files changed, 588 insertions(+), 88 deletions(-)

-- 
2.26.2

