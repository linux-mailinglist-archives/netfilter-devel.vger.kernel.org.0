Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1154AF628
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Feb 2022 17:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236636AbiBIQLI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Feb 2022 11:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236635AbiBIQLH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:11:07 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73894C0613C9
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Feb 2022 08:11:08 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nHpYf-0004Tq-FB; Wed, 09 Feb 2022 17:11:05 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/7] metfilter: remove pcpu dying list
Date:   Wed,  9 Feb 2022 17:10:50 +0100
Message-Id: <20220209161057.30688-1-fw@strlen.de>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This is part 1 of a series that aims to remove both the unconfirmed
and dying lists.

This moves the dying list into the ecache infrastructure.
Entries are placed on this list only if the delivery of the destroy
event has failed (which implies that at least one userspace listener
did request redelivery).

The percpu dying list is removed in the last patch as it has no
functionality anymore.  This avoids the extra spinlock for conntrack
removal.

Florian Westphal (7):
  nfnetlink: handle already-released nl socket
  netfilter: ctnetlink: make ecache event cb global again
  netfilter: ecache: move to separate structure
  netfilter: ecache: use dedicated list for event redelivery
  netfilter: conntrack: split inner loop of list dumping to own function
  netfilter: conntrack: include ecache dying list in dumps
  netfilter: conntrack: remove the percpu dying list

 include/net/netfilter/nf_conntrack.h        |   9 +-
 include/net/netfilter/nf_conntrack_ecache.h |  21 +--
 include/net/netns/conntrack.h               |   2 -
 net/netfilter/nf_conntrack_core.c           |  60 ++++---
 net/netfilter/nf_conntrack_ecache.c         | 172 +++++++++-----------
 net/netfilter/nf_conntrack_netlink.c        | 150 +++++++++--------
 net/netfilter/nfnetlink.c                   |  62 +++++--
 7 files changed, 256 insertions(+), 220 deletions(-)

-- 
2.34.1

