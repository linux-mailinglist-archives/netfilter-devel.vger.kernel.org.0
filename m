Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5376323A8B
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 16:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733075AbfETOl0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 10:41:26 -0400
Received: from mail.us.es ([193.147.175.20]:37368 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389004AbfETOl0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 10:41:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A3DAEC1A69
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 16:41:23 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 94E0EDA70E
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 16:41:23 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 942A4DA70D; Mon, 20 May 2019 16:41:23 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 961DDDA701;
        Mon, 20 May 2019 16:41:21 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 16:41:21 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 61E1F4265A32;
        Mon, 20 May 2019 16:41:21 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de, phil@nwl.cc
Subject: [PATCH iptables RFC 4/4] nft: don't care about previous state in RESTART
Date:   Mon, 20 May 2019 16:41:15 +0200
Message-Id: <20190520144115.29732-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520144115.29732-1-pablo@netfilter.org>
References: <20190520144115.29732-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We need to re-evalute based on the existing cache generation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index c1a079b734cf..bc3847d7ea47 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2782,10 +2782,10 @@ static void nft_refresh_transaction(struct nft_handle *h)
 			if (!tablename)
 				continue;
 			exists = nft_table_find(h, tablename);
-			if (n->skip && exists)
-				n->skip = 0;
-			else if (!n->skip && !exists)
+			if (exists)
 				n->skip = 1;
+			else
+				n->skip = 0;
 			break;
 		case NFT_COMPAT_CHAIN_USER_ADD:
 			tablename = nftnl_chain_get_str(n->chain, NFTNL_CHAIN_TABLE);
@@ -2796,13 +2796,16 @@ static void nft_refresh_transaction(struct nft_handle *h)
 			if (!chainname)
 				continue;
 
+			if (!h->noflush)
+				break;
+
 			c = nft_chain_find(h, tablename, chainname);
-			if (c && !n->skip) {
+			if (c) {
 				/* -restore -n flushes existing rules from redefined user-chain */
-				if (h->noflush)
-					__nft_rule_flush(h, tablename,
-							 chainname, false, true);
-			} else if (!c && n->skip) {
+				__nft_rule_flush(h, tablename,
+						 chainname, false, true);
+				n->skip = 1;
+			} else if (!c) {
 				n->skip = 0;
 			}
 			break;
-- 
2.11.0

