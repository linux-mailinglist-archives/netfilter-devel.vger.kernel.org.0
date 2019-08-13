Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACC18C1EE
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 22:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHMUM0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 16:12:26 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:57620 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbfHMUM0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:12:26 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hxd9c-0004BF-3n; Tue, 13 Aug 2019 22:12:24 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nftables 1/3] src: fix jumps on bigendian arches
Date:   Tue, 13 Aug 2019 22:12:44 +0200
Message-Id: <20190813201246.5543-2-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190813201246.5543-1-fw@strlen.de>
References: <20190813201246.5543-1-fw@strlen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

table bla {
  chain foo { }
  chain bar { jump foo }
 }
}

Fails to restore on big-endian platforms:
jump.nft:5:2-9: Error: Could not process rule: No such file or directory
 jump foo

nft passes a 0-length name to the kernel.

This is because when we export the value (the string), we provide
the size of the destination buffer.

In earlier versions, the parser allocated the name with the same
fixed size and all was fine.

After the fix, the export places the name in the wrong location
in the destination buffer.

This makes tests/shell/testcases/chains/0001jumps_0 work on s390x.

v2: convert one error check to a BUG(), it should not happen unless
    kernel abi is broken.

Fixes: 142350f154c78 ("src: invalid read when importing chain name")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/datatype.c | 27 ++++++++++++++++++---------
 src/netlink.c  | 16 +++++++++++++---
 2 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/src/datatype.c b/src/datatype.c
index 28f726f4e84c..c5a013463eb9 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -244,10 +244,25 @@ const struct datatype invalid_type = {
 	.print		= invalid_type_print,
 };
 
-static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
+static void verdict_jump_chain_print(const char *what, const struct expr *e,
+				     struct output_ctx *octx)
 {
 	char chain[NFT_CHAIN_MAXNAMELEN];
+	unsigned int len;
+
+	memset(chain, 0, sizeof(chain));
 
+	len = e->len / BITS_PER_BYTE;
+	if (len >= sizeof(chain))
+		BUG("verdict expression length %u is too large (%lu bits max)",
+		    e->len, (unsigned long)sizeof(chain) * BITS_PER_BYTE);
+
+	mpz_export_data(chain, e->value, BYTEORDER_HOST_ENDIAN, len);
+	nft_print(octx, "%s %s", what, chain);
+}
+
+static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
+{
 	switch (expr->verdict) {
 	case NFT_CONTINUE:
 		nft_print(octx, "continue");
@@ -257,10 +272,7 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
 		break;
 	case NFT_JUMP:
 		if (expr->chain->etype == EXPR_VALUE) {
-			mpz_export_data(chain, expr->chain->value,
-					BYTEORDER_HOST_ENDIAN,
-					NFT_CHAIN_MAXNAMELEN);
-			nft_print(octx, "jump %s", chain);
+			verdict_jump_chain_print("jump", expr->chain, octx);
 		} else {
 			nft_print(octx, "jump ");
 			expr_print(expr->chain, octx);
@@ -268,10 +280,7 @@ static void verdict_type_print(const struct expr *expr, struct output_ctx *octx)
 		break;
 	case NFT_GOTO:
 		if (expr->chain->etype == EXPR_VALUE) {
-			mpz_export_data(chain, expr->chain->value,
-					BYTEORDER_HOST_ENDIAN,
-					NFT_CHAIN_MAXNAMELEN);
-			nft_print(octx, "goto %s", chain);
+			verdict_jump_chain_print("goto", expr->chain, octx);
 		} else {
 			nft_print(octx, "goto ");
 			expr_print(expr->chain, octx);
diff --git a/src/netlink.c b/src/netlink.c
index aeeb12eaca93..f8e1120447d9 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -222,17 +222,27 @@ static void netlink_gen_verdict(const struct expr *expr,
 				struct nft_data_linearize *data)
 {
 	char chain[NFT_CHAIN_MAXNAMELEN];
+	unsigned int len;
 
 	data->verdict = expr->verdict;
 
 	switch (expr->verdict) {
 	case NFT_JUMP:
 	case NFT_GOTO:
+		len = expr->chain->len / BITS_PER_BYTE;
+
+		if (!len)
+			BUG("chain length is 0");
+
+		if (len > sizeof(chain))
+			BUG("chain is too large (%u, %u max)",
+			    len, (unsigned int)sizeof(chain));
+
+		memset(chain, 0, sizeof(chain));
+
 		mpz_export_data(chain, expr->chain->value,
-				BYTEORDER_HOST_ENDIAN,
-				NFT_CHAIN_MAXNAMELEN);
+				BYTEORDER_HOST_ENDIAN, len);
 		snprintf(data->chain, NFT_CHAIN_MAXNAMELEN, "%s", chain);
-		data->chain[NFT_CHAIN_MAXNAMELEN-1] = '\0';
 		break;
 	}
 }
-- 
2.21.0

