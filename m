Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1888574C9B
	for <lists+netfilter-devel@lfdr.de>; Thu, 25 Jul 2019 13:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403881AbfGYLNB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 25 Jul 2019 07:13:01 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:19904 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390345AbfGYLNB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 25 Jul 2019 07:13:01 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 5081F41D79;
        Thu, 25 Jul 2019 19:12:57 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf-next v6 4/8] bridge: add br_vlan_get_info_rcu()
Date:   Thu, 25 Jul 2019 19:12:52 +0800
Message-Id: <1564053176-28605-5-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1564053176-28605-1-git-send-email-wenxu@ucloud.cn>
References: <1564053176-28605-1-git-send-email-wenxu@ucloud.cn>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZVklVSUlMS0tLSUhNTkpKSUhZV1koWU
        FJQjdXWS1ZQUlXWQkOFx4IWUFZNTQpNjo3JCkuNz5ZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PCo6Pyo6SDg#HFYpKwg8PxA1
        SxkKCUhVSlVKTk1PS05ISkxMT0tCVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUlCQkI3Bg++
X-HM-Tid: 0a6c28d583fc2086kuqy5081f41d79
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This new function allows you to fetch vlan info from packet path.

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
v6: no change

 include/linux/if_bridge.h |  7 +++++++
 net/bridge/br_vlan.c      | 25 +++++++++++++++++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/if_bridge.h b/include/linux/if_bridge.h
index 9e57c44..5c85608 100644
--- a/include/linux/if_bridge.h
+++ b/include/linux/if_bridge.h
@@ -92,6 +92,8 @@ static inline bool br_multicast_router(const struct net_device *dev)
 int br_vlan_get_proto(const struct net_device *dev, u16 *p_proto);
 int br_vlan_get_info(const struct net_device *dev, u16 vid,
 		     struct bridge_vlan_info *p_vinfo);
+int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+			 struct bridge_vlan_info *p_vinfo);
 #else
 static inline bool br_vlan_enabled(const struct net_device *dev)
 {
@@ -118,6 +120,11 @@ static inline int br_vlan_get_info(const struct net_device *dev, u16 vid,
 {
 	return -EINVAL;
 }
+static inline int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+				       struct bridge_vlan_info *p_vinfo)
+{
+	return -EINVAL;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_BRIDGE)
diff --git a/net/bridge/br_vlan.c b/net/bridge/br_vlan.c
index 021cc9f66..8a9a26e 100644
--- a/net/bridge/br_vlan.c
+++ b/net/bridge/br_vlan.c
@@ -1293,6 +1293,31 @@ int br_vlan_get_info(const struct net_device *dev, u16 vid,
 }
 EXPORT_SYMBOL_GPL(br_vlan_get_info);
 
+int br_vlan_get_info_rcu(const struct net_device *dev, u16 vid,
+			 struct bridge_vlan_info *p_vinfo)
+{
+	struct net_bridge_vlan_group *vg;
+	struct net_bridge_vlan *v;
+	struct net_bridge_port *p;
+
+	p = br_port_get_check_rcu(dev);
+	if (p)
+		vg = nbp_vlan_group_rcu(p);
+	else if (netif_is_bridge_master(dev))
+		vg = br_vlan_group_rcu(netdev_priv(dev));
+	else
+		return -EINVAL;
+
+	v = br_vlan_find(vg, vid);
+	if (!v)
+		return -ENOENT;
+
+	p_vinfo->vid = vid;
+	p_vinfo->flags = v->flags;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(br_vlan_get_info_rcu);
+
 static int br_vlan_is_bind_vlan_dev(const struct net_device *dev)
 {
 	return is_vlan_dev(dev) &&
-- 
1.8.3.1

