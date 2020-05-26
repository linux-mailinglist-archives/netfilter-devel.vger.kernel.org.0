Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8536E1AB394
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Apr 2020 00:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbgDOWBZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 15 Apr 2020 18:01:25 -0400
Received: from correo.us.es ([193.147.175.20]:56366 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730786AbgDOWBY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:01:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 8749477D86
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 00:01:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 78FD0DA788
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 00:01:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6EA47DA736; Thu, 16 Apr 2020 00:01:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3F058202AB
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 00:01:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 16 Apr 2020 00:01:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 1EC4E426CCBA
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Apr 2020 00:01:19 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH parser_bison] parser_bison: proper ct timeout list initialization
Date:   Thu, 16 Apr 2020 00:01:14 +0200
Message-Id: <20200415220114.585390-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Initialize list of timeout policies from ct_timeout_block.

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1403
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 3e8d6bd6d8ca..0e04a0e4fcf0 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1992,7 +1992,11 @@ ct_helper_block		:	/* empty */	{ $$ = $<obj>-1; }
 			}
 			;
 
-ct_timeout_block	:	/*empty */	{ $$ = $<obj>-1; }
+ct_timeout_block	:	/*empty */
+			{
+				$$ = $<obj>-1;
+				init_list_head(&$$->ct_timeout.timeout_list);
+			}
 			|	ct_timeout_block     common_block
 			|	ct_timeout_block     stmt_separator
 			|	ct_timeout_block     ct_timeout_config
@@ -3896,7 +3900,6 @@ ct_timeout_config	:	PROTOCOL	ct_l4protoname	stmt_separator
 				struct ct_timeout *ct;
 
 				ct = &$<obj>0->ct_timeout;
-				init_list_head(&ct->timeout_list);
 				list_splice_tail($4, &ct->timeout_list);
 			}
 			|	L3PROTOCOL	family_spec_explicit	stmt_separator
-- 
2.11.0

