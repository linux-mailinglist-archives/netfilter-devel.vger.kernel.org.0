Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9653977E0
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Jun 2021 18:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234166AbhFAQX1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 1 Jun 2021 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234127AbhFAQX0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 1 Jun 2021 12:23:26 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62A0C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  1 Jun 2021 09:21:44 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lo79B-0001tK-JX; Tue, 01 Jun 2021 18:21:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next 0/2] netfilter: new hook nfnl subsystem
Date:   Tue,  1 Jun 2021 18:21:34 +0200
Message-Id: <20210601162136.19444-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

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
 net/netfilter/nfnetlink_hook.c                | 375 ++++++++++++++++++
 7 files changed, 451 insertions(+), 3 deletions(-)
 create mode 100644 include/uapi/linux/netfilter/nfnetlink_hook.h
 create mode 100644 net/netfilter/nfnetlink_hook.c

-- 
2.26.3

