Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 505B5FD9AF
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 10:47:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfKOJrX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 04:47:23 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:54722 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725829AbfKOJrX (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 04:47:23 -0500
Received: from localhost ([::1]:39580 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iVYCI-0008Dr-A0; Fri, 15 Nov 2019 10:47:22 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/2] Restore rule counter zeroing
Date:   Fri, 15 Nov 2019 10:47:23 +0100
Message-Id: <20191115094725.19756-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Zeroing rule counters was broken in two ways: On one hand, cache
optimizations went a little too far (actually I missed that rule cache
is required for CMD_ZERO). On the other, rule replace logic was
insufficient with regards to NFTA_RULE_COMPAT attribute (elaborate
details in second patch).

Phil Sutter (2):
  nft: CMD_ZERO needs a rule cache
  nft: Fix -Z for rules with NFTA_RULE_COMPAT

 iptables/nft.c             | 41 ++++++++++++++++++++++++++++++++++++++
 iptables/xtables-restore.c |  1 +
 2 files changed, 42 insertions(+)

-- 
2.24.0

