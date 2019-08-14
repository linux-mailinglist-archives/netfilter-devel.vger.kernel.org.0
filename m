Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5DA8CC27
	for <lists+netfilter-devel@lfdr.de>; Wed, 14 Aug 2019 08:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbfHNG7l (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 14 Aug 2019 02:59:41 -0400
Received: from m9784.mail.qiye.163.com ([220.181.97.84]:4728 "EHLO
        m9784.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbfHNG7k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 14 Aug 2019 02:59:40 -0400
Received: from localhost.localdomain (unknown [123.59.132.129])
        by m9784.mail.qiye.163.com (Hmail) with ESMTPA id 009CA4170C;
        Wed, 14 Aug 2019 14:59:36 +0800 (CST)
From:   wenxu@ucloud.cn
To:     pablo@netfilter.org, fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] meta: add ibrpvid and ibrvproto support
Date:   Wed, 14 Aug 2019 14:59:36 +0800
Message-Id: <1565765976-25657-1-git-send-email-wenxu@ucloud.cn>
X-Mailer: git-send-email 1.8.3.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPTUpCQkJDQkhKQ0NPQ1lXWShZQU
        lCN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6FRw6FDg9ITkRDBEoVhQp
        N08aFB1VSlVKTk1OTE1OQkxMS0JMVTMWGhIXVQweFQMOOw4YFxQOH1UYFUVZV1kSC1lBWUpJSFVO
        QlVKSElVSklCWVdZCAFZQUpPQk83Bg++
X-HM-Tid: 0a6c8eecc3b72086kuqy009ca4170c
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: wenxu <wenxu@ucloud.cn>

This can match the the pvid and vlan_proto of ibr

nft add rule bridge firewall zones meta ibrvproto 0x8100
nft add rule bridge firewall zones meta ibrpvid 100

Signed-off-by: wenxu <wenxu@ucloud.cn>
---
 src/meta.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/meta.c b/src/meta.c
index 5901c99..d45d757 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -442,6 +442,12 @@ const struct meta_template meta_templates[] = {
 	[NFT_META_OIFKIND]	= META_TEMPLATE("oifkind",   &ifname_type,
 						IFNAMSIZ * BITS_PER_BYTE,
 						BYTEORDER_HOST_ENDIAN),
+	[NFT_META_BRI_IIFPVID]	= META_TEMPLATE("ibrpvid",   &integer_type,
+						2 * BITS_PER_BYTE,
+						BYTEORDER_HOST_ENDIAN),
+	[NFT_META_BRI_IIFVPROTO] = META_TEMPLATE("ibrvproto",   &integer_type,
+						2 * BITS_PER_BYTE,
+						BYTEORDER_HOST_ENDIAN),
 };
 
 static bool meta_key_is_unqualified(enum nft_meta_keys key)
-- 
2.15.1

