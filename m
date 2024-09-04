Return-Path: <netfilter-devel+bounces-3693-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C9896B936
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89BD7B24288
	for <lists+netfilter-devel@lfdr.de>; Wed,  4 Sep 2024 10:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC201D460E;
	Wed,  4 Sep 2024 10:49:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DC91CF7B1;
	Wed,  4 Sep 2024 10:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725446950; cv=none; b=NfVBuy5T2QX5iYES1HCDzvhaDEoWynTyayd4sRwKPl0+URZc4zTbfNjx5/E9o97yG+4NzuiCm2eDjVHo2eKTdWKj97iTs8/LbGvLcpuzYSccJBMHxHgyCblTKWutMXWxN1YRw0UMQVUS1EUztytPW5WgpSyvydfpzQydxX1IhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725446950; c=relaxed/simple;
	bh=320TKFw25kQyKSDRTjKicEFKtLjUgdWcjO8fDh6C8ts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oTyx8cOfJDNncGgxzZM/1TwOVLz04OqGlLCTFWH7J40Ff1mJg/Oo+gQEIMPkyyxSn5qBnbnwePeVaiazk5vTbDs0pAFjQIzdk98tN5XAVEqSty/MtcY8YfzWHzwNVUPaVfIvgmlRxg5fr/xAdZZw5cUiV0rh/HtcEyYvZlQ1nuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com; spf=pass smtp.mailfrom=huawei-partners.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei-partners.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4WzK1j3hT9z1xwMM;
	Wed,  4 Sep 2024 18:47:05 +0800 (CST)
Received: from kwepemj200016.china.huawei.com (unknown [7.202.194.28])
	by mail.maildlp.com (Postfix) with ESMTPS id 463961400D7;
	Wed,  4 Sep 2024 18:49:06 +0800 (CST)
Received: from mscphis02103.huawei.com (10.123.65.215) by
 kwepemj200016.china.huawei.com (7.202.194.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 4 Sep 2024 18:49:04 +0800
From: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
To: <mic@digikod.net>
CC: <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
	<linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
	<netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
	<artem.kuzin@huawei.com>, <konstantin.meskhidze@huawei.com>
Subject: [RFC PATCH v3 19/19] landlock: Document socket rule type support
Date: Wed, 4 Sep 2024 18:48:24 +0800
Message-ID: <20240904104824.1844082-20-ivanov.mikhail1@huawei-partners.com>
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

Extend documentation with socket rule type description.

Signed-off-by: Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>
---
 Documentation/userspace-api/landlock.rst | 46 ++++++++++++++++++++----
 1 file changed, 40 insertions(+), 6 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index 37dafce8038b..4bf45064faa1 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -33,7 +33,7 @@ A Landlock rule describes an action on an object which the process intends to
 perform.  A set of rules is aggregated in a ruleset, which can then restrict
 the thread enforcing it, and its future children.
 
-The two existing types of rules are:
+The three existing types of rules are:
 
 Filesystem rules
     For these rules, the object is a file hierarchy,
@@ -44,14 +44,19 @@ Network rules (since ABI v4)
     For these rules, the object is a TCP port,
     and the related actions are defined with `network access rights`.
 
+Socket rules (since ABI v6)
+    For these rules, the object is a pair of an address family and a socket type,
+    and the related actions are defined with `socket access rights`.
+
 Defining and enforcing a security policy
 ----------------------------------------
 
 We first need to define the ruleset that will contain our rules.
 
 For this example, the ruleset will contain rules that only allow filesystem
-read actions and establish a specific TCP connection. Filesystem write
-actions and other TCP actions will be denied.
+read actions, create TCP sockets and establish a specific TCP connection.
+Filesystem write actions, creating non-TCP sockets and other TCP
+actions will be denied.
 
 The ruleset then needs to handle both these kinds of actions.  This is
 required for backward and forward compatibility (i.e. the kernel and user
@@ -81,6 +86,8 @@ to be explicit about the denied-by-default access rights.
         .handled_access_net =
             LANDLOCK_ACCESS_NET_BIND_TCP |
             LANDLOCK_ACCESS_NET_CONNECT_TCP,
+        .handled_access_socket =
+            LANDLOCK_ACCESS_SOCKET_CREATE,
     };
 
 Because we may not know on which kernel version an application will be
@@ -119,6 +126,11 @@ version, and only use the available subset of access rights:
     case 4:
         /* Removes LANDLOCK_ACCESS_FS_IOCTL_DEV for ABI < 5 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_IOCTL_DEV;
+        __attribute__((fallthrough));
+	case 5:
+		/* Removes socket support for ABI < 6 */
+		ruleset_attr.handled_access_socket &=
+			~LANDLOCK_ACCESS_SOCKET_CREATE;
     }
 
 This enables to create an inclusive ruleset that will contain our rules.
@@ -170,6 +182,20 @@ for the ruleset creation, by filtering access rights according to the Landlock
 ABI version.  In this example, this is not required because all of the requested
 ``allowed_access`` rights are already available in ABI 1.
 
+For socket access-control, we can add a rule to allow TCP sockets creation. UNIX,
+UDP IP and other protocols will be denied by the ruleset.
+
+.. code-block:: c
+
+    struct landlock_net_port_attr tcp_socket = {
+        .allowed_access = LANDLOCK_ACCESS_SOCKET_CREATE,
+        .family = AF_INET,
+        .type = SOCK_STREAM,
+    };
+
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_SOCKET,
+                            &tcp_socket, 0);
+
 For network access-control, we can add a set of rules that allow to use a port
 number for a specific action: HTTPS connections.
 
@@ -186,7 +212,8 @@ number for a specific action: HTTPS connections.
 The next step is to restrict the current thread from gaining more privileges
 (e.g. through a SUID binary).  We now have a ruleset with the first rule
 allowing read access to ``/usr`` while denying all other handled accesses for
-the filesystem, and a second rule allowing HTTPS connections.
+the filesystem, a second rule allowing TCP sockets and a third rule allowing
+HTTPS connections.
 
 .. code-block:: c
 
@@ -404,7 +431,7 @@ Access rights
 -------------
 
 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access net_access
+    :identifiers: fs_access net_access socket_access
 
 Creating a new ruleset
 ----------------------
@@ -423,7 +450,7 @@ Extending a ruleset
 
 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
-                  landlock_net_port_attr
+                  landlock_net_port_attr landlock_socket_attr
 
 Enforcing a ruleset
 -------------------
@@ -541,6 +568,13 @@ earlier ABI.
 Starting with the Landlock ABI version 5, it is possible to restrict the use of
 :manpage:`ioctl(2)` using the new ``LANDLOCK_ACCESS_FS_IOCTL_DEV`` right.
 
+Socket support (ABI < 6)
+-------------------------
+
+Starting with the Landlock ABI version 6, it is now possible to restrict
+creation of user space sockets to only a set of allowed protocols thanks
+to the new ``LANDLOCK_ACCESS_SOCKET_CREATE`` access right.
+
 .. _kernel_support:
 
 Kernel support
-- 
2.34.1


