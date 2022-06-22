Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC3C554792
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jun 2022 14:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355734AbiFVJBJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jun 2022 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355761AbiFVJA7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jun 2022 05:00:59 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A79D377EB
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jun 2022 02:00:57 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1o3wEI-0001kr-9N; Wed, 22 Jun 2022 11:00:54 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 0/3] netfilter: conntrack sparse annotations
Date:   Wed, 22 Jun 2022 11:00:44 +0200
Message-Id: <20220622090047.24586-1-fw@strlen.de>
X-Mailer: git-send-email 2.35.1
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

This series reduces the number of generated sparse warnings
in the netfilter codebase.

In some cases its just due to a missing '__rcu' annotation
of the base pointer, but in some other cases there is a
direct access to a __rcu annotated base pointer.

v2: keep unrelated EXPORT_SYMBOL in patch 3.

Florian Westphal (3):
  netfilter: nf_conntrack: add missing __rcu annotations
  netfilter: nf_conntrack: use rcu accessors where needed
  netfilter: h323: merge nat hook pointers into one

 include/linux/netfilter/nf_conntrack_h323.h  | 109 ++++----
 include/linux/netfilter/nf_conntrack_sip.h   |   2 +-
 include/net/netfilter/nf_conntrack_timeout.h |   2 +-
 net/ipv4/netfilter/nf_nat_h323.c             |  42 +--
 net/netfilter/nf_conntrack_broadcast.c       |   6 +-
 net/netfilter/nf_conntrack_h323_main.c       | 259 +++++++------------
 net/netfilter/nf_conntrack_helper.c          |   2 +-
 net/netfilter/nf_conntrack_netlink.c         |   9 +-
 net/netfilter/nf_conntrack_pptp.c            |   2 +-
 net/netfilter/nf_conntrack_sip.c             |   9 +-
 net/netfilter/nf_conntrack_timeout.c         |  18 +-
 net/netfilter/nfnetlink_cthelper.c           |  10 +-
 net/netfilter/xt_CT.c                        |  23 +-
 13 files changed, 230 insertions(+), 263 deletions(-)

-- 
2.35.1

