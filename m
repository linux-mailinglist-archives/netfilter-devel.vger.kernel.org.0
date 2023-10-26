Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D9E7D7A71
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Oct 2023 03:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233041AbjJZBsm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Oct 2023 21:48:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbjJZBsa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:48:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628A5CE;
        Wed, 25 Oct 2023 18:48:27 -0700 (PDT)
Received: from lhrpeml500004.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SG7st6Z4rz6K5T5;
        Thu, 26 Oct 2023 09:45:38 +0800 (CST)
Received: from mscphis00759.huawei.com (10.123.66.134) by
 lhrpeml500004.china.huawei.com (7.191.163.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Thu, 26 Oct 2023 02:48:24 +0100
From:   Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
To:     <mic@digikod.net>
CC:     <willemdebruijn.kernel@gmail.com>, <gnoack3000@gmail.com>,
        <linux-security-module@vger.kernel.org>, <netdev@vger.kernel.org>,
        <netfilter-devel@vger.kernel.org>, <yusongping@huawei.com>,
        <artem.kuzin@huawei.com>
Subject: [PATCH v14 12/12] landlock: Document network support
Date:   Thu, 26 Oct 2023 09:47:51 +0800
Message-ID: <20231026014751.414649-13-konstantin.meskhidze@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
References: <20231026014751.414649-1-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.123.66.134]
X-ClientProxiedBy: mscpeml500002.china.huawei.com (7.188.26.138) To
 lhrpeml500004.china.huawei.com (7.191.163.9)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Describe network access rules for TCP sockets. Add network access
example in the tutorial. Add kernel configuration support for network.

Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v13:
* Fixes documentaion logic errors and typos according the review:
https://lore.kernel.org/netdev/20231017.Saiw5quoo5wa@digikod.net/
* Refactors commit message.

Changes since v12:
* None.

Changes since v11:
* Fixes documentaion as suggested in Günther's and Mickaёl's reviews:
https://lore.kernel.org/netdev/3ad02c76-90d8-4723-e554-7f97ef115fc0@digikod.net/

Changes since v10:
* Fixes documentaion as Mickaёl suggested:
https://lore.kernel.org/linux-security-module/ec23be77-566e-c8fd-179e-f50e025ac2cf@digikod.net/

Changes since v9:
* Minor refactoring.

Changes since v8:
* Minor refactoring.

Changes since v7:
* Fixes documentaion logic errors and typos as Mickaёl suggested:
https://lore.kernel.org/netdev/9f354862-2bc3-39ea-92fd-53803d9bbc21@digikod.net/

Changes since v6:
* Adds network support documentaion.

---
 Documentation/userspace-api/landlock.rst | 90 ++++++++++++++++++------
 1 file changed, 69 insertions(+), 21 deletions(-)

diff --git a/Documentation/userspace-api/landlock.rst b/Documentation/userspace-api/landlock.rst
index f6a7da21708a..4ac870923020 100644
--- a/Documentation/userspace-api/landlock.rst
+++ b/Documentation/userspace-api/landlock.rst
@@ -11,10 +11,10 @@ Landlock: unprivileged access control
 :Date: October 2022

 The goal of Landlock is to enable to restrict ambient rights (e.g. global
-filesystem access) for a set of processes.  Because Landlock is a stackable
-LSM, it makes possible to create safe security sandboxes as new security layers
-in addition to the existing system-wide access-controls. This kind of sandbox
-is expected to help mitigate the security impact of bugs or
+filesystem or network access) for a set of processes.  Because Landlock
+is a stackable LSM, it makes possible to create safe security sandboxes as new
+security layers in addition to the existing system-wide access-controls. This
+kind of sandbox is expected to help mitigate the security impact of bugs or
 unexpected/malicious behaviors in user space applications.  Landlock empowers
 any process, including unprivileged ones, to securely restrict themselves.

