Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEABF48EE71
	for <lists+netfilter-devel@lfdr.de>; Fri, 14 Jan 2022 17:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235224AbiANQkt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 14 Jan 2022 11:40:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbiANQkq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 14 Jan 2022 11:40:46 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7EDEC06161C;
        Fri, 14 Jan 2022 08:40:46 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id h23so3184975pgk.11;
        Fri, 14 Jan 2022 08:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZIxwcLAwiuhyGcSf5ZNjUlDsz0/bh88tzB/3+v7xeF4=;
        b=VTvBcJpNQar9IBWwC4NCZ4Ux56H2iqVsZAFAqUFmWXmwlHV+A6qKv3pvEWyOchUHZf
         od4KnXtKg6HE4D+ZIgvNbYggkI+UvVaxvfwTfjOpoRlA5TrvgTCzRwCWU/3TZ6qq940E
         5wiiYEXABVEC3GhocED/AuTsawr/Sa4BnGfTNjA2C6RAonXMh87G2ZRuZ/kKgOE4tMBb
         gPUvvglZEfLmq5P87aXgtCO5FXI39jC3+yLWF3WMKGU7JEfg8gOVnqSIlk2aqkux0fuA
         ui4yZkL86Thhdx7/P10OMRCaTt7kdar7ClnNQZmq3rh03us7MqrOGFRWI7jMiWsk5XWg
         qCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZIxwcLAwiuhyGcSf5ZNjUlDsz0/bh88tzB/3+v7xeF4=;
        b=ndjdq3PWccXAFq8kbFbMlUtRHM1YOLH6YdvIBYe1zcyYYnSzSluzBPjlM66m6x+Nr9
         A+nxUWKECWAbU0UH65bDQO1HmWAx1is5TYOWi501hrw016i01N7r0VCG+zGJUvmJZMDu
         0vsmhWYHR8QVEjpFBbXTJYGeoPJTtZ4Zs3sOEgQX/1KfsiN3Wx+6YOyxiD9DHL1JH3AX
         fFsC0XKa39x1k2tyXQMYTS2ZrEYs10+Z/M++Gnkx6iGkwP/8GtwO75WJawoH0EYBzbGr
         GCwx7NCEymbQigURkDEI34PoNiUvZAyev27ZqmZuR/hNCN1x3+m3bv9WFUNF1bhxTMus
         h09w==
X-Gm-Message-State: AOAM5312a6YWKAkgLG+AqJTI08fDfLrLkP5GQQNR586UurGQBj6BBljO
        GXlwT/yNpqYvANeRSQWbbMhkcgNwn3NR4A==
X-Google-Smtp-Source: ABdhPJwxpHU9U2wSpgZ2u7UidnOwtXaWm0TYMQR/BuoScT1J9f9cDLzrOxXEn3zKO8d4cFB1HNRPjQ==
X-Received: by 2002:a63:9356:: with SMTP id w22mr8778915pgm.449.1642178445760;
        Fri, 14 Jan 2022 08:40:45 -0800 (PST)
Received: from localhost ([2405:201:6014:d064:3d4e:6265:800c:dc84])
        by smtp.gmail.com with ESMTPSA id c24sm4704575pgj.57.2022.01.14.08.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 08:40:45 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Maxim Mikityanskiy <maximmi@nvidia.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [PATCH bpf-next v8 02/10] bpf: Populate kfunc BTF ID sets in struct btf
