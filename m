Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77B9A7514A5
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Jul 2023 01:44:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbjGLXon (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 12 Jul 2023 19:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbjGLXoj (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 12 Jul 2023 19:44:39 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05002118;
        Wed, 12 Jul 2023 16:44:36 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C911832000D7;
        Wed, 12 Jul 2023 19:44:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 12 Jul 2023 19:44:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1689205474; x=
        1689291874; bh=shKW5OcxDhFb57xmBT1FA7jIb7rdvybkuN5mH5oxQFg=; b=J
        oYFB9jzdk6CyiSw6dvUCc5wJVhSD6OicSWdM0mCjAflF7+Xilv0T38g/lSyabEuk
        iqlmJ0N15mo9gI/Wp88zHvTN+llE7mj3pqNv47PqpcQ8gPhFb0UXQg/h7N7De5VZ
        9Za3DujA1Yj1Q8PL/Tf00nfWW/LP5ctA8JqDvG0zNMqY40VHfPxyHRUwTDiu8ubV
        QuUA2qImUp+55hF3y53f4juWMfXYWwp43uQ0mAboxrrbIH14gW2+drTSsnbhAoB5
        pOrcqHR4LSWSEAdlwnVxj5RjvY6p0Nb7MTm0/snEhtTZG4dGEZCDq+WWJHqswzaS
        voz1ldLxI4oGrEo0qNoug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1689205474; x=
        1689291874; bh=shKW5OcxDhFb57xmBT1FA7jIb7rdvybkuN5mH5oxQFg=; b=p
        0nLqjnnDxnsUKUNZrQIfqVy4o0AyjqL1WqSttklkxQH4u5tnemyZ7xqUhb4Y7jrc
        wbn4RMxwnzdsdy8ScC9huCipgRIMpXgne7YrFK73W4mMv6QdgiY4Pp0vDEB5cP3b
        Yb73xq1J10GtAvK1DCwfYZ1ZbG9bfE6Fk9iSUKD5RXwAUWRmJ5HAhJYGjSR2iSKE
        47KOAi6P3ZYL/dMHzmD1WhHPE/XBHK6wOnlmF13SWtX8S87m1MlFxRESOqDKVnrm
        5rmQnF7jSymdx2Xb9RHrsSCJv1qqNpBREEB862Jv4pfFn63FfMOtLcDhRZepqmar
        Gs6RS65ek7I9GgGcM5FDQ==
X-ME-Sender: <xms:4jqvZAwxfMxYHhyHmmzrcsTSagHlHrbkvQhFBjlSWwQPp688EXMRwA>
    <xme:4jqvZETG94vLazV1OCooiNntg1H99T9N2mqoMPUXYUkDt8m9pAPK0rTNca7QfFDDl
    9OcaWcaS_cNvdUeNw>
X-ME-Received: <xmr:4jqvZCXbsOp8YCdBDWpmJlN9stWYAmM1yl3mFkGqTsnAB85S9jKC7qJRhWB-DLD3Adz_XTMwfiNogaLfbaa4EyNPYH__tSDcbNBXlSf9u10>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfeefgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdefhedmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomhepffgrnhhivghlucgiuhcuoegu
    gihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpefgfefggeejhfduieekvd
    euteffleeifeeuvdfhheejleejjeekgfffgefhtddtteenucevlhhushhtvghrufhiiigv
    pedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:4jqvZOj4LzNuyA3_9D_CiJ_Jq3iPURx9FaJAZX_TnMQriibqyqBIeQ>
    <xmx:4jqvZCAvMcelk-rRHMZrhMvyZbc_2Zj5xOl2vX9gwlJaI-BJLe-0zA>
    <xmx:4jqvZPJsrrLzccE1tGD3VArdfEIlgWeYtf9yxz9XggmTRrGz8zaLVw>
    <xmx:4jqvZOyIHbCnIaAs8XR4xMFJJ25DD5vTdzaa4jCdDnUHCvfkAy6IIA>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 19:44:33 -0400 (EDT)
From:   Daniel Xu <dxu@dxuuu.xyz>
To:     fw@strlen.de, davem@davemloft.net, pabeni@redhat.com,
        pablo@netfilter.org, dsahern@kernel.org, edumazet@google.com,
        kuba@kernel.org, kadlec@netfilter.org,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 3/6] netfilter: bpf: Prevent defrag module unload while link active
Date:   Wed, 12 Jul 2023 17:43:58 -0600
Message-ID: <0e98b06baa07cace9de45ed7c4e488903ada764e.1689203090.git.dxu@dxuuu.xyz>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1689203090.git.dxu@dxuuu.xyz>
References: <cover.1689203090.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

While in practice we could handle the module being unloaded while a
netfilter link (that requested defrag) was active, it's a better user
experience to prevent the defrag module from going away. It would
violate user expectations if fragmented packets started showing up if
some other part of the system tried to unload defrag module.

Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
---
 include/linux/netfilter.h                 |  3 +++
 net/ipv4/netfilter/nf_defrag_ipv4.c       |  1 +
 net/ipv6/netfilter/nf_defrag_ipv6_hooks.c |  1 +
 net/netfilter/nf_bpf_link.c               | 25 +++++++++++++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter.h b/include/linux/netfilter.h
index 77a637b681f2..a160dc1e23bf 100644
--- a/include/linux/netfilter.h
+++ b/include/linux/netfilter.h
@@ -11,6 +11,7 @@
 #include <linux/wait.h>
 #include <linux/list.h>
 #include <linux/static_key.h>
+#include <linux/module.h>
 #include <linux/netfilter_defs.h>
 #include <linux/netdevice.h>
 #include <linux/sockptr.h>
@@ -482,12 +483,14 @@ struct nfnl_ct_hook {
 extern const struct nfnl_ct_hook __rcu *nfnl_ct_hook;
 
 struct nf_defrag_v4_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
 extern const struct nf_defrag_v4_hook __rcu *nf_defrag_v4_hook;
 
 struct nf_defrag_v6_hook {
+	struct module *owner;
 	int (*enable)(struct net *net);
 	void (*disable)(struct net *net);
 };
diff --git a/net/ipv4/netfilter/nf_defrag_ipv4.c b/net/ipv4/netfilter/nf_defrag_ipv4.c
index 1f3e0e893b7a..fb133bf3131d 100644
--- a/net/ipv4/netfilter/nf_defrag_ipv4.c
+++ b/net/ipv4/netfilter/nf_defrag_ipv4.c
@@ -115,6 +115,7 @@ static void __net_exit defrag4_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v4_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv4_enable,
 	.disable = nf_defrag_ipv4_disable,
 };
diff --git a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
index f7c7ee31c472..29d31721c9c0 100644
--- a/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
+++ b/net/ipv6/netfilter/nf_defrag_ipv6_hooks.c
@@ -98,6 +98,7 @@ static void __net_exit defrag6_net_exit(struct net *net)
 }
 
 static const struct nf_defrag_v6_hook defrag_hook = {
+	.owner = THIS_MODULE,
 	.enable = nf_defrag_ipv6_enable,
 	.disable = nf_defrag_ipv6_disable,
 };
