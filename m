Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9117C8DC
	for <lists+netfilter-devel@lfdr.de>; Wed, 31 Jul 2019 18:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfGaQja (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 31 Jul 2019 12:39:30 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40904 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726231AbfGaQja (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 31 Jul 2019 12:39:30 -0400
Received: from localhost ([::1]:53994 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hsrdR-0005jC-5d; Wed, 31 Jul 2019 18:39:29 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/5] xtables-monitor enhancements
Date:   Wed, 31 Jul 2019 18:39:10 +0200
Message-Id: <20190731163915.22232-1-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series introduces family-specific xtables-monitor aliases as
suggested during NFWS, the relevant code is in patches four and five.

The first three patches are fallout from the above, mostly minor fixes
found along the way.

Phil Sutter (5):
  doc: Clean generated *-restore-translate man pages
  doc: Fix xtables-monitor man page
  xtables-monitor: Improve error messages
  xtables-monitor: Support ARP and bridge families
  xtables-monitor: Add family-specific aliases

 iptables/Makefile.am          |  21 ++++--
 iptables/xtables-monitor.8.in |  32 +++++++--
 iptables/xtables-monitor.c    | 124 ++++++++++++++++++++++++++++------
 iptables/xtables-multi.h      |   4 ++
 iptables/xtables-nft-multi.c  |   4 ++
 5 files changed, 154 insertions(+), 31 deletions(-)

-- 
2.22.0

