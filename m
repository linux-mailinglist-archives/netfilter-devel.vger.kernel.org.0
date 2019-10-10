Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 808B5D2237
	for <lists+netfilter-devel@lfdr.de>; Thu, 10 Oct 2019 10:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733092AbfJJIBo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 10 Oct 2019 04:01:44 -0400
Received: from correo.us.es ([193.147.175.20]:48486 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733062AbfJJIBo (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 10 Oct 2019 04:01:44 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3304DE44345
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Oct 2019 10:01:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 24C40DA801
        for <netfilter-devel@vger.kernel.org>; Thu, 10 Oct 2019 10:01:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 1A2AC1021A6; Thu, 10 Oct 2019 10:01:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0C4FC8E57E;
        Thu, 10 Oct 2019 10:01:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 10 Oct 2019 10:01:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D9F6641E4800;
        Thu, 10 Oct 2019 10:01:36 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     fw@strlen.de
Subject: [PATCH nft,v2] datatype: display description for header field < 8 bits
Date:   Thu, 10 Oct 2019 10:01:36 +0200
Message-Id: <20191010080136.8369-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 # nft describe ip dscp
 payload expression, datatype dscp (Differentiated Services Code Point) (basetype integer), 6 bits

 pre-defined symbolic constants (in hexadecimal):
 nft: datatype.c:209: switch_byteorder: Assertion `len > 0' failed.
 Aborted

Fixes: c89a0801d077 ("datatype: Display pre-defined inet_service values in host byte order")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: use div_round_up() - Florian Westphal.

 src/datatype.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/datatype.c b/src/datatype.c
index 873f7d4d358b..b9e167e03765 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -216,8 +216,8 @@ void symbol_table_print(const struct symbol_table *tbl,
 			enum byteorder byteorder,
 			struct output_ctx *octx)
 {
+	unsigned int len = div_round_up(dtype->size, BITS_PER_BYTE);
 	const struct symbolic_constant *s;
-	unsigned int len = dtype->size / BITS_PER_BYTE;
 	uint64_t value;
 
 	for (s = tbl->symbols; s->identifier != NULL; s++) {
-- 
2.11.0

