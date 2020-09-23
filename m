Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F19275EBF
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Sep 2020 19:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgIWRhM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Sep 2020 13:37:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbgIWRhM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Sep 2020 13:37:12 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABCAC0613CE
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Sep 2020 10:37:11 -0700 (PDT)
Received: from localhost ([::1]:54118 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kL8ha-0003pc-HB; Wed, 23 Sep 2020 19:37:10 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 00/10] nft: Sorted chain listing et al.
Date:   Wed, 23 Sep 2020 19:48:39 +0200
Message-Id: <20200923174849.5773-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is a respin of my original series after getting rid of a few
initial ("fallout") patches. It implements structs nft_chain and
nft_chain_list to avoid changes to libnftnl as requested. Obviously this
introduces some code duplication as some bits from libnftnl have to be
replicated within iptables now.

Phil Sutter (10):
  nft: Fix selective chain compatibility checks
  nft: Implement nft_chain_foreach()
  nft: cache: Introduce nft_cache_add_chain()
  nft: Eliminate nft_chain_list_get()
  nft: cache: Move nft_chain_find() over
  nft: Introduce struct nft_chain
  nft: Introduce a dedicated base chain array
  nft: cache: Sort custom chains by name
  tests: shell: Drop any dump sorting in place
  nft: Avoid pointless table/chain creation

 iptables/Makefile.am                          |   2 +-
 iptables/nft-cache.c                          | 165 +++++---
 iptables/nft-cache.h                          |  11 +-
 iptables/nft-chain.c                          |  59 +++
 iptables/nft-chain.h                          |  87 ++++
 iptables/nft.c                                | 382 ++++++++++--------
 iptables/nft.h                                |  10 +-
 .../ebtables/0002-ebtables-save-restore_0     |   2 +-
 .../firewalld-restore/0001-firewalld_0        |  17 +-
 .../ipt-restore/0007-flush-noflush_0          |   4 +-
 .../ipt-restore/0014-verbose-restore_0        |   2 +-
 iptables/xtables-save.c                       |   8 +-
 12 files changed, 494 insertions(+), 255 deletions(-)
 create mode 100644 iptables/nft-chain.c
 create mode 100644 iptables/nft-chain.h

-- 
2.28.0

