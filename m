Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20C48357515
	for <lists+netfilter-devel@lfdr.de>; Wed,  7 Apr 2021 21:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355675AbhDGTn5 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Apr 2021 15:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbhDGTn5 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Apr 2021 15:43:57 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684CEC06175F
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Apr 2021 12:43:47 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lUE5Z-00028F-SR; Wed, 07 Apr 2021 21:43:46 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf 0/2] arp,ebtables: add pre_exit hooks for arp/ebtable hook unregister
Date:   Wed,  7 Apr 2021 21:43:38 +0200
Message-Id: <20210407194340.21594-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

arptables and ebtables need the same fixup that was added for
ip/ip6tables: synchronize_rcu() is needed before ruleset can be free'd.

Add pre_exit hooks for this.

Florian Westphal (2):
  netfilter: bridge: add pre_exit hooks for ebtable unregistration
  netfilter: arp_tables: netfilter: bridge: add pre_exit hook for table
    unregister

 include/linux/netfilter_arp/arp_tables.h  |  5 ++--
 include/linux/netfilter_bridge/ebtables.h |  5 ++--
 net/bridge/netfilter/ebtable_broute.c     |  8 +++++-
 net/bridge/netfilter/ebtable_filter.c     |  8 +++++-
 net/bridge/netfilter/ebtable_nat.c        |  8 +++++-
 net/bridge/netfilter/ebtables.c           | 30 ++++++++++++++++++++---
 net/ipv4/netfilter/arp_tables.c           |  9 +++++--
 net/ipv4/netfilter/arptable_filter.c      | 10 +++++++-
 8 files changed, 70 insertions(+), 13 deletions(-)

-- 
2.26.3

