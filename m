Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A376A5F00DE
	for <lists+netfilter-devel@lfdr.de>; Fri, 30 Sep 2022 00:44:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiI2Woq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 29 Sep 2022 18:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbiI2WoR (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 29 Sep 2022 18:44:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9071433A30;
        Thu, 29 Sep 2022 15:39:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28609B825A3;
        Thu, 29 Sep 2022 22:39:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52C10C433C1;
        Thu, 29 Sep 2022 22:39:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664491151;
        bh=29HN+Rv+VZ3PFuX44hWHmZRwTOtS8XCGC3jCwioz1D4=;
        h=From:To:Cc:Subject:Date:From;
        b=Yf945YNC5iyjj5CDk3Yy+uu0w/g8xYEhO003Emd2MLH/GWrreR+WdRNAEKg5ho5rB
         InnGaa8OywU6sJO1cJh3NUFxLJ0rF5wucuFqXB35AukBl60PPbK6wElqgzyfq0pG1X
         /JbJtBO3O/N1z6uc5JzeeUrng1AEagKqAEeLCbZIlNs+bKJztfAT7n+jBCeUum99V0
         V/xif0MsjkU2uTpzDJIQJE8agHVVnSNOAvyMlSmaXz4YXayFMk6o/PovU5irjIjdZC
         /sN68YvctG1nsob0QIRqt7/JOXceP+cxHtMNTK0limFtvjv4+l6PeQipd09Xuz46Nb
         XFFqtuwQeHOuw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, davem@davemloft.net, kuba@kernel.org,
        edumazet@google.com, pabeni@redhat.com, pablo@netfilter.org,
        fw@strlen.de, netfilter-devel@vger.kernel.org,
        lorenzo.bianconi@redhat.com, brouer@redhat.com, toke@redhat.com,
        memxor@gmail.com, nathan@kernel.org, martin.lau@linux.dev,
        ykaliuta@redhat.com
Subject: [PATCH v2 bpf-next] net: netfilter: move bpf_ct_set_nat_info kfunc in nf_nat_bpf.c
Date:   Fri, 30 Sep 2022 00:38:43 +0200
Message-Id: <51a65513d2cda3eeb0754842e8025ab3966068d8.1664490511.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remove circular dependency between nf_nat module and nf_conntrack one
moving bpf_ct_set_nat_info kfunc in nf_nat_bpf.c

Fixes: 0fabd2aa199f ("net: netfilter: add bpf_ct_set_nat_info kfunc helper")
Suggested-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Yauheni Kaliuta <ykaliuta@redhat.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move register_nf_nat_bpf declaration in nf_conntrack_bpf.h
---
 include/net/netfilter/nf_conntrack_bpf.h | 19 ++++++
 net/netfilter/Makefile                   |  6 ++
 net/netfilter/nf_conntrack_bpf.c         | 50 ---------------
 net/netfilter/nf_nat_bpf.c               | 79 ++++++++++++++++++++++++
 net/netfilter/nf_nat_core.c              |  4 +-
 5 files changed, 106 insertions(+), 52 deletions(-)
 create mode 100644 net/netfilter/nf_nat_bpf.c

diff --git a/include/net/netfilter/nf_conntrack_bpf.h b/include/net/netfilter/nf_conntrack_bpf.h
index c8b80add1142..2d0da478c8e0 100644
--- a/include/net/netfilter/nf_conntrack_bpf.h
+++ b/include/net/netfilter/nf_conntrack_bpf.h
@@ -4,6 +4,11 @@
 #define _NF_CONNTRACK_BPF_H
 
 #include <linux/kconfig.h>
+#include <net/netfilter/nf_conntrack.h>
+
+struct nf_conn___init {
+	struct nf_conn ct;
+};
 
 #if (IS_BUILTIN(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
     (IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
@@ -24,4 +29,18 @@ static inline void cleanup_nf_conntrack_bpf(void)
 
 #endif
 
+#if (IS_BUILTIN(CONFIG_NF_NAT) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF)) || \
+    (IS_MODULE(CONFIG_NF_NAT) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES))
+
+extern int register_nf_nat_bpf(void);
+
+#else
+
+static inline int register_nf_nat_bpf(void)
+{
+	return 0;
+}
+
+#endif
+
 #endif /* _NF_CONNTRACK_BPF_H */
diff --git a/net/netfilter/Makefile b/net/netfilter/Makefile
index 06df49ea6329..0f060d100880 100644
--- a/net/netfilter/Makefile
+++ b/net/netfilter/Makefile
@@ -60,6 +60,12 @@ obj-$(CONFIG_NF_NAT) += nf_nat.o
 nf_nat-$(CONFIG_NF_NAT_REDIRECT) += nf_nat_redirect.o
 nf_nat-$(CONFIG_NF_NAT_MASQUERADE) += nf_nat_masquerade.o
 
+ifeq ($(CONFIG_NF_NAT),m)
+nf_nat-$(CONFIG_DEBUG_INFO_BTF_MODULES) += nf_nat_bpf.o
+else ifeq ($(CONFIG_NF_NAT),y)
+nf_nat-$(CONFIG_DEBUG_INFO_BTF) += nf_nat_bpf.o
+endif
+
 # NAT helpers
 obj-$(CONFIG_NF_NAT_AMANDA) += nf_nat_amanda.o
 obj-$(CONFIG_NF_NAT_FTP) += nf_nat_ftp.o
diff --git a/net/netfilter/nf_conntrack_bpf.c b/net/netfilter/nf_conntrack_bpf.c
index 756ea818574e..8639e7efd0e2 100644
--- a/net/netfilter/nf_conntrack_bpf.c
+++ b/net/netfilter/nf_conntrack_bpf.c
@@ -14,10 +14,8 @@
 #include <linux/types.h>
 #include <linux/btf_ids.h>
 #include <linux/net_namespace.h>
-#include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_bpf.h>
 #include <net/netfilter/nf_conntrack_core.h>
-#include <net/netfilter/nf_nat.h>
 
 /* bpf_ct_opts - Options for CT lookup helpers
  *
@@ -239,10 +237,6 @@ __diag_push();
 __diag_ignore_all("-Wmissing-prototypes",
 		  "Global functions as their definitions will be in nf_conntrack BTF");
 
-struct nf_conn___init {
-	struct nf_conn ct;
-};
-
 /* bpf_xdp_ct_alloc - Allocate a new CT entry
  *
  * Parameters:
@@ -476,49 +470,6 @@ int bpf_ct_change_status(struct nf_conn *nfct, u32 status)
 	return nf_ct_change_status_common(nfct, status);
 }
 
-/* bpf_ct_set_nat_info - Set source or destination nat address
- *
- * Set source or destination nat address of the newly allocated
- * nf_conn before insertion. This must be invoked for referenced
- * PTR_TO_BTF_ID to nf_conn___init.
- *
- * Parameters:
- * @nfct	- Pointer to referenced nf_conn object, obtained using
- *		  bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
- * @addr	- Nat source/destination address
- * @port	- Nat source/destination port. Non-positive values are
- *		  interpreted as select a random port.
- * @manip	- NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
- */
-int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
-			union nf_inet_addr *addr, int port,
-			enum nf_nat_manip_type manip)
-{
-#if ((IS_MODULE(CONFIG_NF_NAT) && IS_MODULE(CONFIG_NF_CONNTRACK)) || \
-     IS_BUILTIN(CONFIG_NF_NAT))
-	struct nf_conn *ct = (struct nf_conn *)nfct;
-	u16 proto = nf_ct_l3num(ct);
-	struct nf_nat_range2 range;
-
-	if (proto != NFPROTO_IPV4 && proto != NFPROTO_IPV6)
-		return -EINVAL;
-
-	memset(&range, 0, sizeof(struct nf_nat_range2));
-	range.flags = NF_NAT_RANGE_MAP_IPS;
-	range.min_addr = *addr;
-	range.max_addr = range.min_addr;
-	if (port > 0) {
-		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
-		range.min_proto.all = cpu_to_be16(port);
-		range.max_proto.all = range.min_proto.all;
-	}
-
-	return nf_nat_setup_info(ct, &range, manip) == NF_DROP ? -ENOMEM : 0;
-#else
-	return -EOPNOTSUPP;
-#endif
-}
-
 __diag_pop()
 
 BTF_SET8_START(nf_ct_kfunc_set)
