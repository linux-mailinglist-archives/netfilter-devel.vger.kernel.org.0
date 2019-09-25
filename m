Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0802BE725
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfIYV2Q (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:28:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45920 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV2Q (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:28:16 -0400
Received: from localhost ([::1]:59010 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEpa-0005JR-VV; Wed, 25 Sep 2019 23:28:15 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 00/24] Improve iptables-nft performance with large rulesets
Date:   Wed, 25 Sep 2019 23:25:41 +0200
Message-Id: <20190925212605.1005-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a second approach at improving performance by reduced caching.
In comparison to v1, it is much less complex, at least when having the
general concept in mind:

There are three caching strategies:

1) No cache
2) Minimal cache
3) Full cache

(1) and (3) are relevant only for xtables-restore: Either we flush and
therefore don't need a cache (apart from the list of tables due to the
conditional table deletion logic) or we don't flush and can't know how
much caching is needed in input - the only feasible solution is to just
give in and fetch the full ruleset from kernel.

Assuming xtables-restore input is known, it can be checked for
problematic commands, namely those requiring a rule cache. This is
because otherwise, (2) applies, so cache only what's needed to do the
job. A simple '-A' merely requires knowledge whether table and chain
exist. Other rules in that chain are not interesting. Yet if followed by
e.g. '-L', rule cache needs to have been present before, otherwise the
appended rule might end in the wrong place in cache.

If xtables-restore is called with --noflush and all input is known and
unproblematic, it is treated like repeated calls to xtables, where (2)
applies. Minimal caching means to fetch from kernel only what is needed
in the given situation:

- nftnl_table_list_get() needs just the list of tables,
- nftnl_chain_list_get() needs just the list of chains in given table.

In most cases, nftnl_chain_list_get() is called just to find a specific
chain. By allowing to pass this chain name to the function, code can be
further optimized to just fetch that specific chain from kernel, place
it into the table's chain list and return the list. Calling code needs
no further adjustment, it will just operate on the returned chain list.

In fact, the above is beneficial for iptables: Many commands support
operation on all chains ('-F') or on a specific one ('-F INPUT'). The
corresponding function nft_rule_flush() is called with either a chain
name or NULL as parameter. Passed on to nftnl_chain_list_get() makes it
transparently return just what is needed.

The only thing to be cautious about with these partial cache situations
is to avoid duplicate cache entries:
- fetch_table_cache() is called only if h->cache->tables is not set,
  i.e. no table list exists yet (unless the call comes from a function
  which is called just once anyway).
- In nftnl_chain_list_cb() the retrieved chain from kernel is added to
  cache only if it doesn't exist there yet.
- nft_rule_list_update() does nothing if given chain's rule list is not
  empty. If it is, fetching won't cause duplicates.

Patches 1-4 are more or less fallout and unrelated to caching rework.

Patches 5-15 implement the requirements to minimize caches and change
users accordingly.

Patches 16-23 prepare xtables-restore for input buffering.

Patch 24 implements buffering input in xtables-restore when called with
--noflush for cache requirements prediction. The checker is a bit
sloppy, but it covers a typical use-case of quickly appending/prepending
a bunch of rules to an existing ruleset.

Phil Sutter (24):
  xtables_error() does not return
  tests/shell: Speed up ipt-restore/0004-restore-race_0
  tests: shell: Support running for legacy/nft only
  nft: Fix for add and delete of same rule in single batch
  nft: Make nftnl_table_list_get() fetch only tables
  xtables-restore: Minimize caching when flushing
  nft: Support fetch_rule_cache() per chain
  nft: Fetch only chains in nft_chain_list_get()
  nft: Support fetch_chain_cache() per table
  nft: Support fetch_chain_cache() per chain
  nft: Support nft_chain_list_get() per chain
  nft: Reduce cache overhead of adding a custom chain
  nft: Reduce cache overhead of nft_chain_builtin_init()
  nft: Support nft_is_table_compatible() per chain
  nft: Optimize flushing all chains of a table
  xtables-restore: Introduce rule counter tokenizer function
  xtables-restore: Carry in_table in struct nft_xt_restore_parse
  xtables-restore: Use xt_params->program_name
  xtables-restore: Carry curtable in struct nft_xt_restore_parse
  xtables-restore: Introduce line parsing function
  tests: shell: Add ipt-restore/0007-flush-noflush_0
  xtables-restore: Remove some pointless linebreaks
  xtables-restore: Allow lines without trailing newline character
  xtables-restore: Improve performance of --noflush operation

 iptables/iptables-restore.c                   |  53 +-
 iptables/iptables-xml.c                       |  53 +-
 iptables/nft-shared.h                         |   5 +-
 iptables/nft.c                                | 255 +++++++---
 iptables/nft.h                                |   9 +-
 iptables/tests/shell/run-tests.sh             |  28 +-
 .../ipt-restore/0003-restore-ordering_0       |  18 +-
 .../testcases/ipt-restore/0004-restore-race_0 |   4 +-
 .../ipt-restore/0007-flush-noflush_0          |  42 ++
 .../ipt-restore/0008-restore-counters_0       |  22 +
 iptables/xshared.c                            |  43 +-
 iptables/xshared.h                            |   1 +
 iptables/xtables-restore.c                    | 451 ++++++++++--------
 iptables/xtables-save.c                       |   4 +-
 iptables/xtables-translate.c                  |   2 +-
 15 files changed, 611 insertions(+), 379 deletions(-)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0007-flush-noflush_0
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0008-restore-counters_0

-- 
2.23.0

