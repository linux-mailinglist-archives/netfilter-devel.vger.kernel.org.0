Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88F426D3CA
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Jul 2019 20:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726649AbfGRSXq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Jul 2019 14:23:46 -0400
Received: from mail.us.es ([193.147.175.20]:38004 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727762AbfGRSXq (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Jul 2019 14:23:46 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 26F26B5AAE
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:23:44 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1803EDA732
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:23:44 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0D98ADA708; Thu, 18 Jul 2019 20:23:44 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 183EA9615A
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:23:42 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 18 Jul 2019 20:23:42 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id EDB4C4265A2F
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Jul 2019 20:23:41 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: bridge: NF_CONNTRACK_BRIDGE does not depend on NF_TABLES_BRIDGE
Date:   Thu, 18 Jul 2019 20:23:37 +0200
Message-Id: <20190718182337.1625-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190718182337.1625-1-pablo@netfilter.org>
References: <20190718182337.1625-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Place NF_CONNTRACK_BRIDGE away from the NF_TABLES_BRIDGE dependency.

Fixes: 3c171f496ef5 ("netfilter: bridge: add connection tracking system")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/bridge/netfilter/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bridge/netfilter/Kconfig b/net/bridge/netfilter/Kconfig
index d0c75d7ec074..5040fe43f4b4 100644
--- a/net/bridge/netfilter/Kconfig
+++ b/net/bridge/netfilter/Kconfig
@@ -25,6 +25,8 @@ config NF_LOG_BRIDGE
 	tristate "Bridge packet logging"
 	select NF_LOG_COMMON
 
+endif # NF_TABLES_BRIDGE
+
 config NF_CONNTRACK_BRIDGE
 	tristate "IPv4/IPV6 bridge connection tracking support"
 	depends on NF_CONNTRACK
@@ -39,8 +41,6 @@ config NF_CONNTRACK_BRIDGE
 
 	  To compile it as a module, choose M here.  If unsure, say N.
 
-endif # NF_TABLES_BRIDGE
-
 menuconfig BRIDGE_NF_EBTABLES
 	tristate "Ethernet Bridge tables (ebtables) support"
 	depends on BRIDGE && NETFILTER && NETFILTER_XTABLES
-- 
2.11.0

