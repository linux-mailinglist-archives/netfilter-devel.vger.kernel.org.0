Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9E61C7B87
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 22:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728659AbgEFUvU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 16:51:20 -0400
Received: from correo.us.es ([193.147.175.20]:41010 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726815AbgEFUvU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 16:51:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D0C95E8E89
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 22:51:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C19A92004A
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 22:51:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B70993332; Wed,  6 May 2020 22:51:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B99A82004A
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 22:51:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 06 May 2020 22:51:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A3C6E42EF42A
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 22:51:16 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] evaluate: fix memleak in stmt_evaluate_reject_icmp()
Date:   Wed,  6 May 2020 22:51:14 +0200
Message-Id: <20200506205114.1505-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

==26297==ERROR: LeakSanitizer: detected memory leaks
                                                                                               c
Direct leak of 512 byte(s) in 4 object(s) allocated from:
    #0 0x7f46f8167330 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xe9330)
    #1 0x7f46f7b3cf1c in xmalloc /home/pablo/devel/scm/git-netfilter/nftables/src/utils.c:36
    #2 0x7f46f7b3d075 in xzalloc /home/pablo/devel/scm/git-netfilter/nftables/src/utils.c:65
    #3 0x7f46f7a85760 in expr_alloc /home/pablo/devel/scm/git-netfilter/nftables/src/expression.c:45
    #4 0x7f46f7a8915d in constant_expr_alloc /home/pablo/devel/scm/git-netfilter/nftables/src/expression.c:388
    #5 0x7f46f7a7bad4 in symbolic_constant_parse /home/pablo/devel/scm/git-netfilter/nftables/src/datatype.c:173
    #6 0x7f46f7a7af5f in symbol_parse /home/pablo/devel/scm/git-netfilter/nftables/src/datatype.c:132
    #7 0x7f46f7abf2bd in stmt_evaluate_reject_icmp /home/pablo/devel/scm/git-netfilter/nftables./src/evaluate.c:2739
    [...]
SUMMARY: AddressSanitizer: 544 byte(s) leaked in 8 allocation(s).

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index 9aa283fd2e12..de5f60ec1f4d 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2742,6 +2742,8 @@ static int stmt_evaluate_reject_icmp(struct eval_ctx *ctx, struct stmt *stmt)
 		return -1;
 	}
 	stmt->reject.icmp_code = mpz_get_uint8(code->value);
+	expr_free(code);
+
 	return 0;
 }
 
-- 
2.20.1