@@ -28,20 +28,34 @@ appropriately <kernel_support>`.
 Landlock rules
 ==============

-A Landlock rule describes an action on an object.  An object is currently a
-file hierarchy, and the related filesystem actions are defined with `access
-rights`_.  A set of rules is aggregated in a ruleset, which can then restrict
+A Landlock rule describes an action on an object which the process intends to
+perform.  A set of rules is aggregated in a ruleset, which can then restrict
 the thread enforcing it, and its future children.

+The two existing types of rules are:
+
+Filesystem rules
+    For these rules, the object is a file hierarchy,
+    and the related filesystem actions are defined with
+    `filesystem access rights`.
+
+Network rules (since ABI v4)
+    For these rules, the object is currently a TCP port,
+    and the related actions are defined with `network access rights`.
+
 Defining and enforcing a security policy
 ----------------------------------------

-We first need to define the ruleset that will contain our rules.  For this
-example, the ruleset will contain rules that only allow read actions, but write
-actions will be denied.  The ruleset then needs to handle both of these kind of
-actions.  This is required for backward and forward compatibility (i.e. the
-kernel and user space may not know each other's supported restrictions), hence
-the need to be explicit about the denied-by-default access rights.
+We first need to define the ruleset that will contain our rules.
+
+For this example, the ruleset will contain rules that only allow filesystem
+read actions and establish a specific TCP connection. Filesystem write
+actions and other TCP actions will be denied.
+
+The ruleset then needs to handle both these kinds of actions.  This is
+required for backward and forward compatibility (i.e. the kernel and user
+space may not know each other's supported restrictions), hence the need
+to be explicit about the denied-by-default access rights.

 .. code-block:: c

@@ -62,6 +76,9 @@ the need to be explicit about the denied-by-default access rights.
             LANDLOCK_ACCESS_FS_MAKE_SYM |
             LANDLOCK_ACCESS_FS_REFER |
             LANDLOCK_ACCESS_FS_TRUNCATE,
+        .handled_access_net =
+            LANDLOCK_ACCESS_NET_BIND_TCP |
+            LANDLOCK_ACCESS_NET_CONNECT_TCP,
     };

 Because we may not know on which kernel version an application will be
@@ -70,9 +87,7 @@ should try to protect users as much as possible whatever the kernel they are
 using.  To avoid binary enforcement (i.e. either all security features or
 none), we can leverage a dedicated Landlock command to get the current version
 of the Landlock ABI and adapt the handled accesses.  Let's check if we should
-remove the ``LANDLOCK_ACCESS_FS_REFER`` or ``LANDLOCK_ACCESS_FS_TRUNCATE``
-access rights, which are only supported starting with the second and third
-version of the ABI.
+remove access rights which are only supported in higher versions of the ABI.

 .. code-block:: c

@@ -92,6 +107,12 @@ version of the ABI.
     case 2:
         /* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
         ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
+        __attribute__((fallthrough));
+    case 3:
+        /* Removes network support for ABI < 4 */
+        ruleset_attr.handled_access_net &=
+            ~(LANDLOCK_ACCESS_NET_BIND_TCP |
+              LANDLOCK_ACCESS_NET_CONNECT_TCP);
     }

 This enables to create an inclusive ruleset that will contain our rules.
@@ -143,10 +164,23 @@ for the ruleset creation, by filtering access rights according to the Landlock
 ABI version.  In this example, this is not required because all of the requested
 ``allowed_access`` rights are already available in ABI 1.

-We now have a ruleset with one rule allowing read access to ``/usr`` while
-denying all other handled accesses for the filesystem.  The next step is to
-restrict the current thread from gaining more privileges (e.g. thanks to a SUID
-binary).
+For network access-control, we can add a set of rules that allow to use a port
+number for a specific action: HTTPS connections.
+
+.. code-block:: c
+
+    struct landlock_net_port_attr net_port = {
+        .allowed_access = LANDLOCK_ACCESS_NET_CONNECT_TCP,
+        .port = 443,
+    };
+
+    err = landlock_add_rule(ruleset_fd, LANDLOCK_RULE_NET_PORT,
+                            &net_port, 0);
+
+The next step is to restrict the current thread from gaining more privileges
+(e.g. through a SUID binary). We now have a ruleset with the first rule allowing
+read access to ``/usr`` while denying all other handled accesses for the filesystem,
+and a second rule allowing HTTPS connections.

 .. code-block:: c

@@ -355,7 +389,7 @@ Access rights
 -------------

 .. kernel-doc:: include/uapi/linux/landlock.h
-    :identifiers: fs_access
+    :identifiers: fs_access net_access

 Creating a new ruleset
 ----------------------
@@ -374,6 +408,7 @@ Extending a ruleset

 .. kernel-doc:: include/uapi/linux/landlock.h
     :identifiers: landlock_rule_type landlock_path_beneath_attr
+                  landlock_net_port_attr

 Enforcing a ruleset
 -------------------
@@ -451,6 +486,14 @@ always allowed when using a kernel that only supports the first or second ABI.
 Starting with the Landlock ABI version 3, it is now possible to securely control
 truncation thanks to the new ``LANDLOCK_ACCESS_FS_TRUNCATE`` access right.

+Network support (ABI < 4)
+-------------------------
+
+Starting with the Landlock ABI version 4, it is now possible to restrict TCP
+bind and connect actions to only a set of allowed ports thanks to the new
+``LANDLOCK_ACCESS_NET_BIND_TCP`` and ``LANDLOCK_ACCESS_NET_CONNECT_TCP``
+access rights.
+
 .. _kernel_support:

 Kernel support
@@ -469,6 +512,11 @@ still enable it by adding ``lsm=landlock,[...]`` to
 Documentation/admin-guide/kernel-parameters.rst thanks to the bootloader
 configuration.

+To be able to explicitly allow TCP operations (e.g., adding a network rule with
+``LANDLOCK_ACCESS_NET_BIND_TCP``), the kernel must support TCP (``CONFIG_INET=y``).
+Otherwise, sys_landlock_add_rule() returns an ``EAFNOSUPPORT`` error, which can
+safely be ignored because this kind of TCP operation is already not possible.
+
 Questions and answers
 =====================

--
2.25.1

