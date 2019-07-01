Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19A444BE39
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Jun 2019 18:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfFSQaq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Jun 2019 12:30:46 -0400
Received: from mail.us.es ([193.147.175.20]:44580 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726246AbfFSQap (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Jun 2019 12:30:45 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DCBDBF268F
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 18:30:43 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CE329DA702
        for <netfilter-devel@vger.kernel.org>; Wed, 19 Jun 2019 18:30:43 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C367ADA709; Wed, 19 Jun 2019 18:30:43 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id A5B73DA705;
        Wed, 19 Jun 2019 18:30:41 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 19 Jun 2019 18:30:41 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 7D8174265A32;
        Wed, 19 Jun 2019 18:30:41 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     ffmancera@riseup.net
Subject: [PATCH nf-next] netfilter: synproxy: use nf_cookie_v6_check() from core
Date:   Wed, 19 Jun 2019 18:30:37 +0200
Message-Id: <20190619163037.21008-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This helper function is never used and it is intended to avoid a direct
dependency with the ipv6 module.

Fixes: d7f9b2f18eae ("netfilter: synproxy: extract SYNPROXY infrastructure from {ipt, ip6t}_SYNPROXY")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_synproxy_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_synproxy_core.c b/net/netfilter/nf_synproxy_core.c
index 7bf5202e3222..24d3e564403f 100644
--- a/net/netfilter/nf_synproxy_core.c
+++ b/net/netfilter/nf_synproxy_core.c
@@ -1056,7 +1056,7 @@ synproxy_recv_client_ack_ipv6(struct net *net,
 	struct synproxy_net *snet = synproxy_pernet(net);
 	int mss;
 
-	mss = __cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
+	mss = nf_cookie_v6_check(ipv6_hdr(skb), th, ntohl(th->ack_seq) - 1);
 	if (mss == 0) {
 		this_cpu_inc(snet->stats->cookie_invalid);
 		return false;
-- 
2.11.0

