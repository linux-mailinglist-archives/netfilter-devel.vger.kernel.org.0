Return-Path: <netfilter-devel+bounces-3091-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4F793E17F
	for <lists+netfilter-devel@lfdr.de>; Sun, 28 Jul 2024 02:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA6281F62
	for <lists+netfilter-devel@lfdr.de>; Sun, 28 Jul 2024 00:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8383B28F5;
	Sun, 28 Jul 2024 00:26:24 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4887910FF;
	Sun, 28 Jul 2024 00:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722126384; cv=none; b=dyy3nRla73IatKWn4i2gqvjKiyTyBFT3aljmv6Gdw6AvSqIgbjRuEvMkjhAJPSk5vYm/cz8AWulBjnR2DZDAUf5jndJD4+JX/kH6vVpazkjOQfpwSneoI2JXUDh3tGIpWGfPsd9HjIhc9+J4Fn4hPupTlLraHpGiEl0wMR+2tdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722126384; c=relaxed/simple;
	bh=T1d68LYJQ5PF2V9H1ruSPor7SPuyYu1pjOYSMUxNP3E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o+VSmNxg5wamADr5kPfEy1BEoRz0n3V9iiAfEKzMukXN0etywf6FDcg907okjm1qkamJJc92Zo52ivN/jRz6VPRM1vid7YDabKp1NR1HNwmJ152CuQVe8Xwxc5s3ost6Kd8ooF9bze69mvzy0HFU8bpP6Tgij11jBHBzv0qOuuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WWj1x3rqDzncqF;
	Sun, 28 Jul 2024 08:25:25 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id C15891800A4;
	Sun, 28 Jul 2024 08:26:19 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 08:26:18 +0800
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH v1 4/9] selftests/landlock: Test listening restriction
Date: Sun, 28 Jul 2024 08:25:57 +0800
Message-ID: <20240728002602.3198398-5-ivanov.mikhail1@huawei-partners.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240728002602.3198398-1-ivanov.mikhail1@huawei-partners.com>
References: <20240728002602.3198398-1-ivanov.mikhail1@huawei-partners.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100004.china.huawei.com (7.188.51.133) To
 dggpemm500020.china.huawei.com (7.185.36.49)

Add a test for listening restriction. It's similar to protocol.bind and
protocol.connect tests.

Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
 tools/testing/selftests/landlock/net_test.c | 44 +++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/tools/testing/selftests/landlock/net_test.c b/tools/testing/selftests/landlock/net_test.c
index 8126f5c0160f..b6fe9bde205f 100644
--- a/tools/testing/selftests/landlock/net_test.c
+++ b/tools/testing/selftests/landlock/net_test.c
@@ -689,6 +689,50 @@ TEST_F(protocol, connect)
 				    restricted, restricted);
 }
 
+TEST_F(protocol, listen)
+{
+	if (variant->sandbox == TCP_SANDBOX) {
+		const struct landlock_ruleset_attr ruleset_attr = {
+			.handled_access_net = ACCESS_ALL,
+		};
+		const struct landlock_net_port_attr tcp_not_restricted_p0 = {
+			.allowed_access = ACCESS_ALL,
+			.port = self->srv0.port,
+		};
+		const struct landlock_net_port_attr tcp_denied_listen_p1 = {
+			.allowed_access = ACCESS_ALL &
+					  ~LANDLOCK_ACCESS_NET_LISTEN_TCP,
+			.port = self->srv1.port,
+		};
+		int ruleset_fd;
+
+		ruleset_fd = landlock_create_ruleset(&ruleset_attr,
+						     sizeof(ruleset_attr), 0);
+		ASSERT_LE(0, ruleset_fd);
+
+		/* Allows all actions for the first port. */
+		ASSERT_EQ(0,
+			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					    &tcp_not_restricted_p0, 0));
+
+		/* Allows all actions despite listen. */
+		ASSERT_EQ(0,
+			  landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+					    &tcp_denied_listen_p1, 0));
+
+		enforce_ruleset(_metadata, ruleset_fd);
+		EXPECT_EQ(0, close(ruleset_fd));
+	}
+	bool restricted = is_restricted(&variant->prot, variant->sandbox);
+
+	test_restricted_net_fixture(_metadata, &self->srv0, false, false,
+				    false);
+	test_restricted_net_fixture(_metadata, &self->srv1, false, false,
+				    restricted);
+	test_restricted_net_fixture(_metadata, &self->srv2, restricted,
+				    restricted, restricted);
+}
+
 TEST_F(protocol, bind_unspec)
 {
 	const struct landlock_ruleset_attr ruleset_attr = {
-- 
2.34.1


