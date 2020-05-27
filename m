Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C48921E3ECF
	for <lists+netfilter-devel@lfdr.de>; Wed, 27 May 2020 12:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbgE0KSY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 May 2020 06:18:24 -0400
Received: from correo.us.es ([193.147.175.20]:45176 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725852AbgE0KSY (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 May 2020 06:18:24 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6B431FD3D0
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:18:21 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 5CA07DA70F
        for <netfilter-devel@vger.kernel.org>; Wed, 27 May 2020 12:18:21 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 5BC24DA709; Wed, 27 May 2020 12:18:21 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3FF46DA723;
        Wed, 27 May 2020 12:18:19 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 27 May 2020 12:18:19 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 16F4942EE38E;
        Wed, 27 May 2020 12:18:19 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     colin.king@canonical.com
Subject: [PATCH] netfilter: nfnetlink_cthelper: protocol offset signess in IPv6
Date:   Wed, 27 May 2020 12:18:16 +0200
Message-Id: <20200527101816.1839-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

net/netfilter/nf_conntrack_core.c: In function nf_confirm_cthelper:
net/netfilter/nf_conntrack_core.c:2117:15: warning: comparison of unsigned expression in < 0 is always false [-Wtype-limits]
 2117 |   if (protoff < 0 || (frag_off & htons(~0x7)) != 0)
      |               ^

ipv6_skip_exthdr() returns a signed integer.

Reported-by: Colin Ian King <colin.king@canonical.com>
Fixes: 703acd70f249 ("netfilter: nfnetlink_cthelper: unbreak userspace helper support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_core.c b/net/netfilter/nf_conntrack_core.c
index e3b054a2f796..bb72ca5f3999 100644
--- a/net/netfilter/nf_conntrack_core.c
+++ b/net/netfilter/nf_conntrack_core.c
@@ -2092,7 +2092,7 @@ static int nf_confirm_cthelper(struct sk_buff *skb, struct nf_conn *ct,
 {
 	const struct nf_conntrack_helper *helper;
 	const struct nf_conn_help *help;
-	unsigned int protoff;
+	int protoff;
 
 	help = nfct_help(ct);
 	if (!help)
-- 
2.20.1

