Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3C38C115
	for <lists+netfilter-devel@lfdr.de>; Tue, 13 Aug 2019 20:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfHMSxE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 13 Aug 2019 14:53:04 -0400
Received: from vxsys-smtpclusterma-01.srv.cat ([46.16.60.189]:58877 "EHLO
        vxsys-smtpclusterma-01.srv.cat" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbfHMSxE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 13 Aug 2019 14:53:04 -0400
Received: from localhost.localdomain (static-79-171-230-77.ipcom.comunitel.net [77.230.171.79])
        by vxsys-smtpclusterma-01.srv.cat (Postfix) with ESMTPA id 9AADD24209
        for <netfilter-devel@vger.kernel.org>; Tue, 13 Aug 2019 20:53:01 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnftnl 2/2] Sync meta keys with kernel
Date:   Tue, 13 Aug 2019 20:52:31 +0200
Message-Id: <20190813185231.7545-2-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190813185231.7545-1-a@juaristi.eus>
References: <20190813185231.7545-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 include/linux/netfilter/nf_tables.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 0a6bc7f..36d1d4e 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -794,6 +794,8 @@ enum nft_exthdr_attributes {
  * @NFT_META_SECPATH: boolean, secpath_exists (!!skb->sp)
  * @NFT_META_IIFKIND: packet input interface kind name (dev->rtnl_link_ops->kind)
  * @NFT_META_OIFKIND: packet output interface kind name (dev->rtnl_link_ops->kind)
+ * @NFT_META_BRI_IIFPVID: packet input bridge port pvid
+ * @NFT_META_BRI_IIFVPROTO: packet input bridge vlan proto
  * @NFT_META_TIME: a UNIX timestamp
  * @NFT_META_TIME_DAY: day of week
  * @NFT_META_TIME_HOUR: hour of day
@@ -827,6 +829,8 @@ enum nft_meta_keys {
 	NFT_META_SECPATH,
 	NFT_META_IIFKIND,
 	NFT_META_OIFKIND,
+	NFT_META_BRI_IIFPVID,
+	NFT_META_BRI_IIFVPROTO,
 	NFT_META_TIME,
 	NFT_META_TIME_DAY,
 	NFT_META_TIME_HOUR,
-- 
2.17.1

