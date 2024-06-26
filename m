Return-Path: <netfilter-devel+bounces-2787-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7D919B3C
	for <lists+netfilter-devel@lfdr.de>; Thu, 27 Jun 2024 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2121F22A29
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2024 23:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB8E11946AF;
	Wed, 26 Jun 2024 23:39:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD79192B69;
	Wed, 26 Jun 2024 23:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719445141; cv=none; b=NXS3nqICts36m6as1jl1bk41o7QAfBz6lgHSte65oeEXbF/9pSpwTegX+gUldTCNsuIkt7UvsUzc9f173fo2/W7LJ0l7bBDWVyqaBotsWIZA2JMwLY/1Pkbhu3f4N8PDvYoq4IAHJ5ZrtrdUEYMO+eMH8Uh2/Ws7XW7ioWyCQI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719445141; c=relaxed/simple;
	bh=hImuZQ7maYIYqa/IcFnM8kTqP4IHb5Ke4znOD4+XIew=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=McEqifD6+jSoGDgaqSZY5IHDQDRfOpzftAqB/a9yxslK1rDnjdvMk005CbVlrKz9yLXvE+e+Ejv3nAlZLXDn5Uur2/3MS3LukDRZ50occ9f0iT8MoxuI8HDJFu3GobyIqDMydAZexX6BMOWqlh4x/YOzg5IBLEELZ3VM84XcTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Cc: davem@davemloft.net,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	fw@strlen.de,
	torvalds@linuxfoundation.org
Subject: [PATCH net 1/2] netfilter: fix undefined reference to 'netfilter_lwtunnel_*' when CONFIG_SYSCTL=n
Date: Thu, 27 Jun 2024 01:38:44 +0200
Message-Id: <20240626233845.151197-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240626233845.151197-1-pablo@netfilter.org>
References: <20240626233845.151197-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianguo Wu <wujianguo@chinatelecom.cn>

if CONFIG_SYSFS is not enabled in config, we get the below compile error,

All errors (new ones prefixed by >>):

   csky-linux-ld: net/netfilter/core.o: in function `netfilter_init':
   core.c:(.init.text+0x42): undefined reference to `netfilter_lwtunnel_init'
>> csky-linux-ld: core.c:(.init.text+0x56): undefined reference to `netfilter_lwtunnel_fini'
>> csky-linux-ld: core.c:(.init.text+0x70): undefined reference to `netfilter_lwtunnel_init'
   csky-linux-ld: core.c:(.init.text+0x78): undefined reference to `netfilter_lwtunnel_fini'

Fixes: a2225e0250c5 ("netfilter: move the sysctl nf_hooks_lwtunnel into the netfilter core")
Reported-by: Mirsad Todorovac <mtodorovac69@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202406210511.8vbByYj3-lkp@intel.com/
Closes: https://lore.kernel.org/oe-kbuild-all/202406210520.6HmrUaA2-lkp@intel.com/
Signed-off-by: Jianguo Wu <wujianguo@chinatelecom.cn>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_hooks_lwtunnel.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netfilter/nf_hooks_lwtunnel.c b/net/netfilter/nf_hooks_lwtunnel.c
index 7cdb59bb4459..d8ebebc9775d 100644
--- a/net/netfilter/nf_hooks_lwtunnel.c
+++ b/net/netfilter/nf_hooks_lwtunnel.c
@@ -117,4 +117,7 @@ void netfilter_lwtunnel_fini(void)
 {
 	unregister_pernet_subsys(&nf_lwtunnel_net_ops);
 }
+#else
+int __init netfilter_lwtunnel_init(void) { return 0; }
+void netfilter_lwtunnel_fini(void) {}
 #endif /* CONFIG_SYSCTL */
-- 
2.30.2


