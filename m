Return-Path: <netfilter-devel+bounces-1838-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EBD78A9067
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Apr 2024 03:10:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E91D81F21A19
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Apr 2024 01:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA6D94DA0D;
	Thu, 18 Apr 2024 01:09:59 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343A3BBE4;
	Thu, 18 Apr 2024 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713402599; cv=none; b=jzkxEWUjS/OYVAfhH+Go8yhCt2cDkGyLdnSlMQX3n3EO5qJvd8xzgU4fhLhBHlrH+t5evuiFcC3ExPMawpc9AgqOhw4kmmntJ0tHNBW2n1jTUB4FCREBZcFw4x7AudWLJBjs5dMgdpdCBweFx+FU4E+gdmEWbfsjuLOk9DLYeyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713402599; c=relaxed/simple;
	bh=rQuQ0nluDqufnJdJ7SeRkV4kvE+ksZTAcethRzPlvQQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pBWtOHNX5ddQ1A8c0JXbK8VMnON35GVKvd7fKEZiKsTlTsrEHzTW5we+fEbqB77inb2EMlP8Q/horOx6yaL5RxMHWR1tRrTkoccGQppspU9Ig9IFS94/rqmZRU1ksG7LMtYqlxNRsbhT6Ul87eqDdPqSju98BgGCCZ5Z7Ea3Qjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Subject: [PATCH net 3/3] netfilter: nf_tables: fix memleak in map from abort path
Date: Thu, 18 Apr 2024 03:09:48 +0200
Message-Id: <20240418010948.3332346-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240418010948.3332346-1-pablo@netfilter.org>
References: <20240418010948.3332346-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The delete set command does not rely on the transaction object for
element removal, therefore, a combination of delete element + delete set
from the abort path could result in restoring twice the refcount of the
mapping.

Check for inactive element in the next generation for the delete element
command in the abort path, skip restoring state if next generation bit
has been already cleared. This is similar to the activate logic using
the set walk iterator.

[ 6170.286929] ------------[ cut here ]------------
[ 6170.286939] WARNING: CPU: 6 PID: 790302 at net/netfilter/nf_tables_api.c:2086 nf_tables_chain_destroy+0x1f7/0x220 [nf_tables]
[ 6170.287071] Modules linked in: [...]
[ 6170.287633] CPU: 6 PID: 790302 Comm: kworker/6:2 Not tainted 6.9.0-rc3+ #365
[ 6170.287768] RIP: 0010:nf_tables_chain_destroy+0x1f7/0x220 [nf_tables]
[ 6170.287886] Code: df 48 8d 7d 58 e8 69 2e 3b df 48 8b 7d 58 e8 80 1b 37 df 48 8d 7d 68 e8 57 2e 3b df 48 8b 7d 68 e8 6e 1b 37 df 48 89 ef eb c4 <0f> 0b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc 0f
[ 6170.287895] RSP: 0018:ffff888134b8fd08 EFLAGS: 00010202
[ 6170.287904] RAX: 0000000000000001 RBX: ffff888125bffb28 RCX: dffffc0000000000
[ 6170.287912] RDX: 0000000000000003 RSI: ffffffffa20298ab RDI: ffff88811ebe4750
[ 6170.287919] RBP: ffff88811ebe4700 R08: ffff88838e812650 R09: fffffbfff0623a55
[ 6170.287926] R10: ffffffff8311d2af R11: 0000000000000001 R12: ffff888125bffb10
[ 6170.287933] R13: ffff888125bffb10 R14: dead000000000122 R15: dead000000000100
[ 6170.287940] FS:  0000000000000000(0000) GS:ffff888390b00000(0000) knlGS:0000000000000000
[ 6170.287948] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6170.287955] CR2: 00007fd31fc00710 CR3: 0000000133f60004 CR4: 00000000001706f0
[ 6170.287962] Call Trace:
[ 6170.287967]  <TASK>
[ 6170.287973]  ? __warn+0x9f/0x1a0
[ 6170.287986]  ? nf_tables_chain_destroy+0x1f7/0x220 [nf_tables]
[ 6170.288092]  ? report_bug+0x1b1/0x1e0
[ 6170.287986]  ? nf_tables_chain_destroy+0x1f7/0x220 [nf_tables]
[ 6170.288092]  ? report_bug+0x1b1/0x1e0
[ 6170.288104]  ? handle_bug+0x3c/0x70
[ 6170.288112]  ? exc_invalid_op+0x17/0x40
[ 6170.288120]  ? asm_exc_invalid_op+0x1a/0x20
[ 6170.288132]  ? nf_tables_chain_destroy+0x2b/0x220 [nf_tables]
[ 6170.288243]  ? nf_tables_chain_destroy+0x1f7/0x220 [nf_tables]
[ 6170.288366]  ? nf_tables_chain_destroy+0x2b/0x220 [nf_tables]
[ 6170.288483]  nf_tables_trans_destroy_work+0x588/0x590 [nf_tables]

Fixes: 591054469b3e ("netfilter: nf_tables: revisit chain/object refcounting from elements")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index d0c09f899e80..167074283ea9 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -7223,6 +7223,16 @@ void nft_data_hold(const struct nft_data *data, enum nft_data_types type)
 	}
 }
 
+static int nft_setelem_active_next(const struct net *net,
+				   const struct nft_set *set,
+				   struct nft_elem_priv *elem_priv)
+{
+	const struct nft_set_ext *ext = nft_set_elem_ext(set, elem_priv);
+	u8 genmask = nft_genmask_next(net);
+
+	return nft_set_elem_active(ext, genmask);
+}
+
 static void nft_setelem_data_activate(const struct net *net,
 				      const struct nft_set *set,
 				      struct nft_elem_priv *elem_priv)
@@ -10644,8 +10654,10 @@ static int __nf_tables_abort(struct net *net, enum nfnl_abort_action action)
 		case NFT_MSG_DESTROYSETELEM:
 			te = (struct nft_trans_elem *)trans->data;
 
-			nft_setelem_data_activate(net, te->set, te->elem_priv);
-			nft_setelem_activate(net, te->set, te->elem_priv);
+			if (!nft_setelem_active_next(net, te->set, te->elem_priv)) {
+				nft_setelem_data_activate(net, te->set, te->elem_priv);
+				nft_setelem_activate(net, te->set, te->elem_priv);
+			}
 			if (!nft_setelem_is_catchall(te->set, te->elem_priv))
 				te->set->ndeact--;
 
-- 
2.30.2


