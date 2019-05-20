Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3A5240E3
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfETTId (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:08:33 -0400
Received: from mail.us.es ([193.147.175.20]:38362 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfETTId (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:08:33 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 10BBCBAEE8
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EF901DA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:30 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E56ACDA70C; Mon, 20 May 2019 21:08:30 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E17A7DA702;
        Mon, 20 May 2019 21:08:28 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 21:08:28 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B76B34265A31;
        Mon, 20 May 2019 21:08:28 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH iptables 1/6] nft: keep original cache in case of ERESTART
Date:   Mon, 20 May 2019 21:08:17 +0200
Message-Id: <20190520190822.18873-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520190822.18873-1-pablo@netfilter.org>
References: <20190520190822.18873-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Phil Sutter says:

"The problem is that data in h->obj_list potentially sits in cache, too.
At least rules have to be there so insert with index works correctly. If
the cache is flushed before regenerating the batch, use-after-free
occurs which crashes the program."

This patch keeps around the original cache until we have refreshed the
batch.

Fixes: 862818ac3a0de ("xtables: add and use nft_build_cache")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 23 ++++++++++++++++++++---
 iptables/nft.h |  3 ++-
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 172beec9ae27..288ada4af3ca 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -811,7 +811,7 @@ int nft_init(struct nft_handle *h, const struct builtin_table *t)
 
 	h->portid = mnl_socket_get_portid(h->nl);
 	h->tables = t;
-	h->cache = &h->__cache;
+	h->cache = &h->__cache[0];
 
 	INIT_LIST_HEAD(&h->obj_list);
 	INIT_LIST_HEAD(&h->err_list);
@@ -1618,14 +1618,30 @@ void nft_build_cache(struct nft_handle *h)
 		__nft_build_cache(h);
 }
 
-static void nft_rebuild_cache(struct nft_handle *h)
+static void __nft_flush_cache(struct nft_handle *h)
 {
-	if (!h->have_cache)
+	if (!h->cache_index) {
+		h->cache_index++;
+		h->cache = &h->__cache[h->cache_index];
+	} else {
 		flush_chain_cache(h, NULL);
+	}
+}
+
+static void nft_rebuild_cache(struct nft_handle *h)
+{
+	if (h->have_cache)
+		__nft_flush_cache(h);
 
 	__nft_build_cache(h);
 }
 
+static void nft_release_cache(struct nft_handle *h)
+{
+	if (h->cache_index)
+		flush_cache(&h->__cache[0], h->tables, NULL);
+}
+
 struct nftnl_chain_list *nft_chain_list_get(struct nft_handle *h,
 					    const char *table)
 {
@@ -2957,6 +2973,7 @@ retry:
 		batch_obj_del(h, n);
 	}
 
+	nft_release_cache(h);
 	mnl_batch_reset(h->batch);
 
 	if (i)
diff --git a/iptables/nft.h b/iptables/nft.h
index dc0797d302b8..43eb8a39dd9c 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -48,7 +48,8 @@ struct nft_handle {
 	struct list_head	err_list;
 	struct nft_family_ops	*ops;
 	const struct builtin_table *tables;
-	struct nft_cache	__cache;
+	unsigned int		cache_index;
+	struct nft_cache	__cache[2];
 	struct nft_cache	*cache;
 	bool			have_cache;
 	bool			restore;
-- 
2.11.0

