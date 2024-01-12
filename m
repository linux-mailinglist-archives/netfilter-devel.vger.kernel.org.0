Return-Path: <netfilter-devel+bounces-625-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC0982BF50
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jan 2024 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEC61287B12
	for <lists+netfilter-devel@lfdr.de>; Fri, 12 Jan 2024 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEDB67E85;
	Fri, 12 Jan 2024 11:36:54 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24FA82628C
	for <netfilter-devel@vger.kernel.org>; Fri, 12 Jan 2024 11:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl] set_elem: use nftnl_data_cpy() in NFTNL_SET_ELEM_{KEY,KEY_END,DATA}
Date: Fri, 12 Jan 2024 12:36:45 +0100
Message-Id: <20240112113645.18107-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use safe nftnl_data_cpy() to copy key into union nftnl_data_reg.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/set_elem.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/src/set_elem.c b/src/set_elem.c
index 884faff432a9..34258d24e85f 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -126,13 +126,9 @@ int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 		memcpy(&s->set_elem_flags, data, sizeof(s->set_elem_flags));
 		break;
 	case NFTNL_SET_ELEM_KEY:	/* NFTA_SET_ELEM_KEY */
-		memcpy(&s->key.val, data, data_len);
-		s->key.len = data_len;
-		break;
+		return nftnl_data_cpy(&s->key, data, data_len);
 	case NFTNL_SET_ELEM_KEY_END:	/* NFTA_SET_ELEM_KEY_END */
-		memcpy(&s->key_end.val, data, data_len);
-		s->key_end.len = data_len;
-		break;
+		return nftnl_data_cpy(&s->key_end, data, data_len);
 	case NFTNL_SET_ELEM_VERDICT:	/* NFTA_SET_ELEM_DATA */
 		memcpy(&s->data.verdict, data, sizeof(s->data.verdict));
 		break;
@@ -145,9 +141,7 @@ int nftnl_set_elem_set(struct nftnl_set_elem *s, uint16_t attr,
 			return -1;
 		break;
 	case NFTNL_SET_ELEM_DATA:	/* NFTA_SET_ELEM_DATA */
-		memcpy(s->data.val, data, data_len);
-		s->data.len = data_len;
-		break;
+		return nftnl_data_cpy(&s->data, data, data_len);
 	case NFTNL_SET_ELEM_TIMEOUT:	/* NFTA_SET_ELEM_TIMEOUT */
 		memcpy(&s->timeout, data, sizeof(s->timeout));
 		break;
-- 
2.30.2


