Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0DD39B700
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Jun 2021 12:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbhFDK3C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 4 Jun 2021 06:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbhFDK3B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 4 Jun 2021 06:29:01 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF73C06174A
        for <netfilter-devel@vger.kernel.org>; Fri,  4 Jun 2021 03:27:14 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lp72n-0004Zw-0o; Fri, 04 Jun 2021 12:27:13 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next v2 0/2] netfilter: new hook nfnl subsystem
Date:   Fri,  4 Jun 2021 12:27:05 +0200
Message-Id: <20210604102707.799-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

v2: patch 2 needs to update nfnl_lockdep_names[] in nfnetlink.c.

First patch is a required dependency to allow to check when
its safe to treat the 'priv' pointer as a nft base chain pointer.

Second patch adds a new nfnl subsystem to enable userspace to dump
the active hooks to userspace.

Previous patches added this to nf_tables instead, but technically
this isn't related to nf_tables.

Using a new nfnl subsys allows to extend this later, e.g. to
send out notifications, e.g. when a new base hook is registered.

Florian Westphal (2):
  netfilter: annotate nf_tables base hook ops
  netfilter: add new hook nfnl subsystem

 include/linux/netfilter.h                     |   8 +-
 include/uapi/linux/netfilter/nfnetlink.h      |   3 +-
 include/uapi/linux/netfilter/nfnetlink_hook.h |  54 +++
 net/netfilter/Kconfig                         |   9 +
 net/netfilter/Makefile                        |   1 +
 net/netfilter/nf_tables_api.c                 |   4 +-
 net/netfilter/nfnetlink.c                     |   1 +
 net/netfilter/nfnetlink_hook.c                | 375 ++++++++++++++++++
 8 files changed, 452 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/netfilter/nfnetlink_hook.h
 create mode 100644 net/netfilter/nfnetlink_hook.c

-- 
2.26.3

