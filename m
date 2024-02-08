Return-Path: <netfilter-devel+bounces-973-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F9884DFA9
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 12:29:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 231781F2A751
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Feb 2024 11:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77ADA7318C;
	Thu,  8 Feb 2024 11:28:46 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 675546F51F;
	Thu,  8 Feb 2024 11:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707391726; cv=none; b=lmDbtk/2GldSsLPML2lzY057uqIYdj7f2n9Du9D/5LUOp0H+AVkWZ2g9V3YmWxtTzcktatmGdtPRtXk4jASx8K1mvPZW+JUeUUkzm9PkIG+TBtbmhz0yRKiGQLeBYcHDSeDcN1ZgKt3YmuNjT+2+IE695clmMX4vjWnDlgmQkPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707391726; c=relaxed/simple;
	bh=p5L+WP4iKxFXq0sRUv/XQbSG/gSsFtJv2ZL8dxygH3E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ed1mLiKPWueLEAdBZTdwa2QU/4KXq395WXFGXbufdAjsIb85uGUxxUheJkQKk1KsXR/1XT4FcJ3+BedajzmnWpWZeeklT7N7gChKF60vUodEYgS6VscRAq2GzJXCbjIcZRgjxKGjhAznpkN8naZvEg8UTZ2wTf/nzlCesGOq1EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	kadlec@netfilter.org
Subject: [PATCH net 06/13] netfilter: ctnetlink: fix filtering for zone 0
Date: Thu,  8 Feb 2024 12:28:27 +0100
Message-Id: <20240208112834.1433-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240208112834.1433-1-pablo@netfilter.org>
References: <20240208112834.1433-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Felix Huettner <felix.huettner@mail.schwarz>

previously filtering for the default zone would actually skip the zone
filter and flush all zones.

Fixes: eff3c558bb7e ("netfilter: ctnetlink: support filtering by zone")
Reported-by: Ilya Maximets <i.maximets@ovn.org>
Closes: https://lore.kernel.org/netdev/2032238f-31ac-4106-8f22-522e76df5a12@ovn.org/
Signed-off-by: Felix Huettner <felix.huettner@mail.schwarz>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c          | 12 ++++--
 .../netfilter/conntrack_dump_flush.c          | 43 ++++++++++++++++++-
 2 files changed, 50 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 0c22a02c2035..3b846cbdc050 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -876,6 +876,7 @@ struct ctnetlink_filter_u32 {
 
 struct ctnetlink_filter {
 	u8 family;
+	bool zone_filter;
 
 	u_int32_t orig_flags;
 	u_int32_t reply_flags;
@@ -992,9 +993,12 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	if (err)
 		goto err_filter;
 
-	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
-	if (err < 0)
-		goto err_filter;
+	if (cda[CTA_ZONE]) {
+		err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
+		if (err < 0)
+			goto err_filter;
+		filter->zone_filter = true;
+	}
 
 	if (!cda[CTA_FILTER])
 		return filter;
@@ -1148,7 +1152,7 @@ static int ctnetlink_filter_match(struct nf_conn *ct, void *data)
 	if (filter->family && nf_ct_l3num(ct) != filter->family)
 		goto ignore_entry;
 
-	if (filter->zone.id != NF_CT_DEFAULT_ZONE_ID &&
+	if (filter->zone_filter &&
 	    !nf_ct_zone_equal_any(ct, &filter->zone))
 		goto ignore_entry;
 
diff --git a/tools/testing/selftests/netfilter/conntrack_dump_flush.c b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
index f18c6db13bbf..b11ea8ee6719 100644
--- a/tools/testing/selftests/netfilter/conntrack_dump_flush.c
+++ b/tools/testing/selftests/netfilter/conntrack_dump_flush.c
@@ -13,7 +13,7 @@
 #include "../kselftest_harness.h"
 
 #define TEST_ZONE_ID 123
-#define CTA_FILTER_F_CTA_TUPLE_ZONE (1 << 2)
+#define NF_CT_DEFAULT_ZONE_ID 0
 
 static int reply_counter;
 
@@ -336,6 +336,9 @@ FIXTURE_SETUP(conntrack_dump_flush)
 	ret = conntrack_data_generate_v4(self->sock, 0xf4f4f4f4, 0xf5f5f5f5,
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
+	ret = conntrack_data_generate_v4(self->sock, 0xf6f6f6f6, 0xf7f7f7f7,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 
 	src = (struct in6_addr) {{
 		.__u6_addr32 = {
@@ -395,6 +398,26 @@ FIXTURE_SETUP(conntrack_dump_flush)
 					 TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 0);
 
+	src = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x07000000
+		}
+	}};
+	dst = (struct in6_addr) {{
+		.__u6_addr32 = {
+			0xb80d0120,
+			0x00000000,
+			0x00000000,
+			0x08000000
+		}
+	}};
+	ret = conntrack_data_generate_v6(self->sock, src, dst,
+					 NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
 	EXPECT_GE(ret, 2);
 	if (ret > 2)
@@ -425,6 +448,24 @@ TEST_F(conntrack_dump_flush, test_flush_by_zone)
 	EXPECT_EQ(ret, 2);
 	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
 	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+}
+
+TEST_F(conntrack_dump_flush, test_flush_by_zone_default)
+{
+	int ret;
+
+	ret = conntrack_flush_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 1);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, TEST_ZONE_ID + 2);
+	EXPECT_EQ(ret, 2);
+	ret = conntracK_count_zone(self->sock, NF_CT_DEFAULT_ZONE_ID);
+	EXPECT_EQ(ret, 0);
 }
 
 TEST_HARNESS_MAIN
-- 
2.30.2


