Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C133528875
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 May 2022 17:21:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245197AbiEPPVX (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 May 2022 11:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245227AbiEPPVF (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 May 2022 11:21:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE613BF81;
        Mon, 16 May 2022 08:20:57 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4L22t25XvXz67Klm;
        Mon, 16 May 2022 23:17:14 +0800 (CST)
Received: from mscphispre00059.huawei.com (10.123.71.64) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 16 May 2022 17:20:54 +0200
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <anton.sirazetdinov@huawei.com>
Subject: [PATCH v5 06/15] landlock: user space API network support
Date:   Mon, 16 May 2022 23:20:29 +0800
Message-ID: <20220516152038.39594-7-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220516152038.39594-1-konstantin.meskhidze@huawei.com>
References: <20220516152038.39594-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.123.71.64]
X-ClientProxiedBy: mscpeml500001.china.huawei.com (7.188.26.142) To
 fraeml704-chm.china.huawei.com (10.206.15.53)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

User space API was refactored to support
network actions. New network access flags,
network rule and network attributes were
added.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
---

Changes since v3:
* Split commit.
* Refactoring User API for network rule type.

Changes since v4:
* None

---
 include/uapi/linux/landlock.h | 48 +++++++++++++++++++++++++++++++++++
 security/landlock/syscalls.c  |  3 ++-
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
index 23df4e0e8ace..91d6cb359bf8 100644
--- a/include/uapi/linux/landlock.h
+++ b/include/uapi/linux/landlock.h
@@ -31,6 +31,13 @@ struct landlock_ruleset_attr {
 	 * this access right.
 	 */
 	__u64 handled_access_fs;
+
+	/**
+	 * @handled_access_net: Bitmask of actions (cf. `Network flags`_)
+	 * that is handled by this ruleset and should then be forbidden if no
+	 * rule explicitly allow them.
+	 */
+	__u64 handled_access_net;
 };

 /*
@@ -54,6 +61,11 @@ enum landlock_rule_type {
 	 * landlock_path_beneath_attr .
 	 */
 	LANDLOCK_RULE_PATH_BENEATH = 1,
+	/**
+	 * @LANDLOCK_RULE_NET_SERVICE: Type of a &struct
+	 * landlock_net_service_attr .
+	 */
+	LANDLOCK_RULE_NET_SERVICE = 2,
 };

 /**
@@ -79,6 +91,24 @@ struct landlock_path_beneath_attr {
 	 */
 } __attribute__((packed));

+/**
+ * struct landlock_net_service_attr - TCP subnet definition
+ *
+ * Argument of sys_landlock_add_rule().
+ */
+struct landlock_net_service_attr {
+	/**
+	 * @allowed_access: Bitmask of allowed access network for services
+	 * (cf. `Network flags`_).
+	 */
+	__u64 allowed_access;
+	/**
+	 * @port: Network port
+	 */
+	__u16 port;
+
+} __attribute__((packed));
+
 /**
  * DOC: fs_access
  *
@@ -162,4 +192,22 @@ struct landlock_path_beneath_attr {
 #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
 /* clang-format on */

+/**
+ * DOC: net_access
+ *
+ * Network flags
+ * ~~~~~~~~~~~~~~~~
+ *
+ * These flags enable to restrict a sandboxed process to a set of network
+ * actions.
+ *
+ * TCP sockets with allowed actions:
+ *
+ * - %LANDLOCK_ACCESS_NET_BIND_TCP: Bind a TCP socket to a local port.
+ * - %LANDLOCK_ACCESS_NET_CONNECT_TCP: Connect an active TCP socket to
+ *   a remote port.
+ */
+#define LANDLOCK_ACCESS_NET_BIND_TCP			(1ULL << 0)
+#define LANDLOCK_ACCESS_NET_CONNECT_TCP			(1ULL << 1)
+
 #endif /* _UAPI_LINUX_LANDLOCK_H */
diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 412ced6c512f..31f9facec123 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -82,8 +82,9 @@ static void build_check_abi(void)
 	 * struct size.
 	 */
 	ruleset_size = sizeof(ruleset_attr.handled_access_fs);
+	ruleset_size += sizeof(ruleset_attr.handled_access_net);
 	BUILD_BUG_ON(sizeof(ruleset_attr) != ruleset_size);
-	BUILD_BUG_ON(sizeof(ruleset_attr) != 8);
+	BUILD_BUG_ON(sizeof(ruleset_attr) != 16);

 	path_beneath_size = sizeof(path_beneath_attr.allowed_access);
 	path_beneath_size += sizeof(path_beneath_attr.parent_fd);
--
2.25.1

