Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89F18B35AB
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 09:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfIPHdl (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 03:33:41 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:34286 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbfIPHdl (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 03:33:41 -0400
Received: from sf.home (unknown [85.255.236.110])
        (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: slyfox)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 547E034B21E;
        Mon, 16 Sep 2019 07:33:40 +0000 (UTC)
Received: by sf.home (Postfix, from userid 1000)
        id 6671324CB5A47; Mon, 16 Sep 2019 08:33:33 +0100 (BST)
From:   Sergei Trofimovich <slyfox@gentoo.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Sergei Trofimovich <slyfox@gentoo.org>,
        Florian Westphal <fw@strlen.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH] nftables: don't crash in 'list ruleset' if policy is not set
Date:   Mon, 16 Sep 2019 08:33:20 +0100
Message-Id: <20190916073320.2799091-1-slyfox@gentoo.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Minimal reproducer:

```
  $ cat nft.ruleset
    # filters
    table inet filter {
        chain prerouting {
            type filter hook prerouting priority -50
        }
    }

    # dump new state
    list ruleset

  $ nft -c -f ./nft.ruleset
    table inet filter {
    chain prerouting {
    Segmentation fault (core dumped)
```

The crash happens in `chain_print_declaration()`:

```
    if (chain->flags & CHAIN_F_BASECHAIN) {
        mpz_export_data(&policy, chain->policy->value,
                        BYTEORDER_HOST_ENDIAN, sizeof(int));
```

Here `chain->policy` is `NULL` (as textual rule does not mention it).

The change is not to print the policy if it's not set
(similar to `chain_evaluate()` handling).

CC: Florian Westphal <fw@strlen.de>
CC: Pablo Neira Ayuso <pablo@netfilter.org>
CC: netfilter-devel@vger.kernel.org
Bug: https://bugzilla.netfilter.org/show_bug.cgi?id=1365
Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
---
 src/rule.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/src/rule.c b/src/rule.c
index 5bb1c1d3..0cc1fa59 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1107,17 +1107,21 @@ static void chain_print_declaration(const struct chain *chain,
 		nft_print(octx, " # handle %" PRIu64, chain->handle.handle.id);
 	nft_print(octx, "\n");
 	if (chain->flags & CHAIN_F_BASECHAIN) {
-		mpz_export_data(&policy, chain->policy->value,
-				BYTEORDER_HOST_ENDIAN, sizeof(int));
 		nft_print(octx, "\t\ttype %s hook %s", chain->type,
 			  hooknum2str(chain->handle.family, chain->hooknum));
 		if (chain->dev != NULL)
 			nft_print(octx, " device \"%s\"", chain->dev);
-		nft_print(octx, " priority %s; policy %s;\n",
+		nft_print(octx, " priority %s;",
 			  prio2str(octx, priobuf, sizeof(priobuf),
 				   chain->handle.family, chain->hooknum,
-				   chain->priority.expr),
-			  chain_policy2str(policy));
+				   chain->priority.expr));
+		if (chain->policy) {
+			mpz_export_data(&policy, chain->policy->value,
+					BYTEORDER_HOST_ENDIAN, sizeof(int));
+			nft_print(octx, " policy %s;",
+				  chain_policy2str(policy));
+		}
+		nft_print(octx, "\n");
 	}
 }
 
-- 
2.23.0

