Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C474A8DF9
	for <lists+netfilter-devel@lfdr.de>; Thu,  3 Feb 2022 21:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354357AbiBCUeN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 3 Feb 2022 15:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354401AbiBCUdC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 3 Feb 2022 15:33:02 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20C1C061786;
        Thu,  3 Feb 2022 12:32:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B2894B835AC;
        Thu,  3 Feb 2022 20:32:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 466C4C36AE9;
        Thu,  3 Feb 2022 20:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643920374;
        bh=IpJaUgCby7BfLwA8UIjAkqWSIcHsUn66qeLSJKTrifk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SOzSVj0mRH3O6k5gotBnpelYn6QNHk9TJfG6CFIvHWlZ0DRx1AqPOY36YP9ykOlGh
         1zU52I71snumjnhhBEDI551ZS3XsMmZe4udtO0/l8SEM2TpzO93G/yTaBjOEsmizm5
         doF109sOsJrEQkIZHbgMKwl9S74r1PdrQOyzlGPDR1phX3w/SBOtmP5nzr6d85TCsH
         QvW2Xf3bVIIwr9EcELA5dJOCp2NW8jQZ5Q1HflWF0BvsB0xYAZlsET0qzJYL+wYblh
         80y5QP9ndvYeiFa29cLTM9+OQPFOUXNq0K917QplJ1fFFYOX+TdSRQ2jviHb1UER5S
         q9lzJzO7AeEJg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Florian Westphal <fw@strlen.de>, Yi Chen <yiche@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sasha Levin <sashal@kernel.org>, kadlec@netfilter.org,
        davem@davemloft.net, kuba@kernel.org,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 05/41] netfilter: nf_conntrack_netbios_ns: fix helper module alias
Date:   Thu,  3 Feb 2022 15:32:09 -0500
Message-Id: <20220203203245.3007-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220203203245.3007-1-sashal@kernel.org>
References: <20220203203245.3007-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Florian Westphal <fw@strlen.de>

[ Upstream commit 0e906607b9c5ee22312c9af4d8adb45c617ea38a ]

The helper gets registered as 'netbios-ns', not netbios_ns.
Intentionally not adding a fixes-tag because i don't want this to go to
stable. This wasn't noticed for a very long time so no so no need to risk
regressions.

Reported-by: Yi Chen <yiche@redhat.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netbios_ns.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netbios_ns.c b/net/netfilter/nf_conntrack_netbios_ns.c
index 7f19ee2596090..55415f011943d 100644
--- a/net/netfilter/nf_conntrack_netbios_ns.c
+++ b/net/netfilter/nf_conntrack_netbios_ns.c
@@ -20,13 +20,14 @@
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_expect.h>
 
+#define HELPER_NAME	"netbios-ns"
 #define NMBD_PORT	137
 
 MODULE_AUTHOR("Patrick McHardy <kaber@trash.net>");
 MODULE_DESCRIPTION("NetBIOS name service broadcast connection tracking helper");
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("ip_conntrack_netbios_ns");
-MODULE_ALIAS_NFCT_HELPER("netbios_ns");
+MODULE_ALIAS_NFCT_HELPER(HELPER_NAME);
 
 static unsigned int timeout __read_mostly = 3;
 module_param(timeout, uint, 0400);
@@ -44,7 +45,7 @@ static int netbios_ns_help(struct sk_buff *skb, unsigned int protoff,
 }
 
 static struct nf_conntrack_helper helper __read_mostly = {
-	.name			= "netbios-ns",
+	.name			= HELPER_NAME,
 	.tuple.src.l3num	= NFPROTO_IPV4,
 	.tuple.src.u.udp.port	= cpu_to_be16(NMBD_PORT),
 	.tuple.dst.protonum	= IPPROTO_UDP,
-- 
2.34.1

