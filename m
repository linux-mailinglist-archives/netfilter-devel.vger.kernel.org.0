Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7139667E58
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Jul 2019 10:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbfGNI4c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Jul 2019 04:56:32 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:45846 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbfGNI4c (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Jul 2019 04:56:32 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hmaJ4-0006n4-FC; Sun, 14 Jul 2019 10:56:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, Amish <anon.amish@gmail.com>
Subject: [PATCH xtables] nft: exit in case we can't fetch current genid
Date:   Sun, 14 Jul 2019 10:49:28 +0200
Message-Id: <20190714084928.31369-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <584d388e-9d90-11be-ea48-ba51464d8495@gmail.com>
References: <584d388e-9d90-11be-ea48-ba51464d8495@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When running iptables -nL as non-root user, iptables would loop indefinitely.

With this change, it will fail with
iptables v1.8.3 (nf_tables): Could not fetch rule set generation id: Permission denied (you must be root)

Reported-by: Amish <anon.amish@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 iptables/nft.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index e927d1db2b42..8f0d5e664eca 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -82,13 +82,19 @@ out:
 	return MNL_CB_ERROR;
 }
 
-static int mnl_genid_get(struct nft_handle *h, uint32_t *genid)
+static void mnl_genid_get(struct nft_handle *h, uint32_t *genid)
 {
 	char buf[MNL_SOCKET_BUFFER_SIZE];
 	struct nlmsghdr *nlh;
+	int ret;
 
 	nlh = nftnl_nlmsg_build_hdr(buf, NFT_MSG_GETGEN, 0, 0, h->seq);
-	return mnl_talk(h, nlh, genid_cb, genid);
+	ret = mnl_talk(h, nlh, genid_cb, genid);
+	if (ret == 0)
+		return;
+
+	xtables_error(RESOURCE_PROBLEM,
+		      "Could not fetch rule set generation id: %s\n", nft_strerror(errno));
 }
 
 int mnl_talk(struct nft_handle *h, struct nlmsghdr *nlh,
-- 
2.21.0

