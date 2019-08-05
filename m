Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6099481339
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Aug 2019 09:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbfHEHer (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 5 Aug 2019 03:34:47 -0400
Received: from mail.fem.tu-ilmenau.de ([141.24.220.54]:50324 "EHLO
        mail.fem.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726394AbfHEHer (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 5 Aug 2019 03:34:47 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Mon, 05 Aug 2019 03:34:45 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.fem.tu-ilmenau.de (Postfix) with ESMTP id D9E7C63A6;
        Mon,  5 Aug 2019 09:28:34 +0200 (CEST)
X-Virus-Scanned: amavisd-new at fem.tu-ilmenau.de
Received: from mail.fem.tu-ilmenau.de ([127.0.0.1])
        by localhost (mail.fem.tu-ilmenau.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XpvJ9+gRMJbQ; Mon,  5 Aug 2019 09:28:31 +0200 (CEST)
Received: from mail-backup.fem.tu-ilmenau.de (mail-backup.net.fem.tu-ilmenau.de [10.42.40.22])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.fem.tu-ilmenau.de (Postfix) with ESMTPS;
        Mon,  5 Aug 2019 09:28:31 +0200 (CEST)
Received: from a234.fem.tu-ilmenau.de (ray-controller.net.fem.tu-ilmenau.de [10.42.51.234])
        by mail-backup.fem.tu-ilmenau.de (Postfix) with ESMTP id 0857655119;
        Mon,  5 Aug 2019 09:28:31 +0200 (CEST)
Received: by a234.fem.tu-ilmenau.de (Postfix, from userid 1000)
        id D9F15306AC9A; Mon,  5 Aug 2019 09:28:30 +0200 (CEST)
From:   Michael Braun <michael-dev@fami-braun.de>
To:     netfilter-devel@vger.kernel.org
Cc:     Michael Braun <michael-dev@fami-braun.de>
Subject: [PATCH] netfilter: nfnetlink_log:add support for VLAN information
Date:   Mon,  5 Aug 2019 09:28:14 +0200
Message-Id: <20190805072814.14922-1-michael-dev@fami-braun.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Currently, there is no vlan information (e.g. when used with a vlan aware
bridge) passed to userspache, HWHEADER will contain an 08 00 (ip) suffix
even for tagged ip packets.

Therefore, add an extra netlink attribute that passes the vlan tag to
userspace. Userspace might need to handle PCP/DEI included in this field.

Signed-off-by: Michael Braun <michael-dev@fami-braun.de>
---
 include/uapi/linux/netfilter/nfnetlink_log.h | 1 +
 net/netfilter/nf_log_common.c                | 2 ++
 net/netfilter/nfnetlink_log.c                | 6 ++++++
 3 files changed, 9 insertions(+)

diff --git a/include/uapi/linux/netfilter/nfnetlink_log.h b/include/uapi/linux/netfilter/nfnetlink_log.h
index 20983cb195a0..d15f74d47f48 100644
--- a/include/uapi/linux/netfilter/nfnetlink_log.h
+++ b/include/uapi/linux/netfilter/nfnetlink_log.h
@@ -54,6 +54,7 @@ enum nfulnl_attr_type {
 	NFULA_HWLEN,			/* hardware header length */
 	NFULA_CT,                       /* nf_conntrack_netlink.h */
 	NFULA_CT_INFO,                  /* enum ip_conntrack_info */
+	NFULA_VLAN_TAG,                 /* __u16 vlan tag */
 
 	__NFULA_MAX
 };
diff --git a/net/netfilter/nf_log_common.c b/net/netfilter/nf_log_common.c
index ae5628ddbe6d..57c4cc8fbead 100644
--- a/net/netfilter/nf_log_common.c
+++ b/net/netfilter/nf_log_common.c
@@ -160,6 +160,8 @@ nf_log_dump_packet_common(struct nf_log_buf *m, u_int8_t pf,
 	       '0' + loginfo->u.log.level, prefix,
 	       in ? in->name : "",
 	       out ? out->name : "");
+	if (skb_vlan_tag_present(skb))
+		nf_log_buf_add(m, "VLAN=%d ", skb_vlan_tag_get_id(skb));
 #if IS_ENABLED(CONFIG_BRIDGE_NETFILTER)
 	physindev = nf_bridge_get_physindev(skb);
 	if (physindev && in != physindev)
diff --git a/net/netfilter/nfnetlink_log.c b/net/netfilter/nfnetlink_log.c
index 6dee4f9a944c..f6fe0d760816 100644
--- a/net/netfilter/nfnetlink_log.c
+++ b/net/netfilter/nfnetlink_log.c
@@ -16,6 +16,7 @@
 #include <linux/skbuff.h>
 #include <linux/if_arp.h>
 #include <linux/init.h>
+#include <linux/if_vlan.h>
 #include <linux/ip.h>
 #include <linux/ipv6.h>
 #include <linux/netdevice.h>
@@ -580,6 +581,11 @@ __build_packet_message(struct nfnl_log_net *log,
 				 NFULA_CT, NFULA_CT_INFO) < 0)
 		goto nla_put_failure;
 
+	if (skb_vlan_tag_present(skb) &&
+	    nla_put_be16(inst->skb, NFULA_VLAN_TAG,
+			 htons(skb_vlan_tag_get(skb))))
+		goto nla_put_failure;
+
 	if (data_len) {
 		struct nlattr *nla;
 		int size = nla_attr_size(data_len);
-- 
2.20.1