Date:   Fri, 14 Jan 2022 22:09:45 +0530
Message-Id: <20220114163953.1455836-3-memxor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114163953.1455836-1-memxor@gmail.com>
References: <20220114163953.1455836-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15652; h=from:subject; bh=hRI1ru+++6AlOEaiTw4Gm3Mqc/bnA6hh2j9ZhcvHXgQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBh4acUFo1wC3yj7bIL+ORpVkaAK12EW9sMy7fGrINx vapVoSuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCYeGnFAAKCRBM4MiGSL8RyipdEA CwiTP4IuOnF/0/loYYCEbVyRgyP6F4pIORMy7PyWwenVrrBPusEelx5vSTYRPyPol5xlbf4iOJcl3P c7GGpCVqfF1JvGI3LHbtD7hAcH/kDs0sRlHq/3PF6nSPX9A1GRoUYlY43nQxW5Fl0J6ZLavb855cml DmtOgbRICldfamF3a8UuNq+ZMGvt/CdD918R0VcLpt2fTu1sjSleO98ziT+waY9z5d4kX0JVRFc8zi WngFvYzBmQM70+kYN8PH3ATA9avprR8g5seXCZnCXY2cKIUiV+3VgSnJZg6qjjvqVOH3KvbWI0kF6E IddzcH0V9diRfNUBmfNnzSNjXDuDosWSJkieF2xgYLBHA1jhlCcCyqrORgaYbuR0AHxFWDgWppnMvz a9ar/S4c2UDJgYP78iAQBoKj6DBQsJIo0UuUZ6WGJItcb3fP6CPgqMQzimgsKqrybWZq1Iob6D+Fvh ZZMRYT6fWZVCuWFUkwOHspYWMkXYMkquWUuOKIz6dtRYyKIus0ZbUWTfh2hr4zzi/xHVhv0KWeVSP4 jKw1pn8n0RrNVn3mb0/5PWF+8hipPNwuKkaGnD28LPv2+XI1iRbCki0Jpju2LTxo9nb/BwXXFE1gO8 YdjRaPVqjbesY2/pw3K0zi1x9wj/6FGVGAAUSseSjUqGbVmznuDcO8xQ2ZBg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch prepares the kernel to support putting all kinds of kfunc BTF
ID sets in the struct btf itself. The various kernel subsystems will
make register_btf_kfunc_id_set call in the initcalls (for built-in code
and modules).

The 'hook' is one of the many program types, e.g. XDP and TC/SCHED_CLS,
STRUCT_OPS, and 'types' are check (allowed or not), acquire, release,
and ret_null (with PTR_TO_BTF_ID_OR_NULL return type).

A maximum of BTF_KFUNC_SET_MAX_CNT (32) kfunc BTF IDs are permitted in a
set of certain hook and type for vmlinux sets, since they are allocated
on demand, and otherwise set as NULL. Module sets can only be registered
once per hook and type, hence they are directly assigned.

A new btf_kfunc_id_set_contains function is exposed for use in verifier,
this new method is faster than the existing list searching method, and
is also automatic. It also lets other code not care whether the set is
unallocated or not.

Note that module code can only do single register_btf_kfunc_id_set call
per hook. This is why sorting is only done for in-kernel vmlinux sets,
because there might be multiple sets for the same hook and type that
must be concatenated, hence sorting them is required to ensure bsearch
in btf_id_set_contains continues to work correctly.

Next commit will update the kernel users to make use of this
infrastructure.

Finally, add __maybe_unused annotation for BTF ID macros for the
!CONFIG_DEBUG_INFO_BTF case, so that they don't produce warnings during
build time.

