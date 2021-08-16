Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D33ED9B3
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Aug 2021 17:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhHPPRH (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Aug 2021 11:17:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbhHPPRG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Aug 2021 11:17:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85788C061764
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Aug 2021 08:16:33 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1mFeLn-0007Cv-MX; Mon, 16 Aug 2021 17:16:31 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/5] netfilter: ecache: simplify event registration
Date:   Mon, 16 Aug 2021 17:16:21 +0200
Message-Id: <20210816151626.28770-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patchset simplifies event registration handling.

Event and expectation handler registration is merged into one.
This reduces boilerplate code during netns register/unregister.

Also, there is only one implementation of the event handler
(ctnetlink), so it makes no sense to return -EBUSY if another
handler is registered already -- it cannot happen.

This also allows to remove the 'nf_exp_event_notifier' pointer
from struct net.

Florian Westphal (5):
  netfilter: ecache: remove one indent level
  netfilter: ecache: remove another indent level
  netfilter: ecache: add common helper for nf_conntrack_eventmask_report
  netfilter: ecache: prepare for event notifier merge
  netfilter: ecache: remove nf_exp_event_notifier structure

 include/net/netfilter/nf_conntrack_ecache.h |  32 +--
 include/net/netns/conntrack.h               |   1 -
 net/netfilter/nf_conntrack_ecache.c         | 211 +++++++-------------
 net/netfilter/nf_conntrack_netlink.c        |  50 +----
 4 files changed, 96 insertions(+), 198 deletions(-)

-- 
2.31.1

