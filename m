Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0FC28F6C2
	for <lists+netfilter-devel@lfdr.de>; Thu, 15 Oct 2020 18:31:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389853AbgJOQa7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 15 Oct 2020 12:30:59 -0400
Received: from correo.us.es ([193.147.175.20]:47280 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389793AbgJOQav (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 15 Oct 2020 12:30:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 83B1AE2C69
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Oct 2020 18:30:49 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 76C0FDA792
        for <netfilter-devel@vger.kernel.org>; Thu, 15 Oct 2020 18:30:49 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 75CDADA791; Thu, 15 Oct 2020 18:30:49 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 74CCEDA73D;
        Thu, 15 Oct 2020 18:30:47 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 15 Oct 2020 18:30:47 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 4372C42EF4E2;
        Thu, 15 Oct 2020 18:30:47 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net-next,v2 4/9] bridge: resolve forwarding path for bridge devices
Date:   Thu, 15 Oct 2020 18:30:33 +0200
Message-Id: <20201015163038.26992-5-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201015163038.26992-1-pablo@netfilter.org>
References: <20201015163038.26992-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add .ndo_fill_forward_path for bridge devices.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes

 include/linux/netdevice.h |  1 +
 net/bridge/br_device.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index d4263ed5dd79..4cabdbc672d3 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -836,6 +836,7 @@ typedef u16 (*select_queue_fallback_t)(struct net_device *dev,
 enum net_device_path_type {
 	DEV_PATH_ETHERNET = 0,
 	DEV_PATH_VLAN,
+	DEV_PATH_BRIDGE,
 };
 
 struct net_device_path {
diff --git a/net/bridge/br_device.c b/net/bridge/br_device.c
index 6f742fee874a..06046a35868d 100644
--- a/net/bridge/br_device.c
+++ b/net/bridge/br_device.c
@@ -391,6 +391,27 @@ static int br_del_slave(struct net_device *dev, struct net_device *slave_dev)
 	return br_del_if(br, slave_dev);
 }
 
+static int br_fill_forward_path(struct net_device_path_ctx *ctx,
+				struct net_device_path *path)
+{
+	struct net_bridge_fdb_entry *f;
+	struct net_bridge *br;
+
+	if (netif_is_bridge_port(ctx->dev))
+		return -1;
+
+	br = netdev_priv(ctx->dev);
+	f = br_fdb_find_rcu(br, ctx->daddr, 0);
+	if (!f || !f->dst)
+		return -1;
+
+	path->type = DEV_PATH_BRIDGE;
+	path->dev = f->dst->br->dev;
+	ctx->dev = f->dst->dev;
+
+	return 0;
+}
+
 static const struct ethtool_ops br_ethtool_ops = {
 	.get_drvinfo		 = br_getinfo,
 	.get_link		 = ethtool_op_get_link,
@@ -425,6 +446,7 @@ static const struct net_device_ops br_netdev_ops = {
 	.ndo_bridge_setlink	 = br_setlink,
 	.ndo_bridge_dellink	 = br_dellink,
 	.ndo_features_check	 = passthru_features_check,
+	.ndo_fill_forward_path	 = br_fill_forward_path,
 };
 
 static struct device_type br_type = {
-- 
2.20.1

