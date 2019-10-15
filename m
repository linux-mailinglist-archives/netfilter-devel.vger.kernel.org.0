Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74E43D783A
	for <lists+netfilter-devel@lfdr.de>; Tue, 15 Oct 2019 16:17:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732500AbfJOORz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 15 Oct 2019 10:17:55 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:36918 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731553AbfJOORz (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 15 Oct 2019 10:17:55 -0400
Received: from localhost ([::1]:50008 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKNe6-0003B4-5E; Tue, 15 Oct 2019 16:17:54 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] mnl: Don't use nftnl_set_set()
Date:   Tue, 15 Oct 2019 16:17:45 +0200
Message-Id: <20191015141745.11908-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The function is unsafe to use as it effectively bypasses data length
checks. Instead use nftnl_set_set_str() which at least asserts a const
char pointer is passed.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/mnl.c b/src/mnl.c
index 14fa4a7186fd3..75ab07b045aa5 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -945,7 +945,7 @@ mnl_nft_set_dump(struct netlink_ctx *ctx, int family, const char *table)
 	nlh = nftnl_nlmsg_build_hdr(buf, NFT_MSG_GETSET, family,
 				    NLM_F_DUMP, ctx->seqnum);
 	if (table != NULL)
-		nftnl_set_set(s, NFTNL_SET_TABLE, table);
+		nftnl_set_set_str(s, NFTNL_SET_TABLE, table);
 	nftnl_set_nlmsg_build_payload(nlh, s);
 	nftnl_set_free(s);
 
-- 
2.23.0

