Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27014266F8
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 May 2019 17:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729896AbfEVPam (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 May 2019 11:30:42 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:42610 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729495AbfEVPal (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 May 2019 11:30:41 -0400
Received: from localhost ([::1]:55700 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hTTCR-0007zb-Tr; Wed, 22 May 2019 17:30:39 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/3] Support intra-transaction rule references
Date:   Wed, 22 May 2019 17:30:32 +0200
Message-Id: <20190522153035.19806-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Just like with iptables, nft allows to add a rule right before or after
another one, identified by that rule's index. And just like with
iptables-nft, that was not possible if the referenced rule was added
within the same transaction.

This series basically copies what has been done for iptables-nft to make
the above possible:

* Insert all new rules into the cache immediately and at the right
  position (which requires a cache populated with existing rules).

* Make use of NFTNL_RULE_ID and NFTNL_RULE_POSITION_ID as a means of
  intra-transaction rule referencing.

* Make sure rule cache stays relevant by taking required action upon
  rule delete or replace commands.

The above forbids future rule handle guesses in user input, which was
possible before. Given that it is a pretty uncertain method anyway,
people shouldn't rely upon it anyway. Also, we might implement support
for 'index' keyword in rule replace/delete commands.

A performance drawback might be the mandatory cache update for simple
rule add commands. This could be avoided by delaying the cache update
until the first command with rule reference and replaying cache contents
from batch at that point but obviously this increases code complexity
quite a bit and is therefore maybe not feasible.

Phil Sutter (3):
  src: Fix cache_flush() in cache_needs_more() logic
  rule: Introduce rule_lookup_by_index()
  src: Support intra-transaction rule references

 include/rule.h                                |   4 +
 src/evaluate.c                                | 116 ++++++++++++------
 src/mnl.c                                     |   4 +
 src/rule.c                                    |  12 ++
 .../shell/testcases/cache/0003_cache_update_0 |   7 ++
 .../shell/testcases/nft-f/0006action_object_0 |   2 +-
 tests/shell/testcases/transactions/0024rule_0 |  14 +++
 .../transactions/dumps/0024rule_0.nft         |   8 ++
 8 files changed, 129 insertions(+), 38 deletions(-)
 create mode 100755 tests/shell/testcases/transactions/0024rule_0
 create mode 100644 tests/shell/testcases/transactions/dumps/0024rule_0.nft

-- 
2.21.0

