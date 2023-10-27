Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CC17D9D48
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Oct 2023 17:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346172AbjJ0Pqi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Oct 2023 11:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346188AbjJ0Pqh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Oct 2023 11:46:37 -0400
Received: from smtp-190c.mail.infomaniak.ch (smtp-190c.mail.infomaniak.ch [IPv6:2001:1600:4:17::190c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44851192
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Oct 2023 08:46:34 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4SH6Tg5Vp7zMq8TT;
        Fri, 27 Oct 2023 15:46:31 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4SH6Tg1m6CzMpp9q;
        Fri, 27 Oct 2023 17:46:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1698421591;
        bh=SNlk9IazPeKmar0eikDYYJcTfW9nhEhrpsIBijS58+w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xE5W2a8+vtnkiU52ZTX2uEamZH9d0oNP95hI5AfmADmMhzaccIka/I49agY9kAwPj
         1fK3NqRd3H6xP4gyHakGY3LOu547kqynsbtfIpY73VQahiwIZyC8lD2aPuBNxpes47
         4Yqbv/D0QGg08nD9RAkoAle8Y4WP5FQWuqwRAMto=
From:   =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        artem.kuzin@huawei.com, gnoack3000@gmail.com,
        willemdebruijn.kernel@gmail.com, yusongping@huawei.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Subject: [PATCH] selftests/landlock: Add tests for FS topology changes with network rules
Date:   Fri, 27 Oct 2023 17:46:15 +0200
Message-ID: <20231027154615.815134-1-mic@digikod.net>
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add 2 tests to the layout1 fixture:
* topology_changes_with_net_only: Checks that FS topology
  changes are not denied by network-only restrictions.
* topology_changes_with_net_and_fs: Make sure that FS topology
  changes are still denied with FS and network restrictions.

This specifically test commit d7220364039f ("landlock: Allow FS topology
changes for domains without such rule type").

Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/fs_test.c | 59 ++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
index 68b7a89cf65b..18e1f86a6234 100644
--- a/tools/testing/selftests/landlock/fs_test.c
+++ b/tools/testing/selftests/landlock/fs_test.c
@@ -1625,6 +1625,65 @@ TEST_F_FORK(layout1, move_mount)
 	clear_cap(_metadata, CAP_SYS_ADMIN);
 }
 
+TEST_F_FORK(layout1, topology_changes_with_net_only)
+{
+	const struct landlock_ruleset_attr ruleset_net = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+	};
+	int ruleset_fd;
+
+	/* Add network restrictions. */
+	ruleset_fd =
+		landlock_create_ruleset(&ruleset_net, sizeof(ruleset_net), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Mount, remount, move_mount, umount, and pivot_root checks. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(0, mount_opt(&mnt_tmp, dir_s1d2));
+	ASSERT_EQ(0, mount(NULL, dir_s1d2, NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(0, syscall(__NR_move_mount, AT_FDCWD, dir_s1d2, AT_FDCWD,
+			     dir_s2d2, 0));
+	ASSERT_EQ(0, umount(dir_s2d2));
+	ASSERT_EQ(0, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(0, chdir("/"));
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
+TEST_F_FORK(layout1, topology_changes_with_net_and_fs)
+{
+	const struct landlock_ruleset_attr ruleset_net_fs = {
+		.handled_access_net = LANDLOCK_ACCESS_NET_BIND_TCP |
+				      LANDLOCK_ACCESS_NET_CONNECT_TCP,
+		.handled_access_fs = LANDLOCK_ACCESS_FS_EXECUTE,
+	};
+	int ruleset_fd;
+
+	/* Add network and filesystem restrictions. */
+	ruleset_fd = landlock_create_ruleset(&ruleset_net_fs,
+					     sizeof(ruleset_net_fs), 0);
+	ASSERT_LE(0, ruleset_fd);
+	enforce_ruleset(_metadata, ruleset_fd);
+	ASSERT_EQ(0, close(ruleset_fd));
+
+	/* Mount, remount, move_mount, umount, and pivot_root checks. */
+	set_cap(_metadata, CAP_SYS_ADMIN);
+	ASSERT_EQ(-1, mount_opt(&mnt_tmp, dir_s1d2));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, mount(NULL, dir_s3d2, NULL, MS_PRIVATE | MS_REC, NULL));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, syscall(__NR_move_mount, AT_FDCWD, dir_s3d2, AT_FDCWD,
+			      dir_s2d2, 0));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, umount(dir_s3d2));
+	ASSERT_EQ(EPERM, errno);
+	ASSERT_EQ(-1, syscall(__NR_pivot_root, dir_s3d2, dir_s3d3));
+	ASSERT_EQ(EPERM, errno);
+	clear_cap(_metadata, CAP_SYS_ADMIN);
+}
+
 TEST_F_FORK(layout1, release_inodes)
 {
 	const struct rule rules[] = {
-- 
2.42.0

