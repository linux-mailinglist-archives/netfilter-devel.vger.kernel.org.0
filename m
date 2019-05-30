Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB9162FA92
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 May 2019 12:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfE3Kzm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 06:55:42 -0400
Received: from mail.us.es ([193.147.175.20]:35372 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726653AbfE3Kzl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 06:55:41 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id E7CD1C1DF2
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 12:55:39 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D8E01DA70D
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 12:55:39 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id CE49FDA708; Thu, 30 May 2019 12:55:39 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id D811EDA70C;
        Thu, 30 May 2019 12:55:37 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 May 2019 12:55:37 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A923E4265A5B;
        Thu, 30 May 2019 12:55:37 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft,v2 7/7] erec: remove double \n on error when internal_netlink is used
Date:   Thu, 30 May 2019 12:55:29 +0200
Message-Id: <20190530105529.12657-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190530105529.12657-1-pablo@netfilter.org>
References: <20190530105529.12657-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove double empty line linebreak when printing internal errors.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/erec.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/erec.c b/src/erec.c
index 617c04ade178..cf543a980bc0 100644
--- a/src/erec.c
+++ b/src/erec.c
@@ -161,7 +161,6 @@ void erec_print(struct output_ctx *octx, const struct error_record *erec,
 			loc = &erec->locations[l];
 			netlink_dump_expr(loc->nle, f, debug_mask);
 		}
-		fprintf(f, "\n\n");
 		return;
 	}
 
-- 
2.11.0

