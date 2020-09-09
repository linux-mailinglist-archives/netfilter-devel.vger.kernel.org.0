Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE72C262C4A
	for <lists+netfilter-devel@lfdr.de>; Wed,  9 Sep 2020 11:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726399AbgIIJnY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 9 Sep 2020 05:43:24 -0400
Received: from correo.us.es ([193.147.175.20]:34866 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729738AbgIIJmh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 9 Sep 2020 05:42:37 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id ACDBB2EFEDE
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Sep 2020 11:42:31 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 96E5DE1506
        for <netfilter-devel@vger.kernel.org>; Wed,  9 Sep 2020 11:42:31 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9521EE1505; Wed,  9 Sep 2020 11:42:31 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WELCOMELIST,USER_IN_WHITELIST
        autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4EFEEDA8F3;
        Wed,  9 Sep 2020 11:42:29 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 09 Sep 2020 11:42:29 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 223544301DE1;
        Wed,  9 Sep 2020 11:42:29 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 08/13] netfilter: xt_HMARK: Use ip_is_fragment() helper
Date:   Wed,  9 Sep 2020 11:42:14 +0200
Message-Id: <20200909094219.17732-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200909094219.17732-1-pablo@netfilter.org>
References: <20200909094219.17732-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

Use ip_is_fragment() to simpify code.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/xt_HMARK.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/xt_HMARK.c b/net/netfilter/xt_HMARK.c
index 713fb38541df..8928ec56c388 100644
--- a/net/netfilter/xt_HMARK.c
+++ b/net/netfilter/xt_HMARK.c
@@ -276,7 +276,7 @@ hmark_pkt_set_htuple_ipv4(const struct sk_buff *skb, struct hmark_tuple *t,
 		return 0;
 
 	/* follow-up fragments don't contain ports, skip all fragments */
-	if (ip->frag_off & htons(IP_MF | IP_OFFSET))
+	if (ip_is_fragment(ip))
 		return 0;
 
 	hmark_set_tuple_ports(skb, (ip->ihl * 4) + nhoff, t, info);
-- 
2.20.1

