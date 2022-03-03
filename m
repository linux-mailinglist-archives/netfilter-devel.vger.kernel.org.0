Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB014CBF2F
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Mar 2022 14:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231998AbiCCNzR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Mar 2022 08:55:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiCCNzP (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:55:15 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8C718A788
        for <netfilter-devel@vger.kernel.org>; Thu,  3 Mar 2022 05:54:29 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1nPluV-0001Uq-0a; Thu, 03 Mar 2022 14:54:27 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [RFC v3 nf-next 00/15] netfilter: conntrack: remove percpu lists
Date:   Thu,  3 Mar 2022 14:54:04 +0100
Message-Id: <20220303135419.10837-1-fw@strlen.de>
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

Do not apply, I will re-target this to next cycle.

This is a resend of the 'remove the percpu dying list' series
(patches 1-7), with the reported build failures resolved.

The rest of the patches are the second part: remove the unconfirmed
list.  After this series, the percpu lists are gone.

Florian Westphal (15):
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

 include/net/netfilter/nf_conntrack.h         |  13 +-
 include/net/netfilter/nf_conntrack_ecache.h  |  21 +-
 include/net/netfilter/nf_conntrack_extend.h  |  31 +--
 include/net/netfilter/nf_conntrack_timeout.h |   8 -
 include/net/netns/conntrack.h                |   8 -
 net/netfilter/nf_conntrack_core.c            | 223 ++++++++-----------
 net/netfilter/nf_conntrack_ecache.c          | 172 +++++++-------
 net/netfilter/nf_conntrack_extend.c          |  32 ++-
 net/netfilter/nf_conntrack_helper.c          |   5 -
 net/netfilter/nf_conntrack_netlink.c         | 177 +++++++--------
 net/netfilter/nfnetlink.c                    |  62 ++++--
 net/netfilter/nfnetlink_cttimeout.c          |  88 +++++---
 12 files changed, 431 insertions(+), 409 deletions(-)

-- 
2.34.1