The previous patch is also needed to provide synchronization against
initialization for module BTF's kfunc_set_tab introduced here, as
described below:

  The kfunc_set_tab pointer in struct btf is write-once (if we consider
  the registration phase (comprised of multiple register_btf_kfunc_id_set
  calls) as a single operation). In this sense, once it has been fully
  prepared, it isn't modified, only used for lookup (from the verifier
  context).

  For btf_vmlinux, it is initialized fully during the do_initcalls phase,
  which happens fairly early in the boot process, before any processes are
  present. This also eliminates the possibility of bpf_check being called
  at that point, thus relieving us of ensuring any synchronization between
  the registration and lookup function (btf_kfunc_id_set_contains).

  However, the case for module BTF is a bit tricky. The BTF is parsed,
  prepared, and published from the MODULE_STATE_COMING notifier callback.
  After this, the module initcalls are invoked, where our registration
  function will be called to populate the kfunc_set_tab for module BTF.

  At this point, BTF may be available to userspace while its corresponding
  module is still intializing. A BTF fd can then be passed to verifier
  using bpf syscall (e.g. for kfunc call insn).

  Hence, there is a race window where verifier may concurrently try to
  lookup the kfunc_set_tab. To prevent this race, we must ensure the
  operations are serialized, or waiting for the __init functions to
  complete.

  In the earlier registration API, this race was alleviated as verifier
  bpf_check_mod_kfunc_call didn't find the kfunc BTF ID until it was added
  by the registration function (called usually at the end of module __init
  function after all module resources have been initialized). If the
  verifier made the check_kfunc_call before kfunc BTF ID was added to the
  list, it would fail verification (saying call isn't allowed). The
  access to list was protected using a mutex.

  Now, it would still fail verification, but for a different reason
  (returning ENXIO due to the failed btf_try_get_module call in
  add_kfunc_call), because if the __init call is in progress the module
  will be in the middle of MODULE_STATE_COMING -> MODULE_STATE_LIVE
  transition, and the BTF_MODULE_LIVE flag for btf_module instance will
  not be set, so the btf_try_get_module call will fail.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/btf.h     |  39 +++++++
 include/linux/btf_ids.h |  13 ++-
 kernel/bpf/btf.c        | 244 +++++++++++++++++++++++++++++++++++++++-
 3 files changed, 289 insertions(+), 7 deletions(-)

diff --git a/include/linux/btf.h b/include/linux/btf.h
index 0c74348cbc9d..c451f8e2612a 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -12,11 +12,33 @@
 #define BTF_TYPE_EMIT(type) ((void)(type *)0)
 #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
 
+enum btf_kfunc_type {
+	BTF_KFUNC_TYPE_CHECK,
+	BTF_KFUNC_TYPE_ACQUIRE,
+	BTF_KFUNC_TYPE_RELEASE,
+	BTF_KFUNC_TYPE_RET_NULL,
+	BTF_KFUNC_TYPE_MAX,
+};
+
 struct btf;
 struct btf_member;
 struct btf_type;
 union bpf_attr;
 struct btf_show;
+struct btf_id_set;
+
+struct btf_kfunc_id_set {
+	struct module *owner;
+	union {
+		struct {
+			struct btf_id_set *check_set;
+			struct btf_id_set *acquire_set;
+			struct btf_id_set *release_set;
+			struct btf_id_set *ret_null_set;
+		};
+		struct btf_id_set *sets[BTF_KFUNC_TYPE_MAX];
+	};
+};
 
 extern const struct file_operations btf_fops;
 
@@ -307,6 +329,11 @@ const struct btf_type *btf_type_by_id(const struct btf *btf, u32 type_id);
 const char *btf_name_by_offset(const struct btf *btf, u32 offset);
 struct btf *btf_parse_vmlinux(void);
 struct btf *bpf_prog_get_target_btf(const struct bpf_prog *prog);
+bool btf_kfunc_id_set_contains(const struct btf *btf,
+			       enum bpf_prog_type prog_type,
+			       enum btf_kfunc_type type, u32 kfunc_btf_id);
+int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+			      const struct btf_kfunc_id_set *s);
 #else
 static inline const struct btf_type *btf_type_by_id(const struct btf *btf,
 						    u32 type_id)
