Return-Path: <netfilter-devel+bounces-593-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B184982A121
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 20:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA8B31C221F6
	for <lists+netfilter-devel@lfdr.de>; Wed, 10 Jan 2024 19:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73DD4E1DB;
	Wed, 10 Jan 2024 19:42:34 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95D84E1BF
	for <netfilter-devel@vger.kernel.org>; Wed, 10 Jan 2024 19:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nft 4/4] Revert "datatype: do not assert when value exceeds expected width"
Date: Wed, 10 Jan 2024 20:42:17 +0100
Message-Id: <20240110194217.484064-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240110194217.484064-1-pablo@netfilter.org>
References: <20240110194217.484064-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

 # nft -f ruleset.nft
 ruleset.nft:3:28-35: Error: expression is not a concatenation
                ip protocol . th dport { tcp / 22,  }
                                         ^^^^^^^^

Therefore, a852022d719e ("datatype: do not assert when value exceeds
expected width") not needed anymore after two previous fixes.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/datatype.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/datatype.c b/src/datatype.c
index 099e7580bd6c..3b19ae8ef52d 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -715,8 +715,7 @@ const struct datatype ip6addr_type = {
 static void inet_protocol_type_print(const struct expr *expr,
 				      struct output_ctx *octx)
 {
-	if (!nft_output_numeric_proto(octx) &&
-	    mpz_cmp_ui(expr->value, UINT8_MAX) <= 0) {
+	if (!nft_output_numeric_proto(octx)) {
 		char name[NFT_PROTONAME_MAXSIZE];
 
 		if (nft_getprotobynumber(mpz_get_uint8(expr->value), name, sizeof(name))) {
@@ -797,8 +796,7 @@ static void inet_service_print(const struct expr *expr, struct output_ctx *octx)
 
 void inet_service_type_print(const struct expr *expr, struct output_ctx *octx)
 {
-	if (nft_output_service(octx) &&
-	    mpz_cmp_ui(expr->value, UINT16_MAX) <= 0) {
+	if (nft_output_service(octx)) {
 		inet_service_print(expr, octx);
 		return;
 	}
-- 
2.30.2


