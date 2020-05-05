Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6974B1C60BA
	for <lists+netfilter-devel@lfdr.de>; Tue,  5 May 2020 21:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728660AbgEETFM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 5 May 2020 15:05:12 -0400
Received: from correo.us.es ([193.147.175.20]:50964 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729040AbgEETFL (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 5 May 2020 15:05:11 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CDCB33066B6
        for <netfilter-devel@vger.kernel.org>; Tue,  5 May 2020 21:05:09 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id BFB0E1158E3
        for <netfilter-devel@vger.kernel.org>; Tue,  5 May 2020 21:05:09 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BF0071158E2; Tue,  5 May 2020 21:05:09 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CE16FDA7B2
        for <netfilter-devel@vger.kernel.org>; Tue,  5 May 2020 21:05:07 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 05 May 2020 21:05:07 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id AFC6442EE38E
        for <netfilter-devel@vger.kernel.org>; Tue,  5 May 2020 21:05:07 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/3] parser_bison: release helper type string after parsing
Date:   Tue,  5 May 2020 21:05:02 +0200
Message-Id: <20200505190503.11891-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200505190503.11891-1-pablo@netfilter.org>
References: <20200505190503.11891-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

==4060==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x7f637b64a810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3a810)
    #1 0x7f637b17766d in xstrdup /home/pablo/devel/scm/git-netfilter/nftables/src/utils.c:75
    #2 0x7f637b1ddce9 in nft_parse /home/pablo/devel/scm/git-netfilter/nftables/src/parser_bison.c:5792

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 0190dbb88c97..4369ece60ed0 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -3903,6 +3903,7 @@ ct_helper_config		:	TYPE	QUOTED_STRING	PROTOCOL	ct_l4protoname	stmt_separator
 					erec_queue(error(&@2, "invalid name '%s', max length is %u\n", $2, (int)sizeof(ct->name)), state->msgs);
 					YYERROR;
 				}
+				xfree($2);
 
 				ct->l4proto = $4;
 			}
-- 
2.20.1

