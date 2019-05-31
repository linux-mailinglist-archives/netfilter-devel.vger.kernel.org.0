Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81845306B8
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 04:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbfEaCr6 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 22:47:58 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45926 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbfEaCr6 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 22:47:58 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 682805B63DFC80789401;
        Fri, 31 May 2019 10:47:55 +0800 (CST)
Received: from localhost (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Fri, 31 May 2019
 10:47:46 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <pablo@netfilter.org>, <kadlec@blackhole.kfki.hu>, <fw@strlen.de>
CC:     <linux-kernel@vger.kernel.org>, <coreteam@netfilter.org>,
        <netfilter-devel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH net-next] netfilter: nf_conntrack_bridge: Fix build error without IPV6
Date:   Fri, 31 May 2019 10:46:43 +0800
Message-ID: <20190531024643.3840-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix gcc build error while CONFIG_IPV6 is not set

In file included from net/netfilter/core.c:19:0:
./include/linux/netfilter_ipv6.h: In function 'nf_ipv6_br_defrag':
./include/linux/netfilter_ipv6.h:110:9: error: implicit declaration of function 'nf_ct_frag6_gather' [-Werror=implicit-function-declaration]

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 764dd163ac92 ("netfilter: nf_conntrack_bridge: add support for IPv6")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/linux/netfilter_ipv6.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/netfilter_ipv6.h b/include/linux/netfilter_ipv6.h
index a21b8c9..4ea97fd 100644
--- a/include/linux/netfilter_ipv6.h
+++ b/include/linux/netfilter_ipv6.h
@@ -96,6 +96,8 @@ static inline int nf_ip6_route(struct net *net, struct dst_entry **dst,
 #endif
 }
 
+int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user);
+
 static inline int nf_ipv6_br_defrag(struct net *net, struct sk_buff *skb,
 				    u32 user)
 {
-- 
2.7.4


