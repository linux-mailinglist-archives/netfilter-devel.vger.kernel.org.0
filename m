Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04EA3D2028
	for <lists+netfilter-devel@lfdr.de>; Thu, 22 Jul 2021 10:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbhGVIIO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 22 Jul 2021 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhGVIIO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 22 Jul 2021 04:08:14 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0768C061575
        for <netfilter-devel@vger.kernel.org>; Thu, 22 Jul 2021 01:48:49 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1m6UNr-0000y6-Ps; Thu, 22 Jul 2021 10:48:47 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/3] netfilter: clusterip: don't register hook in all netns
Date:   Thu, 22 Jul 2021 10:48:31 +0200
Message-Id: <20210722084834.27027-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This series stops ipt_CLUSTERIP from registering arp mangling hook
unconditionally.

Hook gets installed/removed from checkentry/destroy callbacks.

Before this, modprobe ipt_CLUSTERIP would add a hook in each netns.
While at it, also get rid of x_tables.h/xt storage space in struct net,
there is no need for this.

Florian Westphal (3):
  netfilter: ipt_CLUSTERIP: only add arp mangle hook when required
  netfilter: ipt_CLUSTERIP: use clusterip_net to store pernet warning
  netfilter: remove xt pernet data

 include/net/net_namespace.h        |  2 --
 include/net/netns/x_tables.h       | 12 -------
 net/ipv4/netfilter/ipt_CLUSTERIP.c | 56 ++++++++++++++++++++----------
 net/netfilter/xt_CT.c              | 11 ------
 4 files changed, 37 insertions(+), 44 deletions(-)
 delete mode 100644 include/net/netns/x_tables.h

-- 
2.31.1

