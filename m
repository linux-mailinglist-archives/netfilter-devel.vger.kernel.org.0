Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 546B8346ED0
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Mar 2021 02:32:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbhCXBb4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Mar 2021 21:31:56 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60610 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234524AbhCXBbW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Mar 2021 21:31:22 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 151F4630BB;
        Wed, 24 Mar 2021 02:31:13 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org, kuba@kernel.org
Subject: [PATCH net-next,v2 21/24] net: ethernet: mtk_eth_soc: fix parsing packets in GDM
Date:   Wed, 24 Mar 2021 02:30:52 +0100
Message-Id: <20210324013055.5619-22-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210324013055.5619-1-pablo@netfilter.org>
References: <20210324013055.5619-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Felix Fietkau <nbd@nbd.name>

When using DSA, set the special tag in GDM ingress control to allow the MAC
to parse packets properly earlier. This affects rx DMA source port reporting.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: formely patch #23, now patch #21.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 15 +++++++++------
 drivers/net/ethernet/mediatek/mtk_eth_soc.h |  2 ++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 01d3ee4b5829..cf65fbdf60e0 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -19,6 +19,7 @@
 #include <linux/interrupt.h>
 #include <linux/pinctrl/devinfo.h>
 #include <linux/phylink.h>
+#include <net/dsa.h>
 
 #include "mtk_eth_soc.h"
 
@@ -1264,13 +1265,12 @@ static int mtk_poll_rx(struct napi_struct *napi, int budget,
 			break;
 
 		/* find out which mac the packet come from. values start at 1 */
-		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628)) {
+		if (MTK_HAS_CAPS(eth->soc->caps, MTK_SOC_MT7628) ||
+		    (trxd.rxd4 & RX_DMA_SPECIAL_TAG))
 			mac = 0;
-		} else {
-			mac = (trxd.rxd4 >> RX_DMA_FPORT_SHIFT) &
-				RX_DMA_FPORT_MASK;
-			mac--;
-		}
+		else
+			mac = ((trxd.rxd4 >> RX_DMA_FPORT_SHIFT) &
+			       RX_DMA_FPORT_MASK) - 1;
 
 		if (unlikely(mac < 0 || mac >= MTK_MAC_COUNT ||
 			     !eth->netdev[mac]))
@@ -2233,6 +2233,9 @@ static void mtk_gdm_config(struct mtk_eth *eth, u32 config)
 
 		val |= config;
 
+		if (!i && eth->netdev[0] && netdev_uses_dsa(eth->netdev[0]))
+			val |= MTK_GDMA_SPECIAL_TAG;
+
 		mtk_w32(eth, val, MTK_GDMA_FWD_CFG(i));
 	}
 	/* Reset and enable PSE */
diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.h b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
index fd3cec8f06ba..2d065d47dbfd 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.h
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.h
@@ -82,6 +82,7 @@
 
 /* GDM Exgress Control Register */
 #define MTK_GDMA_FWD_CFG(x)	(0x500 + (x * 0x1000))
+#define MTK_GDMA_SPECIAL_TAG	BIT(24)
 #define MTK_GDMA_ICS_EN		BIT(22)
 #define MTK_GDMA_TCS_EN		BIT(21)
 #define MTK_GDMA_UCS_EN		BIT(20)
@@ -305,6 +306,7 @@
 #define RX_DMA_L4_VALID_PDMA	BIT(30)		/* when PDMA is used */
 #define RX_DMA_FPORT_SHIFT	19
 #define RX_DMA_FPORT_MASK	0x7
+#define RX_DMA_SPECIAL_TAG	BIT(22)
 
 /* PHY Indirect Access Control registers */
 #define MTK_PHY_IAC		0x10004
-- 
2.20.1

