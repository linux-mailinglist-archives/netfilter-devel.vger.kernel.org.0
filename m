Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 586EE82735
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2019 23:54:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfHEVy3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Aug 2019 17:54:29 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45488 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728892AbfHEVy3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Aug 2019 17:54:29 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hukvz-00068a-HH; Mon, 05 Aug 2019 23:54:27 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH RFC nft] src: avoid re-initing core library when a second context struct is allocated
Date:   Mon,  5 Aug 2019 23:49:17 +0200
Message-Id: <20190805214917.13747-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Calling nft_ctx_new() a second time leaks memory, and calling
nft_ctx_free a second time -- on a different context -- causes
double-free.

This patch won't work in case we assume libnftables should be
thread-safe, in such case we either need a mutex or move all resources
under nft_ctx scope.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/libnftables.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/libnftables.c b/src/libnftables.c
index 4a139c58b2b3..880fd4284555 100644
--- a/src/libnftables.c
+++ b/src/libnftables.c
@@ -17,6 +17,8 @@
 #include <stdlib.h>
 #include <string.h>
 
+static unsigned int context_count;
+
 static int nft_netlink(struct nft_ctx *nft,
 		       struct list_head *cmds, struct list_head *msgs,
 		       struct mnl_socket *nf_sock)
@@ -86,6 +88,9 @@ out:
 
 static void nft_init(void)
 {
+	if (context_count++)
+		return;
+
 	mark_table_init();
 	realm_table_rt_init();
 	devgroup_table_init();
@@ -99,6 +104,9 @@ static void nft_init(void)
 
 static void nft_exit(void)
 {
+	if (--context_count)
+		return;
+
 	ct_label_table_exit();
 	realm_table_rt_exit();
 	devgroup_table_exit();
-- 
2.21.0

