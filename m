Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D30B32286C7
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGURFe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 21 Jul 2020 13:05:34 -0400
Received: from correo.us.es ([193.147.175.20]:50748 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730459AbgGURFe (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 21 Jul 2020 13:05:34 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3AB61120820
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:32 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2B929DA78D
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:32 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 210CEDA78C; Tue, 21 Jul 2020 19:05:32 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0A0BADA78B
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:30 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jul 2020 19:05:30 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id EBDD04265A2F
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 19:05:29 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] src: allow for negative value in variable definitions
Date:   Tue, 21 Jul 2020 19:05:25 +0200
Message-Id: <20200721170525.3982-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200721170525.3982-1-pablo@netfilter.org>
References: <20200721170525.3982-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Extend test to cover for negative value in chain priority definition.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y                                  | 10 +++++++++-
 .../shell/testcases/chains/0032priority_variable_0  | 10 ++++++++++
 .../chains/dumps/0032priority_variable_0.nft        | 13 +++++++++++++
 3 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100644 tests/shell/testcases/chains/dumps/0032priority_variable_0.nft

diff --git a/src/parser_bison.y b/src/parser_bison.y
index d2d7694ae170..f0cca64136ee 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2157,7 +2157,6 @@ extended_prio_spec	:	int_num
 			{
 				struct prio_spec spec = {0};
 
-				datatype_set($1->sym->expr, &priority_type);
 				spec.expr = $1;
 				$$ = spec;
 			}
@@ -3982,6 +3981,15 @@ set_rhs_expr		:	concat_rhs_expr
 initializer_expr	:	rhs_expr
 			|	list_rhs_expr
 			|	'{' '}'		{ $$ = compound_expr_alloc(&@$, EXPR_SET); }
+			|	DASH	NUM
+			{
+				int32_t num = -$2;
+
+				$$ = constant_expr_alloc(&@$, &integer_type,
+							 BYTEORDER_HOST_ENDIAN,
+							 sizeof(num) * BITS_PER_BYTE,
+							 &num);
+			}
 			;
 
 counter_config		:	PACKETS		NUM	BYTES	NUM
diff --git a/tests/shell/testcases/chains/0032priority_variable_0 b/tests/shell/testcases/chains/0032priority_variable_0
index 51bc5eb15e2a..8f2e57b9b3c3 100755
--- a/tests/shell/testcases/chains/0032priority_variable_0
+++ b/tests/shell/testcases/chains/0032priority_variable_0
@@ -6,12 +6,22 @@ set -e
 
 RULESET="
 define pri = 10
+define post = -10
+define for = \"filter - 100\"
 
 table inet global {
     chain prerouting {
         type filter hook prerouting priority \$pri
         policy accept
     }
+    chain forward {
+        type filter hook prerouting priority \$for
+        policy accept
+    }
+    chain postrouting {
+        type filter hook postrouting priority \$post
+        policy accept
+    }
 }"
 
 $NFT -f - <<< "$RULESET"
diff --git a/tests/shell/testcases/chains/dumps/0032priority_variable_0.nft b/tests/shell/testcases/chains/dumps/0032priority_variable_0.nft
new file mode 100644
index 000000000000..1a1b0794bb83
--- /dev/null
+++ b/tests/shell/testcases/chains/dumps/0032priority_variable_0.nft
@@ -0,0 +1,13 @@
+table inet global {
+	chain prerouting {
+		type filter hook prerouting priority filter + 10; policy accept;
+	}
+
+	chain forward {
+		type filter hook prerouting priority dstnat; policy accept;
+	}
+
+	chain postrouting {
+		type filter hook postrouting priority filter - 10; policy accept;
+	}
+}
-- 
2.20.1

