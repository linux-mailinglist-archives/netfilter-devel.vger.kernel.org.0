Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45C703A670A
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Jun 2021 14:51:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbhFNMxJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Jun 2021 08:53:09 -0400
Received: from mail.netfilter.org ([217.70.188.207]:41396 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233674AbhFNMxH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Jun 2021 08:53:07 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 94C0F64223;
        Mon, 14 Jun 2021 14:49:46 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nftables] src: add xzalloc_array() and use it to allocate the expression hashtable
Date:   Mon, 14 Jun 2021 14:50:56 +0200
Message-Id: <20210614125056.11913-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise, assertion to ensure that no colission occur is hit due to
uninitialized hashtable memory area:

nft: netlink_delinearize.c:1741: expr_handler_init: Assertion `expr_handle_ht[hash] == NULL' failed.

Fixes: c4058f96c6a5 ("netlink_delinearize: Fix suspicious calloc() call")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/utils.h           |  1 +
 src/netlink_delinearize.c |  2 +-
 src/utils.c               | 10 ++++++++++
 3 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/include/utils.h b/include/utils.h
index f45f25132d18..ffbe2cbb75be 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -133,6 +133,7 @@ extern void *xmalloc(size_t size);
 extern void *xmalloc_array(size_t nmemb, size_t size);
 extern void *xrealloc(void *ptr, size_t size);
 extern void *xzalloc(size_t size);
+extern void *xzalloc_array(size_t nmemb, size_t size);
 extern char *xstrdup(const char *s);
 extern void xstrunescape(const char *in, char *out);
 
diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 9a1cf3c4f7d9..57af71a75609 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1733,7 +1733,7 @@ void expr_handler_init(void)
 	unsigned int i;
 	uint32_t hash;
 
-	expr_handle_ht = xmalloc_array(NFT_EXPR_HSIZE,
+	expr_handle_ht = xzalloc_array(NFT_EXPR_HSIZE,
 				       sizeof(expr_handle_ht[0]));
 
 	for (i = 0; i < array_size(netlink_parsers); i++) {
diff --git a/src/utils.c b/src/utils.c
index 47f5b791547b..925841c571f5 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -50,6 +50,16 @@ void *xmalloc_array(size_t nmemb, size_t size)
 	return xmalloc(nmemb * size);
 }
 
+void *xzalloc_array(size_t nmemb, size_t size)
+{
+	void *ptr;
+
+	ptr = xmalloc_array(nmemb, size);
+	memset(ptr, 0, nmemb * size);
+
+	return ptr;
+}
+
 void *xrealloc(void *ptr, size_t size)
 {
 	ptr = realloc(ptr, size);
-- 
2.30.2

