Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3F735C266
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727130AbfGAR61 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 13:58:27 -0400
Received: from mail.us.es ([193.147.175.20]:43966 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728077AbfGAR61 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:58:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A76B711F022
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 98320DA704
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:25 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 8DC52DA4D1; Mon,  1 Jul 2019 19:58:25 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 86B7ADA704
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Jul 2019 19:58:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 65EB44265A31
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:23 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/3] rule: do not print semicolon in ct timeout
Date:   Mon,  1 Jul 2019 19:58:18 +0200
Message-Id: <20190701175819.5558-2-pablo@netfilter.org>
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
                protocol tcp;
                            ^--- remove this semicolon

Not needed, remove it.

Fixes: c7c94802679c ("src: add ct timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index 048a7fb4c92c..6dbc553e6c33 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1834,7 +1834,7 @@ static void obj_print_data(const struct obj *obj,
 		nft_print(octx, "%s", opts->nl);
 		nft_print(octx, "%s%sprotocol ", opts->tab, opts->tab);
 		print_proto_name_proto(obj->ct_timeout.l4proto, octx);
-		nft_print(octx, ";%s", opts->nl);
+		nft_print(octx, "%s", opts->nl);
 		nft_print(octx, "%s%sl3proto %s%s",
 			  opts->tab, opts->tab,
 			  family2str(obj->ct_timeout.l3proto),
-- 
2.11.0

