Return-Path: <netfilter-devel+bounces-1680-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0571989CD7D
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 23:21:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38F1D1C221DE
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Apr 2024 21:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C88C495CB;
	Mon,  8 Apr 2024 21:21:49 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C054D1487ED;
	Mon,  8 Apr 2024 21:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712611309; cv=none; b=CRK4VnoRpat55aYBGs6SiaWVkLz13DoFJC+xMyv83kFTLXHk5yAWnwmpRUQyPWfzRiSQwxqvVAhvh612WVCNcUqZPv4A3Q18ZUh9JrG11l9SH8+2HNWP+laJcMCPRelbjxH/t+Ul7DVqErW/DAt1YeYF3THyPoTA5z24gUsglIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712611309; c=relaxed/simple;
	bh=x+AUKT2xMqWlThVjgtzyOBWRTKlPI4jUzQ02ljOp45E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NBEtMq3EbHcbnvtt4gpE4+lAhDkhYUatTopS8KquDdO9vCRL/y/cU+RyGK65vDMvWzHEEoCU0hpWGbL5BdiuHHm2CDX3wucd044SitL0Qw2+EDqXmpoVla0cKkeOb9MQZwCglrbYkpTCWIWoGPC0JRViA7s7xfdIWKEOrgqsT5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: stable@vger.kernel.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org
Subject: [PATCH -stable,5.4.x 1/5] netfilter: nf_tables: reject new basechain after table flag update
Date: Mon,  8 Apr 2024 23:21:38 +0200
Message-Id: <20240408212142.312314-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240408212142.312314-1-pablo@netfilter.org>
References: <20240408212142.312314-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 994209ddf4f430946f6247616b2e33d179243769 upstream.

When dormant flag is toggled, hooks are disabled in the commit phase by
iterating over current chains in table (existing and new).

The following configuration allows for an inconsistent state:

  add table x
  add chain x y { type filter hook input priority 0; }
  add table x { flags dormant; }
  add chain x w { type filter hook input priority 1; }

which triggers the following warning when trying to unregister chain w
which is already unregistered.

[  127.322252] WARNING: CPU: 7 PID: 1211 at net/netfilter/core.c:50                                                                     1 __nf_unregister_net_hook+0x21a/0x260
[...]
[  127.322519] Call Trace:
[  127.322521]  <TASK>
[  127.322524]  ? __warn+0x9f/0x1a0
[  127.322531]  ? __nf_unregister_net_hook+0x21a/0x260
[  127.322537]  ? report_bug+0x1b1/0x1e0
[  127.322545]  ? handle_bug+0x3c/0x70
[  127.322552]  ? exc_invalid_op+0x17/0x40
[  127.322556]  ? asm_exc_invalid_op+0x1a/0x20
[  127.322563]  ? kasan_save_free_info+0x3b/0x60
[  127.322570]  ? __nf_unregister_net_hook+0x6a/0x260
[  127.322577]  ? __nf_unregister_net_hook+0x21a/0x260
[  127.322583]  ? __nf_unregister_net_hook+0x6a/0x260
[  127.322590]  ? __nf_tables_unregister_hook+0x8a/0xe0 [nf_tables]
[  127.322655]  nft_table_disable+0x75/0xf0 [nf_tables]
[  127.322717]  nf_tables_commit+0x2571/0x2620 [nf_tables]

Fixes: 179d9ba5559a ("netfilter: nf_tables: fix table flag updates")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_api.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 2d372d5fcbfa..ce7c573ce8cb 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -1805,6 +1805,9 @@ static int nf_tables_addchain(struct nft_ctx *ctx, u8 family, u8 genmask,
 		struct nft_chain_hook hook;
 		struct nf_hook_ops *ops;
 
+		if (table->flags & __NFT_TABLE_F_UPDATE)
+			return -EINVAL;
+
 		err = nft_chain_parse_hook(net, nla, &hook, family, true);
 		if (err < 0)
 			return err;
-- 
2.30.2


