Return-Path: <netfilter-devel+bounces-3098-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C521793E196
	for <lists+netfilter-devel@lfdr.de>; Sun, 28 Jul 2024 02:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80C28281C47
	for <lists+netfilter-devel@lfdr.de>; Sun, 28 Jul 2024 00:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD23E25622;
	Sun, 28 Jul 2024 00:26:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC661E519;
	Sun, 28 Jul 2024 00:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722126392; cv=none; b=sx8UEU2SUOjd2Ll8TlRHXDATthz+jcMIOMcKwaOL+2FvIZw8UMaW+8ZvV0rUgZVUmjtuNWLeFK7u4z6XD5z1H6PKR7Ymf1hVAvdarwes6t8vzJIiWfVxp8SYiKhcppEi8sUarrPvgi1A3uy9HtXgYSYg7+vuFVONpdPQS69cQjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722126392; c=relaxed/simple;
	bh=rSiJD6CB325ZcboYhNJAZRZM+QHB/FdTNMAAaT83eAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aH4HOGxsB8cTLNVa0mMiIT/t86bEDcvWZtNHRW26Q4pu3m7P5Zq56j549STVH2hb9yiULJ9YkZ8yRYTGK1JaxCfynZv2NhV/X+XZnJxR0PYEShR3gcq8pxLHfosgOcoGDuWGMCJ84swUE13F7yeP2u9Qp50254J4vPPwlCHJYQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WWj313BXCzxVXS;
	Sun, 28 Jul 2024 08:26:21 +0800 (CST)
Received: from dggpemm500020.china.huawei.com (unknown [7.185.36.49])
	by mail.maildlp.com (Postfix) with ESMTPS id 856FB180064;
	Sun, 28 Jul 2024 08:26:28 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sun, 28 Jul 2024 08:26:26 +0800
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH v1 9/9] samples/landlock: Support LANDLOCK_ACCESS_NET_LISTEN
Date: Sun, 28 Jul 2024 08:26:02 +0800
Message-ID: <20240728002602.3198398-10-ivanov.mikhail1@huawei-partners.com>
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

Extend sample with TCP listen control logic.

Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
 samples/landlock/sandboxer.c | 31 ++++++++++++++++++++++++++-----
 1 file changed, 26 insertions(+), 5 deletions(-)

diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
index e8223c3e781a..3f50cb3f8039 100644
--- a/samples/landlock/sandboxer.c
+++ b/samples/landlock/sandboxer.c
@@ -55,6 +55,7 @@ static inline int landlock_restrict_self(const int ruleset_fd,
 #define ENV_FS_RW_NAME "LL_FS_RW"
 #define ENV_TCP_BIND_NAME "LL_TCP_BIND"
 #define ENV_TCP_CONNECT_NAME "LL_TCP_CONNECT"
+#define ENV_TCP_LISTEN_NAME "LL_TCP_LISTEN"
 #define ENV_DELIMITER ":"
 
 static int parse_path(char *env_path, const char ***const path_list)
@@ -208,7 +209,7 @@ static int populate_ruleset_net(const char *const env_var, const int ruleset_fd,
 
 /* clang-format on */
 
-#define LANDLOCK_ABI_LAST 5
+#define LANDLOCK_ABI_LAST 6
 
 int main(const int argc, char *const argv[], char *const *const envp)
 {
@@ -222,15 +223,16 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	struct landlock_ruleset_attr ruleset_attr = {
 		.handled_access_fs = access_fs_rw,
 		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
-				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP |
+				      LANDLOCK_ACCESS_NET_LISTEN_TCP,
 	};
 
 	if (argc < 2) {
 		fprintf(stderr,
-			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
+			"usage: %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\" %s=\"...\"%s "
 			"<cmd> [args]...\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
+			ENV_TCP_CONNECT_NAME, ENV_TCP_LISTEN_NAME, argv[0]);
 		fprintf(stderr,
 			"Execute a command in a restricted environment.\n\n");
 		fprintf(stderr,
@@ -251,15 +253,19 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		fprintf(stderr,
 			"* %s: list of ports allowed to connect (client).\n",
 			ENV_TCP_CONNECT_NAME);
+		fprintf(stderr,
+			"* %s: list of ports allowed to listen (server).\n",
+			ENV_TCP_LISTEN_NAME);
 		fprintf(stderr,
 			"\nexample:\n"
 			"%s=\"${PATH}:/lib:/usr:/proc:/etc:/dev/urandom\" "
 			"%s=\"/dev/null:/dev/full:/dev/zero:/dev/pts:/tmp\" "
 			"%s=\"9418\" "
 			"%s=\"80:443\" "
+			"%s=\"9418\" "
 			"%s bash -i\n\n",
 			ENV_FS_RO_NAME, ENV_FS_RW_NAME, ENV_TCP_BIND_NAME,
-			ENV_TCP_CONNECT_NAME, argv[0]);
+			ENV_TCP_CONNECT_NAME, ENV_TCP_LISTEN_NAME, argv[0]);
 		fprintf(stderr,
 			"This sandboxer can use Landlock features "
 			"up to ABI version %d.\n",
@@ -326,6 +332,11 @@ int main(const int argc, char *const argv[], char *const *const envp)
 	case 4:
 		/* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
 		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+		__attribute__((fallthrough));
+	case 5:
+		/* Removes LANDLOCK_ACCESS_NET_LISTEN support for ABI < 6 */
+		ruleset_attr.handled_access_net &=
+			~(LANDLOCK_ACCESS_NET_LISTEN_TCP);
 
 		fprintf(stderr,
 			"Hint: You should update the running kernel "
@@ -357,6 +368,12 @@ int main(const int argc, char *const argv[], char *const *const envp)
 		ruleset_attr.handled_access_net &=
 			~LANDLOCK_ACCESS_NET_CONNECT_TCP;
 	}
+	/* Removes listen access attribute if not supported by a user. */
+	env_port_name = getenv(ENV_TCP_LISTEN_NAME);
+	if (!env_port_name) {
+		ruleset_attr.handled_access_net &=
+			~LANDLOCK_ACCESS_NET_LISTEN_TCP;
+	}
 
 	ruleset_fd =
 		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);
@@ -380,6 +397,10 @@ int main(const int argc, char *const argv[], char *const *const envp)
 				 LANDLOCK_ACCESS_NET_CONNECT_TCP)) {
 		goto err_close_ruleset;
 	}
+	if (populate_ruleset_net(ENV_TCP_LISTEN_NAME, ruleset_fd,
+				 LANDLOCK_ACCESS_NET_LISTEN_TCP)) {
+		goto err_close_ruleset;
+	}
 
 	if (prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0)) {
 		perror("Failed to restrict privileges");
-- 
2.34.1


