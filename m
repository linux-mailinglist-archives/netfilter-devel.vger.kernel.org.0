Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 156571C7808
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 19:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728619AbgEFReq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRep (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 13:34:45 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC917C061A0F
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 10:34:45 -0700 (PDT)
Received: from localhost ([::1]:58762 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jWNwS-0002nC-L9; Wed, 06 May 2020 19:34:44 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 07/15] nft: Clear all lists in nft_fini()
Date:   Wed,  6 May 2020 19:33:23 +0200
Message-Id: <20200506173331.9347-8-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200506173331.9347-1-phil@nwl.cc>
References: <20200506173331.9347-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove and free any pending entries in obj_list and err_list as well. To
get by without having to declare list-specific cursors, use generic
list_head types and call list_entry() explicitly.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 6503259eb443e..addde1b53f37e 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -850,10 +850,16 @@ int nft_init(struct nft_handle *h, int family, const struct builtin_table *t)
 
 void nft_fini(struct nft_handle *h)
 {
-	struct nft_cmd *cmd, *next;
+	struct list_head *pos, *n;
 
-	list_for_each_entry_safe(cmd, next, &h->cmd_list, head)
-		nft_cmd_free(cmd);
+	list_for_each_safe(pos, n, &h->cmd_list)
+		nft_cmd_free(list_entry(pos, struct nft_cmd, head));
+
+	list_for_each_safe(pos, n, &h->obj_list)
+		batch_obj_del(h, list_entry(pos, struct obj_update, head));
+
+	list_for_each_safe(pos, n, &h->err_list)
+		mnl_err_list_free(list_entry(pos, struct mnl_err, head));
 
 	nft_release_cache(h);
 	mnl_socket_close(h->nl);
-- 
2.25.1

