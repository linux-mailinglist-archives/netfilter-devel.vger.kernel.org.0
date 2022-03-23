Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E66E4E52FD
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Mar 2022 14:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiCWNX4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Mar 2022 09:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244260AbiCWNXz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:23:55 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C0547D004
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Mar 2022 06:22:24 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nX0wQ-00013W-9T; Wed, 23 Mar 2022 14:22:22 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v3 00/16] netfilter: conntrack: remove percpu lists
Date:   Wed, 23 Mar 2022 14:21:58 +0100
Message-Id: <20220323132214.6700-1-fw@strlen.de>
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

This series removes the unconfirmed and dying percpu lists.

Dying list is replaced by pernet list, only used when reliable event
delivery mode was requested.

Unconfirmed list is replaced by a generation id for the conntrack
extesions, to detect when pointers to external objects (timeout policy,
helper, ...) has gone stale.

An alternative to the genid would be to always take references on
such external objects, let me know if that is the preferred solution.

Changes in v3:
- fix build bugs reported by kbuild robot
- add patch #16

Florian Westphal (16):
  nfnetlink: handle already-released nl socket
  netfilter: ctnetlink: make ecache event cb global again
  netfilter: ecache: move to separate structure
  netfilter: ecache: use dedicated list for event redelivery
  netfilter: conntrack: split inner loop of list dumping to own function
  netfilter: conntrack: include ecache dying list in dumps
  netfilter: conntrack: remove the percpu dying list
  netfilter: cttimeout: inc/dec module refcount per object, not per use
    refcount
  netfilter: nfnetlink_cttimeout: use rcu protection in
    cttimeout_get_timeout
  netfilter: cttimeout: decouple unlink and free on netns destruction
  netfilter: remove nf_ct_unconfirmed_destroy helper
  netfilter: extensions: introduce extension genid count
  netfilter: cttimeout: decouple unlink and free on netns destruction
  netfilter: conntrack: remove __nf_ct_unconfirmed_destroy
  netfilter: conntrack: remove unconfirmed list
  netfilter: conntrack: avoid unconditional local_bh_disable

 include/net/netfilter/nf_conntrack.h         |  13 +-
 include/net/netfilter/nf_conntrack_ecache.h  |  34 +--
 include/net/netfilter/nf_conntrack_extend.h  |  31 +--
 include/net/netfilter/nf_conntrack_labels.h  |  10 +-
 include/net/netfilter/nf_conntrack_timeout.h |   8 -
 include/net/netns/conntrack.h                |   8 -
 net/netfilter/nf_conntrack_core.c            | 230 ++++++++-----------
 net/netfilter/nf_conntrack_ecache.c          | 173 +++++++-------
 net/netfilter/nf_conntrack_extend.c          |  32 ++-
 net/netfilter/nf_conntrack_helper.c          |   5 -
 net/netfilter/nf_conntrack_netlink.c         | 177 +++++++-------
 net/netfilter/nfnetlink.c                    |  62 +++--
 net/netfilter/nfnetlink_cttimeout.c          |  88 ++++---
 13 files changed, 443 insertions(+), 428 deletions(-)

-- 
2.34.1

