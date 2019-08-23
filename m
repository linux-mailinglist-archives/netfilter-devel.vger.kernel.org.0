Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5D2F9A928
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Aug 2019 09:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388386AbfHWHvV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Aug 2019 03:51:21 -0400
Received: from mx58.baidu.com ([61.135.168.58]:13195 "EHLO
        tc-sys-mailedm05.tc.baidu.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732838AbfHWHvU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Aug 2019 03:51:20 -0400
X-Greylist: delayed 500 seconds by postgrey-1.27 at vger.kernel.org; Fri, 23 Aug 2019 03:51:20 EDT
Received: from localhost (cp01-cos-dev01.cp01.baidu.com [10.92.119.46])
        by tc-sys-mailedm05.tc.baidu.com (Postfix) with ESMTP id 477621EBA002
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Aug 2019 15:42:48 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] netfilter: not mark a spinlock as __read_mostly
Date:   Fri, 23 Aug 2019 15:42:48 +0800
Message-Id: <1566546168-5544-1-git-send-email-lirongqing@baidu.com>
X-Mailer: git-send-email 1.7.1
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

when spinlock is locked/unlocked, its elements will be changed,
so marking it as __read_mostly is not suitable

and remove a duplicate definition of nf_conntrack_locks_all_lock
strange that compiler does not complain

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/netfilter/nf_conntrack_core.c   | 3 +--
 net/netfilter/nf_conntrack_labels.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index 81a8ef42b88d..0c63120b2db2 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -73,8 +73,7 @@ struct conntrack_gc_work {
 };
 
 static __read_mostly struct kmem_cache *nf_conntrack_cachep;
-static __read_mostly spinlock_t nf_conntrack_locks_all_lock;
-static __read_mostly DEFINE_SPINLOCK(nf_conntrack_locks_all_lock);
+static DEFINE_SPINLOCK(nf_conntrack_locks_all_lock);
 static __read_mostly bool nf_conntrack_locks_all;
 
 /* every gc cycle scans at most 1/GC_MAX_BUCKETS_DIV part of table */
diff --git a/net/netfilter/nf_conntrack_labels.c b/net/netfilter/nf_conntrack_labels.c
index d1c6b2a2e7bd..522792556632 100644
--- a/net/netfilter/nf_conntrack_labels.c
+++ b/net/netfilter/nf_conntrack_labels.c
@@ -11,7 +11,7 @@
 #include <net/netfilter/nf_conntrack_ecache.h>
 #include <net/netfilter/nf_conntrack_labels.h>
 
-static __read_mostly DEFINE_SPINLOCK(nf_connlabels_lock);
+static DEFINE_SPINLOCK(nf_connlabels_lock);
 
 static int replace_u32(u32 *address, u32 mask, u32 new)
 {
-- 
2.16.2