@@ -532,7 +483,6 @@ BTF_ID_FLAGS(func, bpf_ct_set_timeout, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_change_timeout, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_set_status, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_ct_change_status, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
 BTF_SET8_END(nf_ct_kfunc_set)
 
 static const struct btf_kfunc_id_set nf_conntrack_kfunc_set = {
diff --git a/net/netfilter/nf_nat_bpf.c b/net/netfilter/nf_nat_bpf.c
new file mode 100644
index 000000000000..0fa5a0bbb0ff
--- /dev/null
+++ b/net/netfilter/nf_nat_bpf.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Unstable NAT Helpers for XDP and TC-BPF hook
+ *
+ * These are called from the XDP and SCHED_CLS BPF programs. Note that it is
+ * allowed to break compatibility for these functions since the interface they
+ * are exposed through to BPF programs is explicitly unstable.
+ */
+
+#include <linux/bpf.h>
+#include <linux/btf_ids.h>
+#include <net/netfilter/nf_conntrack_bpf.h>
+#include <net/netfilter/nf_conntrack_core.h>
+#include <net/netfilter/nf_nat.h>
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global functions as their definitions will be in nf_nat BTF");
+
+/* bpf_ct_set_nat_info - Set source or destination nat address
+ *
+ * Set source or destination nat address of the newly allocated
+ * nf_conn before insertion. This must be invoked for referenced
+ * PTR_TO_BTF_ID to nf_conn___init.
+ *
+ * Parameters:
+ * @nfct	- Pointer to referenced nf_conn object, obtained using
+ *		  bpf_xdp_ct_alloc or bpf_skb_ct_alloc.
+ * @addr	- Nat source/destination address
+ * @port	- Nat source/destination port. Non-positive values are
+ *		  interpreted as select a random port.
+ * @manip	- NF_NAT_MANIP_SRC or NF_NAT_MANIP_DST
+ */
+int bpf_ct_set_nat_info(struct nf_conn___init *nfct,
+			union nf_inet_addr *addr, int port,
+			enum nf_nat_manip_type manip)
+{
+	struct nf_conn *ct = (struct nf_conn *)nfct;
+	u16 proto = nf_ct_l3num(ct);
+	struct nf_nat_range2 range;
+
+	if (proto != NFPROTO_IPV4 && proto != NFPROTO_IPV6)
+		return -EINVAL;
+
+	memset(&range, 0, sizeof(struct nf_nat_range2));
+	range.flags = NF_NAT_RANGE_MAP_IPS;
+	range.min_addr = *addr;
+	range.max_addr = range.min_addr;
+	if (port > 0) {
+		range.flags |= NF_NAT_RANGE_PROTO_SPECIFIED;
+		range.min_proto.all = cpu_to_be16(port);
+		range.max_proto.all = range.min_proto.all;
+	}
+
+	return nf_nat_setup_info(ct, &range, manip) == NF_DROP ? -ENOMEM : 0;
+}
+
+__diag_pop()
+
+BTF_SET8_START(nf_nat_kfunc_set)
+BTF_ID_FLAGS(func, bpf_ct_set_nat_info, KF_TRUSTED_ARGS)
+BTF_SET8_END(nf_nat_kfunc_set)
+
+static const struct btf_kfunc_id_set nf_bpf_nat_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &nf_nat_kfunc_set,
+};
+
+int register_nf_nat_bpf(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP,
+					&nf_bpf_nat_kfunc_set);
+	if (ret)
+		return ret;
+
+	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS,
+					 &nf_bpf_nat_kfunc_set);
+}
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 7981be526f26..d8e6380f6337 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -16,7 +16,7 @@
 #include <linux/siphash.h>
 #include <linux/rtnetlink.h>
 
-#include <net/netfilter/nf_conntrack.h>
+#include <net/netfilter/nf_conntrack_bpf.h>
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
@@ -1152,7 +1152,7 @@ static int __init nf_nat_init(void)
 	WARN_ON(nf_nat_hook != NULL);
 	RCU_INIT_POINTER(nf_nat_hook, &nat_hook);
 
-	return 0;
+	return register_nf_nat_bpf();
 }
 
 static void __exit nf_nat_cleanup(void)
-- 
2.37.3

