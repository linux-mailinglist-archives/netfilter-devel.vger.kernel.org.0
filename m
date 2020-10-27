Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD6B29BEE9
	for <lists+netfilter-devel@lfdr.de>; Tue, 27 Oct 2020 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1814505AbgJ0Q4m (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 27 Oct 2020 12:56:42 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:60422 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1814359AbgJ0Q4F (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 27 Oct 2020 12:56:05 -0400
Received: from localhost ([::1]:58280 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kXSGR-00028j-PJ; Tue, 27 Oct 2020 17:56:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/2] src: Optimize prefix matches on byte-boundaries
Date:   Tue, 27 Oct 2020 17:56:00 +0100
Message-Id: <20201027165602.26630-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This mini-series optimizes prefix matches to skip the "bitwise"
expression if they are byte-bound. We can simply reduce "cmp" expression
length to achieve the same effect.

The first patch adds support for delinearization, this enables correct
display of the IP address prefix matches added by iptables-nft with my
(not yet accepted) patch applied.

The second patch enables nft to create such bytecode itself.

Phil Sutter (2):
  src: Support odd-sized payload matches
  src: Optimize prefix matches on byte-boundaries

 src/netlink_delinearize.c       | 11 +++++++++--
 src/netlink_linearize.c         |  4 +++-
 src/payload.c                   |  5 +++++
 tests/py/ip/ct.t.payload        |  4 ----
 tests/py/ip/ip.t.payload        |  6 ++----
 tests/py/ip/ip.t.payload.bridge |  6 ++----
 tests/py/ip/ip.t.payload.inet   |  6 ++----
 tests/py/ip/ip.t.payload.netdev |  6 ++----
 tests/py/ip6/ip6.t.payload.inet |  5 ++---
 tests/py/ip6/ip6.t.payload.ip6  |  5 ++---
 10 files changed, 29 insertions(+), 29 deletions(-)

-- 
2.28.0

