Return-Path: <netfilter-devel+bounces-13278-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kabZIYRAMGq/QQUAu9opvQ
	(envelope-from <netfilter-devel+bounces-13278-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 20:12:20 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C34689179
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 20:12:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13278-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13278-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BE6830DAFB8
	for <lists+netfilter-devel@lfdr.de>; Mon, 15 Jun 2026 18:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2CD73090E2;
	Mon, 15 Jun 2026 18:11:04 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE213002B9
	for <netfilter-devel@vger.kernel.org>; Mon, 15 Jun 2026 18:11:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781547064; cv=none; b=Ayd/L92Yy9NNvaMke89Gs5EllQDroku49JtP1xHH4e++SkslE9CfzSXdihfpOyOIz9d7xYJvbm55VBtvWA6IfHU+RMTOvxErkZApqtvMG4xqiM+RCzM5TPdRBLNMIG83Xo4rL7aZneI2qKwLqOugyATZfINZxnBAYZgmECx/IRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781547064; c=relaxed/simple;
	bh=AfKCc27fx+oHYUXGJ8LaIrmfVX7B4RK8bGuXzhb9hEc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o1V4fYWN/IueE7amjwStUqUpfrEKJ3jb8HgpchN1eP6WQ9JnD5O39Ed6FXrw6rAfp+OqQwmFx7Y3TBWKU8+CM2elrIYnhAwuJLp3mm+br1p0SRcwG0Z//l9I2dEt0ALOXpCZ6dxtlQFw0/6h5ktfto1r9WRJFVH8GDNebGKhC3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 6B914602C8; Mon, 15 Jun 2026 20:11:00 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netfilter-devel@vger.kernel.org>
Cc: Florian Westphal <fw@strlen.de>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Wyatt Feng <bronzed_45_vested@icloud.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>
Subject: [PATCH nf] netfilter: nft_compat: ebtables emulation must reject non-bridge targets
Date: Mon, 15 Jun 2026 20:10:44 +0200
Message-ID: <20260615181044.4049-1-fw@strlen.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-13278-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FREEMAIL_CC(0.00)[strlen.de,lzu.edu.cn,icloud.com,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:n05ec@lzu.edu.cn,m:bronzed_45_vested@icloud.com,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:zcliangcn@gmail.com,m:bird@lzu.edu.cn,s:lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,strlen.de:mid,strlen.de:from_mime,vger.kernel.org:from_smtp,ozlabs.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,icloud.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D7C34689179

xtables targets return netfilter verdicts: NF_ACCEPT, NF_DROP, and so
on.  ebtables targets return incompatible verdicts: EBT_ACCEPT,
EBT_DROP, ...   We cannot allow fallback to NFPROTO_UNSPEC.

ebtables doesn't permit this since
11ff7288beb2 ("netfilter: ebtables: reject non-bridge targets")
but that commit missed the nft_compat layer.

Reported-by: Ren Wei <n05ec@lzu.edu.cn>
Reported-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Fixes: 0ca743a55991 ("netfilter: nf_tables: add compatibility layer for x_tables")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 I'd still apply the originally proposed patch:
 https://patchwork.ozlabs.org/project/netfilter-devel/patch/5722ce33544cc22da3f811de77ab57847eb58366.1781144570.git.bronzed_45_vested@icloud.com/

 (or, alternatively, split the UNSPEC into explicit
  NFPROTO_IPV4/NFPROTO_IPV6), this fix is technically for a different
 bug, even though it does prevent to original bug as well.

 net/netfilter/nft_compat.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/net/netfilter/nft_compat.c b/net/netfilter/nft_compat.c
index 0caa9304d2d0..63864b928259 100644
--- a/net/netfilter/nft_compat.c
+++ b/net/netfilter/nft_compat.c
@@ -397,6 +397,22 @@ static int nft_target_validate(const struct nft_ctx *ctx,
 	return 0;
 }
 
+static int nft_target_bridge_validate(const struct nft_ctx *ctx,
+				      const struct nft_expr *expr)
+{
+	struct xt_target *target = expr->ops->data;
+
+	/* Do not allow UNSPEC to stand-in for NFPROTO_BRIDGE
+	 * targets: they are incompatible.  ebtables targets return
+	 * EBT_ACCEPT, DROP and so on which are not compatible with
+	 * NF_ACCEPT, NF_DROP and so on.
+	 */
+	if (target->family != NFPROTO_BRIDGE)
+		return -ENOENT;
+
+	return nft_target_validate(ctx, expr);
+}
+
 static void __nft_match_eval(const struct nft_expr *expr,
 			     struct nft_regs *regs,
 			     const struct nft_pktinfo *pkt,
@@ -932,13 +948,15 @@ nft_target_select_ops(const struct nft_ctx *ctx,
 	ops->init = nft_target_init;
 	ops->destroy = nft_target_destroy;
 	ops->dump = nft_target_dump;
-	ops->validate = nft_target_validate;
 	ops->data = target;
 
-	if (family == NFPROTO_BRIDGE)
+	if (family == NFPROTO_BRIDGE) {
 		ops->eval = nft_target_eval_bridge;
-	else
+		ops->validate = nft_target_bridge_validate;
+	} else {
 		ops->eval = nft_target_eval_xt;
+		ops->validate = nft_target_validate;
+	}
 
 	return ops;
 err:
-- 
2.53.0


