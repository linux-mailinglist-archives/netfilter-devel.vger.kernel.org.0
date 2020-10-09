Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E60B288302
	for <lists+netfilter-devel@lfdr.de>; Fri,  9 Oct 2020 08:53:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725908AbgJIGxY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 9 Oct 2020 02:53:24 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14807 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725922AbgJIGxY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 9 Oct 2020 02:53:24 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 25B52E65A27EE55F2C9A;
        Fri,  9 Oct 2020 14:52:57 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 9 Oct 2020
 14:52:48 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <pablo@netfilter.org>, <kadlec@netfilter.org>, <fw@strlen.de>,
        <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>
CC:     Ye Bin <yebin10@huawei.com>
Subject: [PATCH] netfilter: nf_conntrack_sip: Fix inconsistent of format with argument type in nf_nat_sip.
Date:   Fri, 9 Oct 2020 15:03:35 +0800
Message-ID: <20201009070335.63812-1-yebin10@huawei.com>
X-Mailer: git-send-email 2.16.2.dirty
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix follow warning:
[net/netfilter/nf_nat_sip.c:469]: (warning) %u in format string (no. 1)
requires 'unsigned int' but the argument type is 'int'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 net/netfilter/nf_nat_sip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_nat_sip.c b/net/netfilter/nf_nat_sip.c
index f0a735e86851..39754fb3a298 100644
--- a/net/netfilter/nf_nat_sip.c
+++ b/net/netfilter/nf_nat_sip.c
@@ -466,7 +466,7 @@ static int mangle_content_len(struct sk_buff *skb, unsigned int protoff,
 			      &matchoff, &matchlen) <= 0)
 		return 0;
 
-	buflen = sprintf(buffer, "%u", c_len);
+	buflen = sprintf(buffer, "%d", c_len);
 	return mangle_packet(skb, protoff, dataoff, dptr, datalen,
 			     matchoff, matchlen, buffer, buflen);
 }
-- 
2.16.2.dirty

