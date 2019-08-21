Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D0A2797619
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Aug 2019 11:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfHUJ0f (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Aug 2019 05:26:35 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:43766 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727307AbfHUJ0f (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Aug 2019 05:26:35 -0400
Received: from localhost ([::1]:56856 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1i0Mt0-000553-0q; Wed, 21 Aug 2019 11:26:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 00/14] Implement among match support
Date:   Wed, 21 Aug 2019 11:25:48 +0200
Message-Id: <20190821092602.16292-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series ultimately adds among match support to ebtables-nft. This
implementation merely shares the user interface with legacy one,
internally the code is distinct: libebt_among.c does not make use of the
wormhash data structure but a much simpler one for "temporary" storage
of data until being converted into an anonymous set and associated
lookup expression.

Patches 1 to 4 are basically unrelated fallout with misc fixes or minor
code improvements.

Patches 5 and 6 add core infrastructure to cache existing sets and
create new ones.

Patches 7 to 10 deal with the need for nft_handle access in all places
converting extension to expression and vice-versa, split to improve
readability as far as possible.

The remaining patches add some more (glue-) code and finally the actual
among match implementation.

Phil Sutter (14):
  nft: Fix typo in nft_parse_limit() error message
  nft: Get rid of NFT_COMPAT_EXPR_MAX define
  nft: Keep nft_handle pointer in nft_xt_ctx
  nft: Eliminate pointless calls to nft_family_ops_lookup()
  nft: Fetch sets when updating rule cache
  nft: Support NFT_COMPAT_SET_ADD
  nft: family_ops: Pass nft_handle to 'add' callback
  nft: family_ops: Pass nft_handle to 'rule_find' callback
  nft: family_ops: Pass nft_handle to 'print_rule' callback
  nft: family_ops: Pass nft_handle to 'rule_to_cs' callback
  nft: Bore up nft_parse_payload()
  nft: Embed rule's table name in nft_xt_ctx
  nft: Support parsing lookup expression
  nft: bridge: Rudimental among extension support

 extensions/libebt_among.c  | 278 ++++++++++++++++++++++++++
 extensions/libebt_among.t  |  16 ++
 iptables/ebtables-nft.8    |  66 ++++---
 iptables/nft-arp.c         |  14 +-
 iptables/nft-bridge.c      | 260 ++++++++++++++++++++++++-
 iptables/nft-bridge.h      |  21 ++
 iptables/nft-ipv4.c        |  10 +-
 iptables/nft-ipv6.c        |  10 +-
 iptables/nft-shared.c      |  72 +++----
 iptables/nft-shared.h      |  26 ++-
 iptables/nft.c             | 390 ++++++++++++++++++++++++++++++++-----
 iptables/nft.h             |  13 +-
 iptables/xtables-eb.c      |   1 +
 iptables/xtables-monitor.c |  17 +-
 iptables/xtables-save.c    |   3 +
 15 files changed, 1039 insertions(+), 158 deletions(-)
 create mode 100644 extensions/libebt_among.c
 create mode 100644 extensions/libebt_among.t

-- 
2.22.0

