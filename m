Return-Path: <netfilter-devel+bounces-243-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E5D807744
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 19:04:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAEC1B20EDB
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 Dec 2023 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC266F615;
	Wed,  6 Dec 2023 18:04:10 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47344139;
	Wed,  6 Dec 2023 10:04:06 -0800 (PST)
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de
Subject: [PATCH net 6/6] netfilter: xt_owner: Fix for unsafe access of sk->sk_socket
Date: Wed,  6 Dec 2023 19:03:57 +0100
Message-Id: <20231206180357.959930-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231206180357.959930-1-pablo@netfilter.org>
References: <20231206180357.959930-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phil Sutter <phil@nwl.cc>

A concurrently running sock_orphan() may NULL the sk_socket pointer in
between check and deref. Follow other users (like nft_meta.c for
instance) and acquire sk_callback_lock before dereferencing sk_socket.

Fixes: 0265ab44bacc ("[NETFILTER]: merge ipt_owner/ip6t_owner in xt_owner")
Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_owner.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/xt_owner.c b/net/netfilter/xt_owner.c
index e85ce69924ae..50332888c8d2 100644
--- a/net/netfilter/xt_owner.c
+++ b/net/netfilter/xt_owner.c
@@ -76,18 +76,23 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 		 */
 		return false;
 
-	filp = sk->sk_socket->file;
-	if (filp == NULL)
+	read_lock_bh(&sk->sk_callback_lock);
+	filp = sk->sk_socket ? sk->sk_socket->file : NULL;
+	if (filp == NULL) {
+		read_unlock_bh(&sk->sk_callback_lock);
 		return ((info->match ^ info->invert) &
 		       (XT_OWNER_UID | XT_OWNER_GID)) == 0;
+	}
 
 	if (info->match & XT_OWNER_UID) {
 		kuid_t uid_min = make_kuid(net->user_ns, info->uid_min);
 		kuid_t uid_max = make_kuid(net->user_ns, info->uid_max);
 		if ((uid_gte(filp->f_cred->fsuid, uid_min) &&
 		     uid_lte(filp->f_cred->fsuid, uid_max)) ^
-		    !(info->invert & XT_OWNER_UID))
+		    !(info->invert & XT_OWNER_UID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
 	if (info->match & XT_OWNER_GID) {
@@ -112,10 +117,13 @@ owner_mt(const struct sk_buff *skb, struct xt_action_param *par)
 			}
 		}
 
-		if (match ^ !(info->invert & XT_OWNER_GID))
+		if (match ^ !(info->invert & XT_OWNER_GID)) {
+			read_unlock_bh(&sk->sk_callback_lock);
 			return false;
+		}
 	}
 
+	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.30.2


