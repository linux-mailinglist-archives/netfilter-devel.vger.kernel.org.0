Return-Path: <netfilter-devel+bounces-11524-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJLMHaM/zGm+RgYAu9opvQ
	(envelope-from <netfilter-devel+bounces-11524-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 23:41:55 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 10ED2372161
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 23:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 781DC3022C16
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Mar 2026 21:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740DA4219EA;
	Tue, 31 Mar 2026 21:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="iYZjBjbG"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29023DDDD0
	for <netfilter-devel@vger.kernel.org>; Tue, 31 Mar 2026 21:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774993313; cv=none; b=nUGmTK3EOwrV6AKqARJ8234RXAnFAukfxsppT1IxeschfECNnmVNfkHZgTMhb/z5sVZSbM4+t080Ve+iPiQRhUMThu8DLZ11KJFk6zjDdTTLlUYR/tnaeZ+n8z0MWOZTQ6hT89cUM6wCelSXq3vSg4SUULXOJd9ZCfRuaMnXNCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774993313; c=relaxed/simple;
	bh=E7YimOfS97YvAhHl9kDRgATbz4+/7dyoNLVHdEYTaso=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kITJuw7zfn+81tLem6r/hjwpaqLPTGubqkwbRTd104fTStEF1fd/FfN0gp0fjvSGnp97Q/G7KH+uEiQTWA2r8Aj86Dal3NHw8MG8Qp5hOsUZL51pMtgOQ3LDrx/wYlQ9P+ZmJtNP8HLpn0jaBh6Wf45WrfKiUzIMFLNEEUqm+KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=iYZjBjbG; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: from localhost.localdomain (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 89F1760180;
	Tue, 31 Mar 2026 23:41:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1774993308;
	bh=wxvd5R8F1xkn0VnHHa2rQ8cb05bXd82dxeO9jOTiIRs=;
	h=From:To:Cc:Subject:Date:From;
	b=iYZjBjbGjNF7BxQoXfSRwPtTDIi9clgbYyaHw8fG1j9dt+JQPnGoRWd0WwxtIQgjJ
	 1OUSlRjnJsOLDXBlkJuR/P2f8s5AXgDbnB/HDMC2usqb4FkKogE/rULD/uB7bytBk2
	 7J82Mr6pWZUwYiBAIvmFgbB1LS86Cg73yIgahOY1ouIiNbvlXeFWCPNW7Q6gaSrVgN
	 r0QnVNLjA9THuEo02Z27FO4PP+4TczzoBcI2EcMWhy4NKDE3A4y9fEk78JXbcWsjU1
	 IlzPequVVOqSJKD6Bs0a/WHv0PH7MGcWTURgDJTgMDHtWjIDcPYm6CWWm5AFmmCoa1
	 4hS+OU5dF5HfQ==
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: fw@strlen.de
Subject: [PATCH nf] netfilter: nf_tables: reject immediate NF_QUEUE verdict
Date: Tue, 31 Mar 2026 23:41:45 +0200
Message-ID: <20260331214145.976722-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-11524-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[netfilter.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,netfilter.org:dkim,netfilter.org:email,netfilter.org:mid]
X-Rspamd-Queue-Id: 10ED2372161
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

nft_queue is always used from userspace nftables to deliver the NF_QUEUE
verdict, reject immediate NF_QUEUE verdict.

Fixes: f342de4e2f33 ("netfilter: nf_tables: reject QUEUE/DROP verdict parameters")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 3922cff1bb3d..8c42247a176c 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -11667,8 +11667,6 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 	switch (data->verdict.code) {
 	case NF_ACCEPT:
 	case NF_DROP:
-	case NF_QUEUE:
-		break;
 	case NFT_CONTINUE:
 	case NFT_BREAK:
 	case NFT_RETURN:
@@ -11703,6 +11701,11 @@ static int nft_verdict_init(const struct nft_ctx *ctx, struct nft_data *data,
 
 		data->verdict.chain = chain;
 		break;
+	case NF_QUEUE:
+		/* The nft_queue expression is used for this purpose, an
+		 * immediate NF_QUEUE verdict should not ever be seen here.
+		 */
+		fallthrough;
 	default:
 		return -EINVAL;
 	}
-- 
2.47.3


