Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 293945C267
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 19:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbfGAR62 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 13:58:28 -0400
Received: from mail.us.es ([193.147.175.20]:43970 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729964AbfGAR62 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:58:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 2E71E11F026
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1E5B6DA4CA
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 14139DA704; Mon,  1 Jul 2019 19:58:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 03691DA4D0
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Jul 2019 19:58:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id D71174265A31
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:23 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 3/3] rule: print space between policy and timeout
Date:   Mon,  1 Jul 2019 19:58:19 +0200
Message-Id: <20190701175819.5558-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190701175819.5558-1-pablo@netfilter.org>
References: <20190701175819.5558-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 table ip filter {
        ct timeout agressive-tcp {
		...
                policy = { established : 100, close_wait : 4, close : 4 }
        }
 }

for consistency with map syntax.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index 6dbc553e6c33..0a91917f7568 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1760,7 +1760,7 @@ static void print_proto_timeout_policy(uint8_t l4, const uint32_t *timeout,
 		if (timeout[i] != timeout_protocol[l4].dflt_timeout[i]) {
 			if (comma)
 				nft_print(octx, ", ");
-			nft_print(octx, "%s: %u",
+			nft_print(octx, "%s : %u",
 				  timeout_protocol[l4].state_to_name[i],
 				  timeout[i]);
 			comma = true;
-- 
2.11.0

