Return-Path: <netfilter-devel+bounces-624-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28C7A82B716
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 23:25:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6902864D0
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jan 2024 22:25:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D29058AC6;
	Thu, 11 Jan 2024 22:25:37 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7F7E58AC4
	for <netfilter-devel@vger.kernel.org>; Thu, 11 Jan 2024 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl] set: buffer overflow in NFTNL_SET_DESC_CONCAT setter
Date: Thu, 11 Jan 2024 23:25:27 +0100
Message-Id: <20240111222527.4591-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow to set a maximum limit of sizeof(s->desc.field_len) which is 16
bytes, otherwise, bail out. Ensure s->desc.field_count does not go over
the array boundary.

Fixes: 7cd41b5387ac ("set: Add support for NFTA_SET_DESC_CONCAT attributes")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/set.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/set.c b/src/set.c
index 719e59616e97..b51ff9e0ba64 100644
--- a/src/set.c
+++ b/src/set.c
@@ -194,8 +194,14 @@ int nftnl_set_set_data(struct nftnl_set *s, uint16_t attr, const void *data,
 		memcpy(&s->desc.size, data, sizeof(s->desc.size));
 		break;
 	case NFTNL_SET_DESC_CONCAT:
+		if (data_len > sizeof(s->desc.field_len))
+			return -1;
+
 		memcpy(&s->desc.field_len, data, data_len);
-		while (s->desc.field_len[++s->desc.field_count]);
+		while (s->desc.field_len[++s->desc.field_count]) {
+			if (s->desc.field_count >= NFT_REG32_COUNT)
+				break;
+		}
 		break;
 	case NFTNL_SET_TIMEOUT:
 		memcpy(&s->timeout, data, sizeof(s->timeout));
-- 
2.30.2


