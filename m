Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 199A03B411
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 13:36:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389747AbfFJLgj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 07:36:39 -0400
Received: from mail.us.es ([193.147.175.20]:33308 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389285AbfFJLgi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 07:36:38 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D5C9DC1A68
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 13:36:36 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C6646DA707
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 13:36:36 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BC068DA702; Mon, 10 Jun 2019 13:36:36 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9D0C6DA718
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 13:36:34 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Jun 2019 13:36:34 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 4CAF24265A2F
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 13:36:34 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] src: invalid read when importing chain name (trace and json)
Date:   Mon, 10 Jun 2019 13:36:31 +0200
Message-Id: <20190610113631.25109-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fixes: 142350f154c7 ("src: invalid read when importing chain name")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Accidentally pushed out previous patch, sorry.

 src/netlink.c     | 3 +--
 src/parser_json.c | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/netlink.c b/src/netlink.c
index e9779684ac09..7a4312498ce8 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -1172,8 +1172,7 @@ static void trace_print_verdict(const struct nftnl_trace *nlt,
 		chain_expr = constant_expr_alloc(&netlink_location,
 						 &string_type,
 						 BYTEORDER_HOST_ENDIAN,
-						 NFT_CHAIN_MAXNAMELEN
-						 * BITS_PER_BYTE,
+						 strlen(chain) * BITS_PER_BYTE,
 						 chain);
 	}
 	expr = verdict_expr_alloc(&netlink_location, verdict, chain_expr);
diff --git a/src/parser_json.c b/src/parser_json.c
index 081cf5da7f39..ac110f16fe81 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -1059,7 +1059,7 @@ static struct expr *json_alloc_chain_expr(const char *chain)
 		return NULL;
 
 	return constant_expr_alloc(int_loc, &string_type, BYTEORDER_HOST_ENDIAN,
-				   NFT_CHAIN_MAXNAMELEN * BITS_PER_BYTE, chain);
+				   strlen(chain) * BITS_PER_BYTE, chain);
 }
 
 static struct expr *json_parse_verdict_expr(struct json_ctx *ctx,
-- 
2.11.0

