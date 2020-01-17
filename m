Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06EF6141284
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 Jan 2020 21:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729782AbgAQU6K (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 Jan 2020 15:58:10 -0500
Received: from kadath.azazel.net ([81.187.231.250]:55984 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729748AbgAQU6K (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 Jan 2020 15:58:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=JTm5Lf/J3ahxrs4icqkZvjgsaxZwvxEvlGnWkVsYafU=; b=akS20yCGGIu6wpr65VFcWP56WU
        AdUYJ/j1Et/dHWBzmy/P5fZS/7xQ6sYpJRsnG16rCtSiduaDBUQo3lS8eFTi/Li4P9QYO9nTVEkcF
        velWi/UQ8KaDpwozvBuST5hfwFPk9L7U735v0czzF9twBkgiSdndey4kmRNaS9e2YfdTxXy7C0r1h
        Hw0E/VBDZ7XbWzFDqrBi91FlbXXyMoQGlbYAHrBg3Gk+PCRHj188QDsMsdIREdqKyK0cSRI+G3oD6
        JX3ghD+Osg/c29uPSoXOvx3Mi97w/5hZoWpJ6ZXCVmSm8vF4rOse70HnkF9z1sIIM4MRYPHRWfBQt
        kGtPnzfw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1isYgy-0004I2-Fi
        for netfilter-devel@vger.kernel.org; Fri, 17 Jan 2020 20:58:08 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH libnftnl v2 0/6] bitwise shift support
Date:   Fri, 17 Jan 2020 20:58:02 +0000
Message-Id: <20200117205808.172194-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The kernel supports bitwise shift operations.  This patch-set adds the
support to libnftnl.  There are couple of preliminary housekeeping
patches.

Jeremy Sowden (6):
  Update gitignore.
  bitwise: fix some incorrect indentation.
  bitwise: add helper to print boolean expressions.
  include: update nf_tables.h.
  bitwise: add support for new netlink attributes.
  bitwise: add support for left- and right-shifts.

 .gitignore                          |   9 ++
 include/libnftnl/expr.h             |   2 +
 include/linux/netfilter/nf_tables.h |  24 +++-
 src/expr/bitwise.c                  |  93 +++++++++++--
 tests/nft-expr_bitwise-test.c       | 204 +++++++++++++++++++++++++---
 5 files changed, 304 insertions(+), 28 deletions(-)

-- 
2.24.1

