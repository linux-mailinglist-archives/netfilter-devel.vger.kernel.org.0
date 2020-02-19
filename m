Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE37D164F8D
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Feb 2020 21:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgBSUIY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Feb 2020 15:08:24 -0500
Received: from correo.us.es ([193.147.175.20]:53266 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSUIY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Feb 2020 15:08:24 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B0BFB6D4E3
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:21 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A2FD2DA736
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:21 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 98950DA3C3; Wed, 19 Feb 2020 21:08:21 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 8BB8DDA736
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:19 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Feb 2020 21:08:19 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 703EC42EF532
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Feb 2020 21:08:19 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] parser_bison: memleak in device parser
Date:   Wed, 19 Feb 2020 21:08:16 +0100
Message-Id: <20200219200817.1146947-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

==1135425== 9 bytes in 1 blocks are definitely lost in loss record 1 of 1
==1135425==    at 0x483577F: malloc (vg_replace_malloc.c:309)
==1135425==    by 0x4BE846A: strdup (strdup.c:42)
==1135425==    by 0x48A5EDD: xstrdup (utils.c:75)
==1135425==    by 0x48C9A20: nft_lex (scanner.l:640)
==1135425==    by 0x48BC1A4: nft_parse (parser_bison.c:5682)
==1135425==    by 0x48AC336: nft_parse_bison_buffer (libnftables.c:375)
==1135425==    by 0x48AC336: nft_run_cmd_from_buffer (libnftables.c:443)
==1135425==    by 0x10A707: main (main.c:384)

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index cc77d0420cb0..ad512cdbb4c2 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2141,6 +2141,7 @@ dev_spec		:	DEVICE	string
 				expr = constant_expr_alloc(&@$, &string_type,
 							   BYTEORDER_HOST_ENDIAN,
 							   strlen($2) * BITS_PER_BYTE, $2);
+				xfree($2);
 				$$ = compound_expr_alloc(&@$, EXPR_LIST);
 				compound_expr_add($$, expr);
 
-- 
2.11.0