@@ -318,6 +345,18 @@ static inline const char *btf_name_by_offset(const struct btf *btf,
 {
 	return NULL;
 }
+static inline bool btf_kfunc_id_set_contains(const struct btf *btf,
+					     enum bpf_prog_type prog_type,
+					     enum btf_kfunc_type type,
+					     u32 kfunc_btf_id)
+{
+	return false;
+}
+static inline int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+					    const struct btf_kfunc_id_set *s)
+{
+	return 0;
+}
 #endif
 
 struct kfunc_btf_id_set {
diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 919c0fde1c51..bc5d9cc34e4c 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -11,6 +11,7 @@ struct btf_id_set {
 #ifdef CONFIG_DEBUG_INFO_BTF
 
 #include <linux/compiler.h> /* for __PASTE */
+#include <linux/compiler_attributes.h> /* for __maybe_unused */
 
 /*
  * Following macros help to define lists of BTF IDs placed
@@ -146,14 +147,14 @@ extern struct btf_id_set name;
 
 #else
 
-#define BTF_ID_LIST(name) static u32 name[5];
+#define BTF_ID_LIST(name) static u32 __maybe_unused name[5];
 #define BTF_ID(prefix, name)
 #define BTF_ID_UNUSED
-#define BTF_ID_LIST_GLOBAL(name, n) u32 name[n];
-#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 name[1];
-#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 name[1];
-#define BTF_SET_START(name) static struct btf_id_set name = { 0 };
-#define BTF_SET_START_GLOBAL(name) static struct btf_id_set name = { 0 };
+#define BTF_ID_LIST_GLOBAL(name, n) u32 __maybe_unused name[n];
+#define BTF_ID_LIST_SINGLE(name, prefix, typename) static u32 __maybe_unused name[1];
+#define BTF_ID_LIST_GLOBAL_SINGLE(name, prefix, typename) u32 __maybe_unused name[1];
+#define BTF_SET_START(name) static struct btf_id_set __maybe_unused name = { 0 };
+#define BTF_SET_START_GLOBAL(name) static struct btf_id_set __maybe_unused name = { 0 };
 #define BTF_SET_END(name)
 
 #endif /* CONFIG_DEBUG_INFO_BTF */
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index f25bca59909d..74037bd65d17 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -198,6 +198,21 @@
 DEFINE_IDR(btf_idr);
 DEFINE_SPINLOCK(btf_idr_lock);
 
+enum btf_kfunc_hook {
+	BTF_KFUNC_HOOK_XDP,
+	BTF_KFUNC_HOOK_TC,
+	BTF_KFUNC_HOOK_STRUCT_OPS,
+	BTF_KFUNC_HOOK_MAX,
+};
+
+enum {
+	BTF_KFUNC_SET_MAX_CNT = 32,
+};
+
+struct btf_kfunc_set_tab {
+	struct btf_id_set *sets[BTF_KFUNC_HOOK_MAX][BTF_KFUNC_TYPE_MAX];
+};
+
 struct btf {
 	void *data;
 	struct btf_type **types;
@@ -212,6 +227,7 @@ struct btf {
 	refcount_t refcnt;
 	u32 id;
 	struct rcu_head rcu;
+	struct btf_kfunc_set_tab *kfunc_set_tab;
 
 	/* split BTF support */
 	struct btf *base_btf;
@@ -1531,8 +1547,30 @@ static void btf_free_id(struct btf *btf)
 	spin_unlock_irqrestore(&btf_idr_lock, flags);
 }
 
+static void btf_free_kfunc_set_tab(struct btf *btf)
+{
+	struct btf_kfunc_set_tab *tab = btf->kfunc_set_tab;
+	int hook, type;
+
+	if (!tab)
+		return;
+	/* For module BTF, we directly assign the sets being registered, so
+	 * there is nothing to free except kfunc_set_tab.
+	 */
+	if (btf_is_module(btf))
+		goto free_tab;
+	for (hook = 0; hook < ARRAY_SIZE(tab->sets); hook++) {
+		for (type = 0; type < ARRAY_SIZE(tab->sets[0]); type++)
+			kfree(tab->sets[hook][type]);
+	}
+free_tab:
+	kfree(tab);
+	btf->kfunc_set_tab = NULL;
+}
+
 static void btf_free(struct btf *btf)
 {
+	btf_free_kfunc_set_tab(btf);
 	kvfree(btf->types);
 	kvfree(btf->resolved_sizes);
 	kvfree(btf->resolved_ids);
@@ -6371,6 +6409,36 @@ struct module *btf_try_get_module(const struct btf *btf)
 	return res;
 }
 
+/* Returns struct btf corresponding to the struct module
+ *
+ * This function can return NULL or ERR_PTR. Note that caller must
+ * release reference for struct btf iff btf_is_module is true.
+ */
+static struct btf *btf_get_module_btf(const struct module *module)
+{
+	struct btf *btf = NULL;
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	struct btf_module *btf_mod, *tmp;
+#endif
+
+	if (!module)
+		return bpf_get_btf_vmlinux();
+#ifdef CONFIG_DEBUG_INFO_BTF_MODULES
+	mutex_lock(&btf_module_mutex);
+	list_for_each_entry_safe(btf_mod, tmp, &btf_modules, list) {
+		if (btf_mod->module != module)
+			continue;
+
+		btf_get(btf_mod->btf);
+		btf = btf_mod->btf;
+		break;
+	}
+	mutex_unlock(&btf_module_mutex);
+#endif
+
+	return btf;
+}
+
 BPF_CALL_4(bpf_btf_find_by_name_kind, char *, name, int, name_sz, u32, kind, int, flags)
 {
 	struct btf *btf;
@@ -6438,7 +6506,181 @@ BTF_ID_LIST_GLOBAL(btf_tracing_ids, MAX_BTF_TRACING_TYPE)
 BTF_TRACING_TYPE_xxx
 #undef BTF_TRACING_TYPE
 
-/* BTF ID set registration API for modules */
+/* Kernel Function (kfunc) BTF ID set registration API */
+
+static int __btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
+				    enum btf_kfunc_type type,
+				    struct btf_id_set *add_set, bool vmlinux_set)
+{
+	struct btf_kfunc_set_tab *tab;
+	struct btf_id_set *set;
+	u32 set_cnt;
+	int ret;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX || type >= BTF_KFUNC_TYPE_MAX) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	if (!add_set->cnt)
+		return 0;
+
+	tab = btf->kfunc_set_tab;
+	if (!tab) {
+		tab = kzalloc(sizeof(*tab), GFP_KERNEL | __GFP_NOWARN);
+		if (!tab)
+			return -ENOMEM;
+		btf->kfunc_set_tab = tab;
+	}
+
+	set = tab->sets[hook][type];
+	/* Warn when register_btf_kfunc_id_set is called twice for the same hook
+	 * for module sets.
+	 */
+	if (WARN_ON_ONCE(set && !vmlinux_set)) {
+		ret = -EINVAL;
+		goto end;
+	}
+
+	/* We don't need to allocate, concatenate, and sort module sets, because
+	 * only one is allowed per hook. Hence, we can directly assign the
+	 * pointer and return.
+	 */
+	if (!vmlinux_set) {
+		tab->sets[hook][type] = add_set;
+		return 0;
+	}
+
+	/* In case of vmlinux sets, there may be more than one set being
+	 * registered per hook. To create a unified set, we allocate a new set
+	 * and concatenate all individual sets being registered. While each set
+	 * is individually sorted, they may become unsorted when concatenated,
+	 * hence re-sorting the final set again is required to make binary
+	 * searching the set using btf_id_set_contains function work.
+	 */
+	set_cnt = set ? set->cnt : 0;
+
+	if (set_cnt > U32_MAX - add_set->cnt) {
+		ret = -EOVERFLOW;
+		goto end;
+	}
+
+	if (set_cnt + add_set->cnt > BTF_KFUNC_SET_MAX_CNT) {
+		ret = -E2BIG;
+		goto end;
+	}
+
+	/* Grow set */
+	set = krealloc(tab->sets[hook][type],
+		       offsetof(struct btf_id_set, ids[set_cnt + add_set->cnt]),
+		       GFP_KERNEL | __GFP_NOWARN);
+	if (!set) {
+		ret = -ENOMEM;
+		goto end;
+	}
+
+	/* For newly allocated set, initialize set->cnt to 0 */
+	if (!tab->sets[hook][type])
+		set->cnt = 0;
+	tab->sets[hook][type] = set;
+
+	/* Concatenate the two sets */
+	memcpy(set->ids + set->cnt, add_set->ids, add_set->cnt * sizeof(set->ids[0]));
+	set->cnt += add_set->cnt;
+
+	sort(set->ids, set->cnt, sizeof(set->ids[0]), btf_id_cmp_func, NULL);
+
+	return 0;
+end:
+	btf_free_kfunc_set_tab(btf);
+	return ret;
+}
+
+static int btf_populate_kfunc_set(struct btf *btf, enum btf_kfunc_hook hook,
+				  const struct btf_kfunc_id_set *kset)
+{
+	bool vmlinux_set = !btf_is_module(btf);
+	int type, ret;
+
+	for (type = 0; type < ARRAY_SIZE(kset->sets); type++) {
+		if (!kset->sets[type])
+			continue;
+
+		ret = __btf_populate_kfunc_set(btf, hook, type, kset->sets[type], vmlinux_set);
+		if (ret)
+			break;
+	}
+	return ret;
+}
+
+static bool __btf_kfunc_id_set_contains(const struct btf *btf,
+					enum btf_kfunc_hook hook,
+					enum btf_kfunc_type type,
+					u32 kfunc_btf_id)
+{
+	struct btf_id_set *set;
+
+	if (hook >= BTF_KFUNC_HOOK_MAX || type >= BTF_KFUNC_TYPE_MAX)
+		return false;
+	if (!btf->kfunc_set_tab)
+		return false;
+	set = btf->kfunc_set_tab->sets[hook][type];
+	if (!set)
+		return false;
+	return btf_id_set_contains(set, kfunc_btf_id);
+}
+
+static int bpf_prog_type_to_kfunc_hook(enum bpf_prog_type prog_type)
+{
+	switch (prog_type) {
+	case BPF_PROG_TYPE_XDP:
+		return BTF_KFUNC_HOOK_XDP;
+	case BPF_PROG_TYPE_SCHED_CLS:
+		return BTF_KFUNC_HOOK_TC;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		return BTF_KFUNC_HOOK_STRUCT_OPS;
+	default:
+		return BTF_KFUNC_HOOK_MAX;
+	}
+}
+
+/* Caution:
+ * Reference to the module (obtained using btf_try_get_module) corresponding to
+ * the struct btf *MUST* be held when calling this function from verifier
+ * context. This is usually true as we stash references in prog's kfunc_btf_tab;
+ * keeping the reference for the duration of the call provides the necessary
+ * protection for looking up a well-formed btf->kfunc_set_tab.
+ */
+bool btf_kfunc_id_set_contains(const struct btf *btf,
+			       enum bpf_prog_type prog_type,
+			       enum btf_kfunc_type type, u32 kfunc_btf_id)
+{
+	enum btf_kfunc_hook hook;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	return __btf_kfunc_id_set_contains(btf, hook, type, kfunc_btf_id);
+}
+
+/* This function must be invoked only from initcalls/module init functions */
+int register_btf_kfunc_id_set(enum bpf_prog_type prog_type,
+			      const struct btf_kfunc_id_set *kset)
+{
+	enum btf_kfunc_hook hook;
+	struct btf *btf;
+	int ret;
+
+	btf = btf_get_module_btf(kset->owner);
+	if (IS_ERR_OR_NULL(btf))
+		return btf ? PTR_ERR(btf) : -ENOENT;
+
+	hook = bpf_prog_type_to_kfunc_hook(prog_type);
+	ret = btf_populate_kfunc_set(btf, hook, kset);
+	/* reference is only taken for module BTF */
+	if (btf_is_module(btf))
+		btf_put(btf);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_btf_kfunc_id_set);
 
 #ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 
-- 
2.34.1

