Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA8E31CFBAA
	for <lists+netfilter-devel@lfdr.de>; Tue, 12 May 2020 19:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbgELRKj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 12 May 2020 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELRKj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 12 May 2020 13:10:39 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6520CC061A0C
        for <netfilter-devel@vger.kernel.org>; Tue, 12 May 2020 10:10:39 -0700 (PDT)
Received: from localhost ([::1]:45486 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jYYQQ-00026h-8i; Tue, 12 May 2020 19:10:38 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 0/3] Fix SECMARK target comparison
Date:   Tue, 12 May 2020 19:10:15 +0200
Message-Id: <20200512171018.16871-1-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The kernel sets struct secmark_target_info->secid, so target comparison
in user space failed every time. Given that target data comparison
happens in libiptc, fixing this is a bit harder than just adding a cmp()
callback to struct xtables_target. Instead, allow for targets to write
the matchmask bits for their private data themselves and account for
that in both legacy and nft code. Then make use of the new
infrastructure to fix libxt_SECMARK.

Phil Sutter (3):
  xshared: Share make_delete_mask() between ip{,6}tables
  libxtables: Introduce 'matchmask' target callback
  libxt_SECMARK: Fix for failing target comparison

 configure.ac               |  4 ++--
 extensions/libxt_SECMARK.c | 10 ++++++++++
 extensions/libxt_SECMARK.t |  4 ++++
 include/xtables.h          |  3 +++
 iptables/ip6tables.c       | 38 ++------------------------------------
 iptables/iptables.c        | 38 ++------------------------------------
 iptables/nft-shared.c      | 15 ++++++++++++++-
 iptables/xshared.c         | 38 ++++++++++++++++++++++++++++++++++++++
 iptables/xshared.h         |  4 ++++
 9 files changed, 79 insertions(+), 75 deletions(-)
 create mode 100644 extensions/libxt_SECMARK.t

-- 
2.25.1

