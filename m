Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB0F718916
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 13:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbfEILgC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 07:36:02 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35038 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEILgB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 07:36:01 -0400
Received: from localhost ([::1]:48128 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hOhLD-0000cW-PO; Thu, 09 May 2019 13:36:00 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 0/9] Testsuite-indicated fixes for JSON
Date:   Thu,  9 May 2019 13:35:36 +0200
Message-Id: <20190509113545.4017-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Running tests/py/nft-test.py with -j flag and trying to eliminate
errors/warnings resulted in the following series of fixes. They are
about half and half changes to code and test cases.

Phil Sutter (9):
  json: Support nat in inet family
  parser_json: Fix igmp support
  netlink: Fix printing of zero-length prefixes
  tests/py: Fix JSON equivalents of osf tests
  json: Fix tproxy support regarding latest changes
  parser_json: Fix ct timeout object support
  tests/py: Fix for ip dscp symbol "le"
  tests/py: Fix JSON expexted output after expr merge change
  tests/py: Fix JSON expected output for icmpv6 code values

 doc/libnftables-json.adoc         |   5 +
 src/json.c                        |  31 +--
 src/netlink_delinearize.c         |   4 +-
 src/parser_json.c                 |  26 ++-
 tests/py/inet/dnat.t.json         | 166 +++++++++++++++
 tests/py/inet/osf.t.json          |  59 +++++-
 tests/py/inet/snat.t.json         | 131 ++++++++++++
 tests/py/inet/tcp.t.json.output   |  44 +---
 tests/py/inet/tproxy.t            |   2 +-
 tests/py/inet/tproxy.t.json       |  80 ++++++++
 tests/py/inet/tproxy.t.payload    |   2 +-
 tests/py/ip/igmp.t.json           | 323 ++++++++++++++++++++++++++++++
 tests/py/ip/ip.t                  |   2 +-
 tests/py/ip/ip.t.json             |   2 +-
 tests/py/ip/ip.t.payload          |   4 +-
 tests/py/ip/tproxy.t              |   2 +-
 tests/py/ip/tproxy.t.json         |  26 ++-
 tests/py/ip/tproxy.t.json.output  |  61 ++++++
 tests/py/ip6/icmpv6.t.json.output |  59 ++++++
 tests/py/ip6/ip6.t                |   2 +-
 tests/py/ip6/ip6.t.json           |   2 +-
 tests/py/ip6/ip6.t.payload.inet   |   4 +-
 tests/py/ip6/ip6.t.payload.ip6    |   4 +-
 tests/py/ip6/tproxy.t             |   2 +-
 tests/py/ip6/tproxy.t.json        |  26 ++-
 tests/py/ip6/tproxy.t.json.output |  60 ++++++
 26 files changed, 1041 insertions(+), 88 deletions(-)
 create mode 100644 tests/py/inet/dnat.t.json
 create mode 100644 tests/py/inet/snat.t.json
 create mode 100644 tests/py/ip/igmp.t.json
 create mode 100644 tests/py/ip/tproxy.t.json.output
 create mode 100644 tests/py/ip6/tproxy.t.json.output

-- 
2.21.0

