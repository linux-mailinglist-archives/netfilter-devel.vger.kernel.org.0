Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD1421BDD
	for <lists+netfilter-devel@lfdr.de>; Fri, 17 May 2019 18:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbfEQQnE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 17 May 2019 12:43:04 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46524 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726894AbfEQQnE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 17 May 2019 12:43:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id r7so7779056wrr.13
        for <netfilter-devel@vger.kernel.org>; Fri, 17 May 2019 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gj5eDteJmErbwWaXWoD/CPhhOkZsHSSd/WCsPjdqqyQ=;
        b=Ra3LqiN1cHPtqnLayiwwrS+Vf2nBbzsSeuH2NdaXXEbd4XBP9Er4BwvnwavWeQQiae
         G6UdSULBtrdYRWt4Ub+x3f/aGJ4zSlQz+F7uDvJ5Bu+IS/HhaV7T+MssDI35jlS2YrMA
         dskDRwVvehg1LTJXG0LHjllWbyBR9h7eFoorm0w/yS8Gc8eiErZDIe6W3cSI8e4g4670
         N6Mt7zbRap4VrIL5UHrfmQZ8GpTPYAJGhN6Wq7a+0kBHqwdKiVRYOeRaq0Sf6z3j5Hh/
         ljDz51TFklF5QjmuGPWxgimE8o2ZeC/YdfabW25a09iFYcouGDVQ0J38sCqfhEfK9wBJ
         jBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gj5eDteJmErbwWaXWoD/CPhhOkZsHSSd/WCsPjdqqyQ=;
        b=JY2RYpF4Zzzt2BhasHHDK3ySuDSB27ycMl5TYrLEYkQLyzcGpUbT/sXF5ZJbvxT33t
         YBSsDrPZms8CGmyGPw5KwY9cR8MoR3tCv2g7UDpLKbZgtrSaxOuxdjDs3t2NH/L9wfps
         YR45J2g/MZ8jr25F3lxWLly5PPEcw0SZSby10BFF0wJh3HP+rmS5WURdddPZiEAcFRSs
         icrvkgLHK7f7eTldr7pQ+c/AIO32vWhHtq/UBx8f9mqVS/GVP0+KI2zpOlc1N2WTDd1r
         G5HocYYwDQHh0BaTAqPCF2dI/QlvluhQ5wCLHvsBVX3KfXm6Mf/99jaccA7HbVhRqR8H
         O1jw==
X-Gm-Message-State: APjAAAWYO23ra29yjIPLLNf2lm8rGSV/F/Rthgxp0IHI7pWjqmbhTdLL
        SIMd+ZgjPXg21ET30mjDpXpq6uHj
X-Google-Smtp-Source: APXvYqxGLf2BKGA8b5yjZHivY4wHaRpyM3sLX94va4afQp+MnMIf3kIz5NorRP1J/T34BAco7/TumQ==
X-Received: by 2002:a5d:4fc6:: with SMTP id h6mr22441727wrw.307.1558111380902;
        Fri, 17 May 2019 09:43:00 -0700 (PDT)
Received: from VGer.neptura.lan (neptura.org. [88.174.209.153])
        by smtp.gmail.com with ESMTPSA id s13sm6808708wrw.17.2019.05.17.09.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 May 2019 09:43:00 -0700 (PDT)
From:   =?UTF-8?q?St=C3=A9phane=20Veyret?= <sveyret@gmail.com>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?St=C3=A9phane=20Veyret?= <sveyret@gmail.com>
Subject: [PATCH libnftnl,v3 1/2] src: add ct expectation support
Date:   Fri, 17 May 2019 18:40:30 +0200
Message-Id: <20190517164031.8536-3-sveyret@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190517164031.8536-1-sveyret@gmail.com>
References: <20190517164031.8536-1-sveyret@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add support for ct expectation objects, used to define specific expectations.

Signed-off-by: Stéphane Veyret <sveyret@gmail.com>
---
 include/libnftnl/object.h           |   7 +
 include/linux/netfilter/nf_tables.h |  13 +-
 include/obj.h                       |   7 +
 src/Makefile.am                     |   1 +
 src/obj/ct_expect.c                 | 193 ++++++++++++++++++++++++++++
 src/object.c                        |   1 +
 6 files changed, 221 insertions(+), 1 deletion(-)
 create mode 100644 src/obj/ct_expect.c

