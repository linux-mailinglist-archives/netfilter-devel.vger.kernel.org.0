Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AFD5346EB4
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 02:32:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234549AbhCXBbp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Mar 2021 21:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234324AbhCXBbM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:31:12 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0A4F7C061765;
        Tue, 23 Mar 2021 18:31:11 -0700 (PDT)
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id A6DE862C0E;
        Wed, 24 Mar 2021 02:31:03 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net-next,v2 05/24] net: ppp: resolve forwarding path for bridge pppoe devices
Date:   Wed, 24 Mar 2021 02:30:36 +0100
Message-Id: <20210324013055.5619-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324013055.5619-1-pablo@netfilter.org>
References: <20210324013055.5619-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

Pass on the PPPoE session ID, destination hardware address and the real
device.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: no changes.

 drivers/net/ppp/ppp_generic.c | 22 ++++++++++++++++++++++
 drivers/net/ppp/pppoe.c       | 23 +++++++++++++++++++++++
 include/linux/netdevice.h     |  2 ++
 include/linux/ppp_channel.h   |  3 +++
 4 files changed, 50 insertions(+)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index d445ecb1d0c7..930e49ef15f6 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -1560,12 +1560,34 @@ static void ppp_dev_priv_destructor(struct net_device *dev)
 		ppp_destroy_interface(ppp);
 }
 
+static int ppp_fill_forward_path(struct net_device_path_ctx *ctx,
+				 struct net_device_path *path)
+{
+	struct ppp *ppp = netdev_priv(ctx->dev);
+	struct ppp_channel *chan;
+	struct channel *pch;
+
+	if (ppp->flags & SC_MULTILINK)
+		return -EOPNOTSUPP;
+
+	if (list_empty(&ppp->channels))
+		return -ENODEV;
+
+	pch = list_first_entry(&ppp->channels, struct channel, clist);
+	chan = pch->chan;
+	if (!chan->ops->fill_forward_path)
+		return -EOPNOTSUPP;
+
+	return chan->ops->fill_forward_path(ctx, path, chan);
+}
+
 static const struct net_device_ops ppp_netdev_ops = {
 	.ndo_init	 = ppp_dev_init,
 	.ndo_uninit      = ppp_dev_uninit,
 	.ndo_start_xmit  = ppp_start_xmit,
 	.ndo_do_ioctl    = ppp_net_ioctl,
 	.ndo_get_stats64 = ppp_get_stats64,
+	.ndo_fill_forward_path = ppp_fill_forward_path,
 };
 
 static struct device_type ppp_type = {
diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 9dc7f4b93d51..3619520340b7 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -972,8 +972,31 @@ static int pppoe_xmit(struct ppp_channel *chan, struct sk_buff *skb)
 	return __pppoe_xmit(sk, skb);
 }
 
+static int pppoe_fill_forward_path(struct net_device_path_ctx *ctx,
+				   struct net_device_path *path,
+				   const struct ppp_channel *chan)
+{
+	struct sock *sk = (struct sock *)chan->private;
+	struct pppox_sock *po = pppox_sk(sk);
+	struct net_device *dev = po->pppoe_dev;
+
+	if (sock_flag(sk, SOCK_DEAD) ||
+	    !(sk->sk_state & PPPOX_CONNECTED) || !dev)
+		return -1;
+
+	path->type = DEV_PATH_PPPOE;
+	path->encap.proto = htons(ETH_P_PPP_SES);
+	path->encap.id = be16_to_cpu(po->num);
+	memcpy(path->encap.h_dest, po->pppoe_pa.remote, ETH_ALEN);
+	path->dev = ctx->dev;
+	ctx->dev = dev;
+
+	return 0;
+}
+
 static const struct ppp_channel_ops pppoe_chan_ops = {
 	.start_xmit = pppoe_xmit,
+	.fill_forward_path = pppoe_fill_forward_path,
 };
 
 static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
index ad67f26c77d8..cf1041756438 100644
--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -852,6 +852,7 @@ enum net_device_path_type {
 	DEV_PATH_ETHERNET = 0,
 	DEV_PATH_VLAN,
 	DEV_PATH_BRIDGE,
+	DEV_PATH_PPPOE,
 };
 
 struct net_device_path {
@@ -861,6 +862,7 @@ struct net_device_path {
 		struct {
 			u16		id;
 			__be16		proto;
+			u8		h_dest[ETH_ALEN];
 		} encap;
 		struct {
 			enum {
diff --git a/include/linux/ppp_channel.h b/include/linux/ppp_channel.h
index 98966064ee68..91f9a928344e 100644
--- a/include/linux/ppp_channel.h
+++ b/include/linux/ppp_channel.h
@@ -28,6 +28,9 @@ struct ppp_channel_ops {
 	int	(*start_xmit)(struct ppp_channel *, struct sk_buff *);
 	/* Handle an ioctl call that has come in via /dev/ppp. */
 	int	(*ioctl)(struct ppp_channel *, unsigned int, unsigned long);
+	int	(*fill_forward_path)(struct net_device_path_ctx *,
+				     struct net_device_path *,
+				     const struct ppp_channel *);
 };
 
 struct ppp_channel {
-- 
2.20.1

