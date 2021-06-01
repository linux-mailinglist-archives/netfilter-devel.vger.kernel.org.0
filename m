Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77B394AD7
	for <lists+netfilter-devel@lfdr.de>; Sat, 29 May 2021 08:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE2GvO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 29 May 2021 02:51:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2526 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbhE2GvO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 29 May 2021 02:51:14 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4FsXCf6kFfzYqHR;
        Sat, 29 May 2021 14:46:54 +0800 (CST)
Received: from dggpeml500023.china.huawei.com (7.185.36.114) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 14:49:36 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 29 May 2021 14:49:36 +0800
From:   Shaokun Zhang <zhangshaokun@hisilicon.com>
To:     <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>
CC:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "Florian Westphal" <fw@strlen.de>
Subject: [PATCH] netfilter: conntrack: remove the repeated declaration
Date:   Sat, 29 May 2021 14:49:26 +0800
Message-ID: <1622270966-36196-1-git-send-email-zhangshaokun@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Variable 'nf_conntrack_net_id' is declared twice, so remove the
repeated declaration.

Cc: Pablo Neira Ayuso <pablo@netfilter.org>
Cc: Jozsef Kadlecsik <kadlec@netfilter.org>
Cc: Florian Westphal <fw@strlen.de>
Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
---
 net/netfilter/nf_conntrack_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index e0befcf8113a..757520725cd4 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -87,8 +87,6 @@ static __read_mostly bool nf_conntrack_locks_all;
 
 static struct conntrack_gc_work conntrack_gc_work;
 
-extern unsigned int nf_conntrack_net_id;
-
 void nf_conntrack_lock(spinlock_t *lock) __acquires(lock)
 {
 	/* 1) Acquire the lock */
-- 
2.7.4