diff --git a/include/libnftnl/object.h b/include/libnftnl/object.h
index 4ce2230..dcb631c 100644
--- a/include/libnftnl/object.h
+++ b/include/libnftnl/object.h
@@ -70,6 +70,13 @@ enum {
 	NFTNL_OBJ_CT_TIMEOUT_ARRAY,
 };
 
+enum {
+	NFTNL_OBJ_CT_EXPECT_L3PROTO = NFTNL_OBJ_BASE,
+	NFTNL_OBJ_CT_EXPECT_L4PROTO,
+	NFTNL_OBJ_CT_EXPECT_DPORT,
+	NFTNL_OBJ_CT_EXPECT_TIMEOUT,
+};
+
 enum {
 	NFTNL_OBJ_LIMIT_RATE	= NFTNL_OBJ_BASE,
 	NFTNL_OBJ_LIMIT_UNIT,
diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index fd38cdc..59969f1 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -1429,6 +1429,16 @@ enum nft_ct_timeout_attributes {
 };
 #define NFTA_CT_TIMEOUT_MAX	(__NFTA_CT_TIMEOUT_MAX - 1)
 
+enum nft_ct_expectation_attributes {
+	NFTA_CT_EXPECT_UNSPEC,
+	NFTA_CT_EXPECT_L3PROTO,
+	NFTA_CT_EXPECT_L4PROTO,
+	NFTA_CT_EXPECT_DPORT,
+	NFTA_CT_EXPECT_TIMEOUT,
+	__NFTA_CT_EXPECT_MAX,
+};
+#define NFTA_CT_EXPECT_MAX	(__NFTA_CT_EXPECT_MAX - 1)
+
 #define NFT_OBJECT_UNSPEC	0
 #define NFT_OBJECT_COUNTER	1
 #define NFT_OBJECT_QUOTA	2
@@ -1438,7 +1448,8 @@ enum nft_ct_timeout_attributes {
 #define NFT_OBJECT_TUNNEL	6
 #define NFT_OBJECT_CT_TIMEOUT	7
 #define NFT_OBJECT_SECMARK	8
-#define __NFT_OBJECT_MAX	9
+#define NFT_OBJECT_CT_EXPECT	9
+#define __NFT_OBJECT_MAX	10
 #define NFT_OBJECT_MAX		(__NFT_OBJECT_MAX - 1)
 
 /**
diff --git a/include/obj.h b/include/obj.h
index 35b5c40..f5935ab 100644
--- a/include/obj.h
+++ b/include/obj.h
@@ -42,6 +42,12 @@ struct nftnl_obj {
 			uint8_t 	l4proto;
 			uint32_t	timeout[NFTNL_CTTIMEOUT_ARRAY_MAX];
 		} ct_timeout;
+		struct nftnl_obj_ct_expect {
+			uint16_t	l3proto;
+			uint8_t		l4proto;
+			uint16_t	dport;
+			uint32_t	timeout;
+		} ct_expect;
 		struct nftnl_obj_limit {
 			uint64_t	rate;
 			uint64_t	unit;
@@ -99,6 +105,7 @@ extern struct obj_ops obj_ops_counter;
 extern struct obj_ops obj_ops_quota;
 extern struct obj_ops obj_ops_ct_helper;
 extern struct obj_ops obj_ops_ct_timeout;
+extern struct obj_ops obj_ops_ct_expect;
 extern struct obj_ops obj_ops_limit;
 extern struct obj_ops obj_ops_tunnel;
 extern struct obj_ops obj_ops_secmark;
diff --git a/src/Makefile.am b/src/Makefile.am
index 2d5873f..8f9c022 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -65,4 +65,5 @@ libnftnl_la_SOURCES = utils.c		\
 		      obj/limit.c	\
 		      obj/ct_timeout.c 	\
 		      obj/secmark.c	\
+		      obj/ct_expect.c 	\
 		      libnftnl.map
diff --git a/src/obj/ct_expect.c b/src/obj/ct_expect.c
new file mode 100644
index 0000000..16066c4
--- /dev/null
+++ b/src/obj/ct_expect.c
@@ -0,0 +1,193 @@
+/*
+ * (C) 2019 by Stéphane Veyret <sveyret@gmail.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published
+ * by the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ */
+
+#include <arpa/inet.h>
+#include <errno.h>
+
+#include <libmnl/libmnl.h>
+
+#include "obj.h"
+
+static int nftnl_obj_ct_expect_set(struct nftnl_obj *e, uint16_t type,
+				   const void *data, uint32_t data_len)
+{
+	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
+
+	switch (type) {
+	case NFTNL_OBJ_CT_EXPECT_L3PROTO:
+		memcpy(&exp->l3proto, data, sizeof(exp->l3proto));
+		break;
+	case NFTNL_OBJ_CT_EXPECT_L4PROTO:
+		memcpy(&exp->l4proto, data, sizeof(exp->l4proto));
+		break;
+	case NFTNL_OBJ_CT_EXPECT_DPORT:
+		memcpy(&exp->dport, data, sizeof(exp->dport));
+		break;
+	case NFTNL_OBJ_CT_EXPECT_TIMEOUT:
+		memcpy(&exp->timeout, data, sizeof(exp->timeout));
+		break;
+	default:
+		return -1;
+	}
+	return 0;
+}
+
+static const void *nftnl_obj_ct_expect_get(const struct nftnl_obj *e,
+					   uint16_t type, uint32_t *data_len)
+{
+	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
+
+	switch (type) {
+	case NFTNL_OBJ_CT_EXPECT_L3PROTO:
+		*data_len = sizeof(exp->l3proto);
+		return &exp->l3proto;
+	case NFTNL_OBJ_CT_EXPECT_L4PROTO:
+		*data_len = sizeof(exp->l4proto);
+		return &exp->l4proto;
+	case NFTNL_OBJ_CT_EXPECT_DPORT:
+		*data_len = sizeof(exp->dport);
+		return &exp->dport;
+	case NFTNL_OBJ_CT_EXPECT_TIMEOUT:
+		*data_len = sizeof(exp->timeout);
+		return &exp->timeout;
+	}
+	return NULL;
+}
+
+static int nftnl_obj_ct_expect_cb(const struct nlattr *attr, void *data)
+{
+	int type = mnl_attr_get_type(attr);
+	const struct nlattr **tb = data;
+
+	if (mnl_attr_type_valid(attr, NFTA_CT_EXPECT_MAX) < 0)
+		return MNL_CB_OK;
+
+	switch (type) {
+	case NFTA_CT_EXPECT_L3PROTO:
+		if (mnl_attr_validate(attr, MNL_TYPE_U16) < 0)
+			abi_breakage();
+		break;
+	case NFTA_CT_EXPECT_L4PROTO:
+		if (mnl_attr_validate(attr, MNL_TYPE_U8) < 0)
+			abi_breakage();
+		break;
+	case NFTA_CT_EXPECT_DPORT:
+		if (mnl_attr_validate(attr, MNL_TYPE_U16) < 0)
+			abi_breakage();
+		break;
+	case NFTA_CT_EXPECT_TIMEOUT:
+		if (mnl_attr_validate(attr, MNL_TYPE_U32) < 0)
+			abi_breakage();
+		break;
+	}
+
+	tb[type] = attr;
+	return MNL_CB_OK;
+}
+
+static void
+nftnl_obj_ct_expect_build(struct nlmsghdr *nlh, const struct nftnl_obj *e)
+{
+	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
+
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L3PROTO))
+		mnl_attr_put_u16(nlh, NFTA_CT_EXPECT_L3PROTO, htons(exp->l3proto));
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L4PROTO))
+		mnl_attr_put_u8(nlh, NFTA_CT_EXPECT_L4PROTO, exp->l4proto);
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_DPORT))
+		mnl_attr_put_u16(nlh, NFTA_CT_EXPECT_DPORT, htons(exp->dport));
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_TIMEOUT))
+		mnl_attr_put_u32(nlh, NFTA_CT_EXPECT_TIMEOUT, exp->timeout);
+}
+
+static int
+nftnl_obj_ct_expect_parse(struct nftnl_obj *e, struct nlattr *attr)
+{
+	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
+	struct nlattr *tb[NFTA_CT_EXPECT_MAX + 1] = {};
+
+	if (mnl_attr_parse_nested(attr, nftnl_obj_ct_expect_cb, tb) < 0)
+		return -1;
+
+	if (tb[NFTA_CT_EXPECT_L3PROTO]) {
+		exp->l3proto = ntohs(mnl_attr_get_u16(tb[NFTA_CT_EXPECT_L3PROTO]));
+		e->flags |= (1 << NFTNL_OBJ_CT_EXPECT_L3PROTO);
+	}
+	if (tb[NFTA_CT_EXPECT_L4PROTO]) {
+		exp->l4proto = mnl_attr_get_u8(tb[NFTA_CT_EXPECT_L4PROTO]);
+		e->flags |= (1 << NFTNL_OBJ_CT_EXPECT_L4PROTO);
+	}
+	if (tb[NFTA_CT_EXPECT_DPORT]) {
+		exp->dport = ntohs(mnl_attr_get_u16(tb[NFTA_CT_EXPECT_DPORT]));
+		e->flags |= (1 << NFTNL_OBJ_CT_EXPECT_DPORT);
+	}
+	if (tb[NFTA_CT_EXPECT_TIMEOUT]) {
+		exp->timeout = mnl_attr_get_u32(tb[NFTA_CT_EXPECT_TIMEOUT]);
+		e->flags |= (1 << NFTNL_OBJ_CT_EXPECT_TIMEOUT);
+	}
+
+	return 0;
+}
+
+static int nftnl_obj_ct_expect_snprintf_default(char *buf, size_t len,
+					       const struct nftnl_obj *e)
+{
+	int ret = 0;
+	int offset = 0, remain = len;
+	struct nftnl_obj_ct_expect *exp = nftnl_obj_data(e);
+
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L3PROTO)) {
+		ret = snprintf(buf + offset, len, "family %d ", exp->l3proto);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_L4PROTO)) {
+		ret = snprintf(buf + offset, len, "protocol %d ", exp->l4proto);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_DPORT)) {
+		ret = snprintf(buf + offset, len, "dport %d ", exp->dport);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+	if (e->flags & (1 << NFTNL_OBJ_CT_EXPECT_TIMEOUT)) {
+		ret = snprintf(buf + offset, len, "timeout %d ", exp->timeout);
+		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
+	}
+
+	buf[offset] = '\0';
+	return offset;
+}
+
+static int nftnl_obj_ct_expect_snprintf(char *buf, size_t len, uint32_t type,
+				       uint32_t flags,
+				       const struct nftnl_obj *e)
+{
+	if (len)
+		buf[0] = '\0';
+
+	switch (type) {
+	case NFTNL_OUTPUT_DEFAULT:
+		return nftnl_obj_ct_expect_snprintf_default(buf, len, e);
+	case NFTNL_OUTPUT_JSON:
+	default:
+		break;
+	}
+	return -1;
+}
+
+struct obj_ops obj_ops_ct_expect = {
+	.name		= "ct_expect",
+	.type		= NFT_OBJECT_CT_EXPECT,
+	.alloc_len	= sizeof(struct nftnl_obj_ct_expect),
+	.max_attr	= NFTA_CT_EXPECT_MAX,
+	.set		= nftnl_obj_ct_expect_set,
+	.get		= nftnl_obj_ct_expect_get,
+	.parse		= nftnl_obj_ct_expect_parse,
+	.build		= nftnl_obj_ct_expect_build,
+	.snprintf	= nftnl_obj_ct_expect_snprintf,
+};
diff --git a/src/object.c b/src/object.c
index 5c8d183..23f8840 100644
--- a/src/object.c
+++ b/src/object.c
@@ -33,6 +33,7 @@ static struct obj_ops *obj_ops[__NFT_OBJECT_MAX] = {
 	[NFT_OBJECT_TUNNEL]	= &obj_ops_tunnel,
 	[NFT_OBJECT_CT_TIMEOUT] = &obj_ops_ct_timeout,
 	[NFT_OBJECT_SECMARK]	= &obj_ops_secmark,
+	[NFT_OBJECT_CT_EXPECT] = &obj_ops_ct_expect,
 };
 
 static struct obj_ops *nftnl_obj_ops_lookup(uint32_t type)
-- 
2.21.0

