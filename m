Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2C1D754D
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 13:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729151AbfJOLm3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 07:42:29 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36592 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726472AbfJOLm2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 07:42:28 -0400
Received: from localhost ([::1]:49682 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKLDf-0000zy-Ai; Tue, 15 Oct 2019 13:42:27 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v4 0/8] Improve iptables-nft performance with large rulesets
Date:   Tue, 15 Oct 2019 13:41:44 +0200
Message-Id: <20191015114152.25254-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fourth try at caching optimizations implementation.

Changes since v3:

* Rebase onto current master after pushing the accepted initial three
  patches.
* Avoid cache inconsistency in __nft_build_cache() if kernel ruleset
  changed since last call.

Phil Sutter (8):
  nft-cache: Introduce cache levels
  nft-cache: Fetch only chains in nft_chain_list_get()
  nft-cache: Cover for multiple fetcher invocation
  nft-cache: Support partial cache per table
  nft-cache: Support partial rule cache per chain
  nft: Reduce cache overhead of nft_chain_builtin_init()
  nft: Support nft_is_table_compatible() per chain
  nft: Optimize flushing all chains of a table

 iptables/nft-cache.c       | 203 ++++++++++++++++++++++++++++++-------
 iptables/nft-cache.h       |   9 +-
 iptables/nft.c             | 108 +++++++++++++-------
 iptables/nft.h             |  14 ++-
 iptables/xtables-restore.c |   4 +-
 iptables/xtables-save.c    |   4 +-
 6 files changed, 259 insertions(+), 83 deletions(-)

-- 
2.23.0

