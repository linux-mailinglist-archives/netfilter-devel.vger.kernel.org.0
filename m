Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA352FA8D
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 May 2019 12:55:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfE3Kzk (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 06:55:40 -0400
Received: from mail.us.es ([193.147.175.20]:35334 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726610AbfE3Kzj (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 06:55:39 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 00235C1DF0
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 12:55:38 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E5C1EDA70B
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 12:55:37 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id DB667DA717; Thu, 30 May 2019 12:55:37 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E251FDA70B;
        Thu, 30 May 2019 12:55:35 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 May 2019 12:55:35 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B87E44265A5B;
        Thu, 30 May 2019 12:55:35 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft,v2 3/7] mnl: call mnl_set_sndbuffer() from mnl_batch_talk()
Date:   Thu, 30 May 2019 12:55:25 +0200
Message-Id: <20190530105529.12657-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190530105529.12657-1-pablo@netfilter.org>
References: <20190530105529.12657-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Instead of mnl_nft_socket_sendmsg(), just a cleanup.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/mnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/mnl.c b/src/mnl.c
index a84a6a609333..b3999d5f1d9f 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -272,7 +272,6 @@ static ssize_t mnl_nft_socket_sendmsg(const struct netlink_ctx *ctx)
 	};
 	uint32_t i;
 
-	mnl_set_sndbuffer(ctx->nft->nf_sock, ctx->batch);
 	nftnl_batch_iovec(ctx->batch, iov, iov_len);
 
 	for (i = 0; i < iov_len; i++) {
@@ -298,6 +297,8 @@ int mnl_batch_talk(struct netlink_ctx *ctx, struct list_head *err_list)
 	};
 	int err = 0;
 
+	mnl_set_sndbuffer(ctx->nft->nf_sock, ctx->batch);
+
 	ret = mnl_nft_socket_sendmsg(ctx);
 	if (ret == -1)
 		return -1;
-- 
2.11.0

