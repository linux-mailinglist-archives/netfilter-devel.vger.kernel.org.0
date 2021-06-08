Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C40BF3A0559
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Jun 2021 22:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbhFHUza (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 8 Jun 2021 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbhFHUza (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 8 Jun 2021 16:55:30 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2D2C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Jun 2021 13:53:36 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lqij4-0004oS-RQ; Tue, 08 Jun 2021 22:53:30 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>, kernel test robot <lkp@intel.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [PATCH v2 nf-next] netfilter: nfnetlink_hook: add depends-on nftables
Date:   Tue,  8 Jun 2021 22:53:22 +0200
Message-Id: <20210608205322.8748-1-fw@strlen.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nfnetlink_hook.c: In function 'nfnl_hook_put_nft_chain_info':
nfnetlink_hook.c:76:7: error: implicit declaration of 'nft_is_active'

This macro is only defined when NF_TABLES is enabled.
While its possible to also add an ifdef-guard, the infrastructure
is currently not useful without nf_tables.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 252956528caa ("netfilter: add new hook nfnl subsystem")
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 v2: use depends-on to prohibit the problematic
 config setting of HOOK=y NF_TABLES=n.

 net/netfilter/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index c81321372198..54395266339d 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -22,6 +22,7 @@ config NETFILTER_FAMILY_ARP
 config NETFILTER_NETLINK_HOOK
 	tristate "Netfilter base hook dump support"
 	depends on NETFILTER_ADVANCED
+	depends on NF_TABLES
 	select NETFILTER_NETLINK
 	help
 	  If this option is enabled, the kernel will include support
-- 
2.31.1

