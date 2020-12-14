Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 307DB2D9E79
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Dec 2020 19:06:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408053AbgLNSEV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Dec 2020 13:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408753AbgLNSD2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Dec 2020 13:03:28 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF6FC06179C
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 10:02:47 -0800 (PST)
Received: from localhost ([::1]:36838 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kosBJ-0003f6-Ng; Mon, 14 Dec 2020 19:02:45 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH 1/2] set_elem: Use nftnl_data_reg_snprintf()
Date:   Mon, 14 Dec 2020 19:02:50 +0100
Message-Id: <20201214180251.11408-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Introduce a flag to allow toggling the '0x' prefix when printing data
values, then use the existing routines to print data registers from
set_elem code.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/data_reg.h  |  4 ++++
 src/expr/data_reg.c |  6 +++++-
 src/set_elem.c      | 16 ++++++++--------
 3 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/include/data_reg.h b/include/data_reg.h
index d9578aa479901..0d6b77829cf89 100644
--- a/include/data_reg.h
+++ b/include/data_reg.h
@@ -13,6 +13,10 @@ enum {
 	DATA_CHAIN,
 };
 
+enum {
+	DATA_F_NOPFX = 1 << 0,
+};
+
 union nftnl_data_reg {
 	struct {
 		uint32_t	val[NFT_DATA_VALUE_MAXLEN / sizeof(uint32_t)];
diff --git a/src/expr/data_reg.c b/src/expr/data_reg.c
index 4e35a799e9591..d3ccc612ce812 100644
--- a/src/expr/data_reg.c
+++ b/src/expr/data_reg.c
@@ -29,10 +29,14 @@ nftnl_data_reg_value_snprintf_default(char *buf, size_t size,
 				      const union nftnl_data_reg *reg,
 				      uint32_t flags)
 {
+	const char *pfx = flags & DATA_F_NOPFX ? "" : "0x";
 	int remain = size, offset = 0, ret, i;
 
+
+
 	for (i = 0; i < div_round_up(reg->len, sizeof(uint32_t)); i++) {
-		ret = snprintf(buf + offset, remain, "0x%.8x ", reg->val[i]);
+		ret = snprintf(buf + offset, remain,
+			       "%s%.8x ", pfx, reg->val[i]);
 		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 	}
 
diff --git a/src/set_elem.c b/src/set_elem.c
index e82684bc1c53e..51bf2c7b853bb 100644
--- a/src/set_elem.c
+++ b/src/set_elem.c
@@ -629,18 +629,18 @@ static int nftnl_set_elem_snprintf_default(char *buf, size_t size,
 	ret = snprintf(buf, remain, "element ");
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
-	for (i = 0; i < div_round_up(e->key.len, sizeof(uint32_t)); i++) {
-		ret = snprintf(buf + offset, remain, "%.8x ", e->key.val[i]);
-		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-	}
+	ret = nftnl_data_reg_snprintf(buf + offset, remain, &e->key,
+				      NFTNL_OUTPUT_DEFAULT,
+				      DATA_F_NOPFX, DATA_VALUE);
+	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
 	ret = snprintf(buf + offset, remain, " : ");
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
-	for (i = 0; i < div_round_up(e->data.len, sizeof(uint32_t)); i++) {
-		ret = snprintf(buf + offset, remain, "%.8x ", e->data.val[i]);
-		SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-	}
+	ret = nftnl_data_reg_snprintf(buf + offset, remain, &e->data,
+				      NFTNL_OUTPUT_DEFAULT,
+				      DATA_F_NOPFX, DATA_VALUE);
+	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
 
 	ret = snprintf(buf + offset, remain, "%u [end]", e->set_elem_flags);
 	SNPRINTF_BUFFER_SIZE(ret, remain, offset);
-- 
2.28.0

