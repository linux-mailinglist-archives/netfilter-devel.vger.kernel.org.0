Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B7AFA3BAE4
	for <lists+netfilter-devel@lfdr.de>; Mon, 10 Jun 2019 19:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfFJRZU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 10 Jun 2019 13:25:20 -0400
Received: from mail.us.es ([193.147.175.20]:58836 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727674AbfFJRZS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 10 Jun 2019 13:25:18 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 29D40C1A06
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 19:25:16 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 19920DA708
        for <netfilter-devel@vger.kernel.org>; Mon, 10 Jun 2019 19:25:16 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 18E83DA704; Mon, 10 Jun 2019 19:25:16 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1F3A7DA706;
        Mon, 10 Jun 2019 19:25:14 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 10 Jun 2019 19:25:14 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id EAA3A4265A31;
        Mon, 10 Jun 2019 19:25:13 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ffmancera@riseup.net
Subject: [PATCH nft] parser_bison: free chain name after creating constant expression
Date:   Mon, 10 Jun 2019 19:25:10 +0200
Message-Id: <20190610172510.3224-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

==2330== 2 bytes in 1 blocks are definitely lost in loss record 1 of 1
==2330==    at 0x4C2BBAF: malloc (vg_replace_malloc.c:299)
==2330==    by 0x583D3B9: strdup (strdup.c:42)
==2330==    by 0x4E7966D: xstrdup (utils.c:75)
==2330==    by 0x4E9C283: nft_lex (scanner.l:626)
==2330==    by 0x4E8E3C2: nft_parse (parser_bison.c:5297)
==2330==    by 0x4E7EAB2: nft_parse_bison_filename (libnftables.c:374)
==2330==    by 0x4E7EAB2: nft_run_cmd_from_filename (libnftables.c:475)
==2330==    by 0x109A53: main (main.c:310)

Fixes: f1e8a129ee42 ("src: Introduce chain_expr in jump and goto statements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 5ffb5cc22145..97a48f38af0c 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -3826,6 +3826,7 @@ chain_expr		:	variable_expr
 							 BYTEORDER_HOST_ENDIAN,
 							 strlen($1) * BITS_PER_BYTE,
 							 $1);
+				xfree($1);
 			}
 			;
 
-- 
2.11.0

