Return-Path: <netfilter-devel+bounces-3680-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3CA96B905
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 12:49:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B207D2873B1
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 10:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8051CF5CB;
	Wed,  4 Sep 2024 10:48:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9614E1482E1;
	Wed,  4 Sep 2024 10:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446928; cv=none; b=XxpRE0skhCdXQ/757DiWeDsFpC8TXbAcpJebIRoOYHzjVNvkJNvPvensz2ErmLk4pIcAAuKqYUKReQCRLLVGROY7n7tntOwXKpjBaoLCJhIwr5ryNgFmHvx55M0aUlFdbAYWRAu3DJRobQEvPoTekktg96XgFksiWTKmJZac/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446928; c=relaxed/simple;
	bh=G/cMFLqgfAz+tSXEyxmiE1H2LQoIMCFLFXGzTqt91ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fwTstyQsmDFbv8kXlMiJcD+g/Pq2e5biRBQLouEAFvZKpiw8x7DTu5IjIGlm81CzjRWSztquRQjQyFrwK8Sy2gP3fOkCK1AmLHP3onLhVt3kGFdgW6sfB4oTGLZobX8eXvqgvl9ByM7L3AqGcsggrqgzvbg/NeWeIlo60ZhWAeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WzJxt6ymdz20nMc;
	Wed,  4 Sep 2024 18:43:46 +0800 (CST)
Received: from kwepemj200016.china.huawei.com (unknown [7.202.194.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DEAF1400D7;
	Wed,  4 Sep 2024 18:48:44 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 kwepemj200016.china.huawei.com (7.202.194.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 18:48:42 +0800
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH v3 06/19] selftests/landlock: Test adding a rule for unhandled access
Date: Wed, 4 Sep 2024 18:48:11 +0800
Message-ID: <20240904104824.1844082-7-ivanov.mikhail1@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com>
References: <20240904104824.1844082-1-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 kwepemj200016.china.huawei.com (7.202.194.28)

Add test that validates behaviour of Landlock after rule with
unhandled access is added.

Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
Changes since v2:
* Replaces EXPECT_EQ with ASSERT_EQ for close().
* Refactors commit title and message.

Changes since v1:
* Refactors commit message.
---
 .../testing/selftests/landlock/socket_test.c  | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/landlock/socket_test.c b/tools/testing/selftests/landlock/socket_test.c
index 811bdaa95a7a..d2fedfca7193 100644
--- a/tools/testing/selftests/landlock/socket_test.c
+++ b/tools/testing/selftests/landlock/socket_test.c
@@ -351,4 +351,37 @@ TEST_F(protocol, rule_with_unknown_access)
 	ASSERT_EQ(0, close(ruleset_fd));
 }
 
+TEST_F(protocol, rule_with_unhandled_access)
+{
+	struct landlock_ruleset_attr ruleset_attr = {
+		.handled_access_socket = LANDLOCK_ACCESS_SOCKET_CREATE,
+	};
+	struct landlock_socket_attr protocol = {
+		.family = self->prot.family,
+		.type = self->prot.type,
+	};
+	int ruleset_fd;
+	__u64 access;
+
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
+	ASSERT_LE(0, ruleset_fd);
+
+	for (access = 1; access > 0; access <<= 1) {
+		int err;
+
+		protocol.allowed_access = access;
+		err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
+					&protocol, 0);
+		if (access == ruleset_attr.handled_access_socket) {
+			EXPECT_EQ(0, err);
+		} else {
+			EXPECT_EQ(-1, err);
+			EXPECT_EQ(EINVAL, errno);
+		}
+	}
+
+	ASSERT_EQ(0, close(ruleset_fd));
+}
+
 TEST_HARNESS_MAIN
-- 
2.34.1


