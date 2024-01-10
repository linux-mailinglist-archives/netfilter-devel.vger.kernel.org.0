Return-Path: <netfilter-devel+bounces-529-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47206821C89
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 14:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FE991C21EF0
	for <lists+netfilter-devel@lfdr.de>; Tue,  2 Jan 2024 13:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032E4DF63;
	Tue,  2 Jan 2024 13:25:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4383CFBE4
	for <netfilter-devel@vger.kernel.org>; Tue,  2 Jan 2024 13:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl] object: define nftnl_obj_unset()
Date: Tue,  2 Jan 2024 14:25:40 +0100
Message-Id: <20240102132540.31391-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For consistency with existing objects, implement this interface.
This is already defined in libnftnl.map so the intention was to
provide it.

Fixes: 5573d0146c1a ("src: support for stateful objects")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/object.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/src/object.c b/src/object.c
index 9e768610cddb..0814be744448 100644
--- a/src/object.c
+++ b/src/object.c
@@ -69,6 +69,34 @@ bool nftnl_obj_is_set(const struct nftnl_obj *obj, uint16_t attr)
 	return obj->flags & (1 << attr);
 }
 
+EXPORT_SYMBOL(nftnl_obj_unset);
+void nftnl_obj_unset(struct nftnl_obj *obj, uint16_t attr)
+{
+	if (!(obj->flags & (1 << attr)))
+		return;
+
+	switch (attr) {
+	case NFTNL_OBJ_TABLE:
+		xfree(obj->table);
+		break;
+	case NFTNL_OBJ_NAME:
+		xfree(obj->name);
+		break;
+	case NFTNL_OBJ_USERDATA:
+		xfree(obj->user.data);
+		break;
+	case NFTNL_OBJ_TYPE:
+	case NFTNL_OBJ_FAMILY:
+	case NFTNL_OBJ_USE:
+	case NFTNL_OBJ_HANDLE:
+		break;
+	default:
+		break;
+	}
+
+	obj->flags &= ~(1 << attr);
+}
+
 static uint32_t nftnl_obj_validate[NFTNL_OBJ_MAX + 1] = {
 	[NFTNL_OBJ_FAMILY]	= sizeof(uint32_t),
 	[NFTNL_OBJ_USE]		= sizeof(uint32_t),
-- 
2.30.2


