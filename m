Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C8A18CDFD
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2020 13:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbgCTMra (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Mar 2020 08:47:30 -0400
Received: from correo.us.es ([193.147.175.20]:40868 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTMra (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:47:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7625F303D13
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:57 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 683A5DA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:57 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5E02DDA840; Fri, 20 Mar 2020 13:46:57 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 76C68DA3C2
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:55 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Mar 2020 13:46:55 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 5B55142EE38F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:55 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl 1/2] expr: masq: revisit _snprintf()
Date:   Fri, 20 Mar 2020 13:47:23 +0100
Message-Id: <20200320124724.407366-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Print combination of registers and flags.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/expr/masq.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/src/expr/masq.c b/src/expr/masq.c
index f6f3ceb6e8da..622ba282ff16 100644
--- a/src/expr/masq.c
+++ b/src/expr/masq.c
@@ -135,16 +135,20 @@ static int nftnl_expr_masq_snprintf_default(char *buf, size_t len,
 					    const struct nftnl_expr *e)
 {
 	struct nftnl_expr_masq *masq = nftnl_expr_data(e);
+	int remain = len, offset = 0, ret = 0;
 
-	if (e->flags & (1 << NFTNL_EXPR_MASQ_FLAGS))
-		return snprintf(buf, len, "flags 0x%x ", masq->flags);
 	if (e->flags & (1 << NFTNL_EXPR_MASQ_REG_PROTO_MIN)) {
-		return snprintf(buf, len,
-				"proto_min reg %u proto_max reg %u ",
-				masq->sreg_proto_min, masq->sreg_proto_max);
+		ret = snprintf(buf, remain,
+			       "proto_min reg %u proto_max reg %u ",
+			       masq->sreg_proto_min, masq->sreg_proto_max);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+	if (e->flags & (1 << NFTNL_EXPR_MASQ_FLAGS)) {
+		ret = snprintf(buf + offset, remain, "flags 0x%x ", masq->flags);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
-	return 0;
+	return offset;
 }
 
 static int nftnl_expr_masq_snprintf(char *buf, size_t len, uint32_t type,
-- 
2.11.0

