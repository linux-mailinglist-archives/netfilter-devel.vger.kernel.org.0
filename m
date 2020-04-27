Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1F141BB1E0
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Apr 2020 01:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbgD0XM1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 27 Apr 2020 19:12:27 -0400
Received: from correo.us.es ([193.147.175.20]:44776 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726262AbgD0XM1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:12:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1CD3ED2DA17
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:12:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0F049BAAB4
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:12:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 04AAABAAB1; Tue, 28 Apr 2020 01:12:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2808FBAAC0
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:12:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 28 Apr 2020 01:12:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0C29E42EF9E1
        for <netfilter-devel@vger.kernel.org>; Tue, 28 Apr 2020 01:12:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft,v2 5/9] evaluate: fix crash when handling concatenation without map
Date:   Tue, 28 Apr 2020 01:12:13 +0200
Message-Id: <20200427231217.20274-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200427231217.20274-1-pablo@netfilter.org>
References: <20200427231217.20274-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix a crash when map is not specified, e.g.

 nft add rule x y snat ip addr . port to 1.1.1.1 . 22

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/evaluate.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/evaluate.c b/src/evaluate.c
index cad65cfb7343..8c227eb11402 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2924,6 +2924,9 @@ static int stmt_evaluate_nat_map(struct eval_ctx *ctx, struct stmt *stmt)
 	if (expr_evaluate(ctx, &stmt->nat.addr))
 		return -1;
 
+	if (stmt->nat.addr->etype != EXPR_MAP)
+		return 0;
+
 	data = stmt->nat.addr->mappings->set->data;
 	datatype_set(data, dtype);
 
-- 
2.20.1