diff --git a/net/netfilter/nf_bpf_link.c b/net/netfilter/nf_bpf_link.c
index 5b72aa246577..77ffbf26ba3d 100644
--- a/net/netfilter/nf_bpf_link.c
+++ b/net/netfilter/nf_bpf_link.c
@@ -2,6 +2,7 @@
 #include <linux/bpf.h>
 #include <linux/filter.h>
 #include <linux/kmod.h>
+#include <linux/module.h>
 #include <linux/netfilter.h>
 
 #include <net/netfilter/nf_bpf_link.h>
@@ -53,7 +54,15 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v4_hook->owner)) {
+			err = -ENOENT;
+			goto out_v4;
+		}
+
 		err = v4_hook->enable(link->net);
+		if (err)
+			module_put(v4_hook->owner);
 out_v4:
 		rcu_read_unlock();
 		return err;
@@ -77,7 +86,15 @@ static int bpf_nf_enable_defrag(struct bpf_nf_link *link)
 			}
 		}
 
+		/* Prevent defrag module from going away while in use */
+		if (!try_module_get(v6_hook->owner)) {
+			err = -ENOENT;
+			goto out_v6;
+		}
+
 		err = v6_hook->enable(link->net);
+		if (err)
+			module_put(v6_hook->owner);
 out_v6:
 		rcu_read_unlock();
 		return err;
@@ -97,8 +114,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 	case NFPROTO_IPV4:
 		rcu_read_lock();
 		v4_hook = rcu_dereference(nf_defrag_v4_hook);
-		if (v4_hook)
+		if (v4_hook) {
 			v4_hook->disable(link->net);
+			module_put(v4_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
@@ -107,8 +126,10 @@ static void bpf_nf_disable_defrag(struct bpf_nf_link *link)
 	case NFPROTO_IPV6:
 		rcu_read_lock();
 		v6_hook = rcu_dereference(nf_defrag_v6_hook);
-		if (v6_hook)
+		if (v6_hook) {
 			v6_hook->disable(link->net);
+			module_put(v6_hook->owner);
+		}
 		rcu_read_unlock();
 
 		break;
-- 
2.41.0

