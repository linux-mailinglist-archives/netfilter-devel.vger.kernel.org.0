Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84CF4418827
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Sep 2021 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIZKwA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Sep 2021 06:52:00 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52582 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhIZKv6 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Sep 2021 06:51:58 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id DB37060081
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Sep 2021 12:48:59 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] monitor: honor NLM_F_EXCL netlink flag
Date:   Sun, 26 Sep 2021 12:50:18 +0200
Message-Id: <20210926105018.6032-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This allow to report for the create command.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/monitor.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/monitor.c b/src/monitor.c
index ff69234bfab4..8ecb7d199505 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -44,6 +44,7 @@ enum {
 	NFT_OF_EVENT_ADD,
 	NFT_OF_EVENT_INSERT,
 	NFT_OF_EVENT_DEL,
+	NFT_OF_EVENT_CREATE,
 };
 
 #define nft_mon_print(monh, ...) nft_print(&monh->ctx->nft->output, __VA_ARGS__)
@@ -140,7 +141,10 @@ static uint32_t netlink_msg2nftnl_of(uint32_t type, uint16_t flags)
 	case NFT_MSG_NEWSETELEM:
 	case NFT_MSG_NEWOBJ:
 	case NFT_MSG_NEWFLOWTABLE:
-		return NFT_OF_EVENT_ADD;
+		if (flags & NLM_F_EXCL)
+			return NFT_OF_EVENT_CREATE;
+		else
+			return NFT_OF_EVENT_ADD;
 	case NFT_MSG_DELTABLE:
 	case NFT_MSG_DELCHAIN:
 	case NFT_MSG_DELSET:
@@ -159,6 +163,8 @@ static const char *nftnl_of2cmd(uint32_t of)
 	switch (of) {
 	case NFT_OF_EVENT_ADD:
 		return "add";
+	case NFT_OF_EVENT_CREATE:
+		return "create";
 	case NFT_OF_EVENT_INSERT:
 		return "insert";
 	case NFT_OF_EVENT_DEL:
-- 
2.30.2

