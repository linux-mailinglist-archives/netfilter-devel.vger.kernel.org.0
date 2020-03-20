Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F91918CDFE
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Mar 2020 13:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbgCTMrc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Mar 2020 08:47:32 -0400
Received: from correo.us.es ([193.147.175.20]:40892 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTMrc (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:47:32 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 4209F303D07
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:59 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 33BBBDA39F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:59 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 297A4DA390; Fri, 20 Mar 2020 13:46:59 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4B144DA7B2
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:57 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Mar 2020 13:46:57 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 2E80442EE393
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:57 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl 2/2] expr: nat: snprint flags in hexadecimal
Date:   Fri, 20 Mar 2020 13:47:24 +0100
Message-Id: <20200320124724.407366-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200320124724.407366-1-pablo@netfilter.org>
References: <20200320124724.407366-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/expr/nat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/expr/nat.c b/src/expr/nat.c
index 6b7d50ea801a..408521626d89 100644
--- a/src/expr/nat.c
+++ b/src/expr/nat.c
@@ -249,7 +249,7 @@ nftnl_expr_nat_snprintf_default(char *buf, size_t size,
 	}
 
 	if (e->flags & (1 << NFTNL_EXPR_NAT_FLAGS)) {
-		ret = snprintf(buf + offset, remain, "flags %u", nat->flags);
+		ret = snprintf(buf + offset, remain, "flags 0x%x ", nat->flags);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
-- 
2.11.0

