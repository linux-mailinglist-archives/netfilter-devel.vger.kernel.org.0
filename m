Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C070B1C41
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 13:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388200AbfIMLbc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 07:31:32 -0400
Received: from correo.us.es ([193.147.175.20]:42768 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388184AbfIMLbb (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:31:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 500434FFE01
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 13:31:28 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 414CAA7E1C
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 13:31:28 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 36AF5A7E0F; Fri, 13 Sep 2019 13:31:28 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 31AE8A7E1C;
        Fri, 13 Sep 2019 13:31:26 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 13 Sep 2019 13:31:26 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0056F4265A5A;
        Fri, 13 Sep 2019 13:31:25 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 27/27] netfilter: conntrack: remove two unused functions from nf_conntrack_timestamp.h.
Date:   Fri, 13 Sep 2019 13:31:02 +0200
Message-Id: <20190913113102.15776-28-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190913113102.15776-1-pablo@netfilter.org>
References: <20190913113102.15776-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

Two inline functions defined in nf_conntrack_timestamp.h,
`nf_ct_tstamp_enabled` and `nf_ct_set_tstamp`, are not called anywhere.
Remove them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack_timestamp.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_timestamp.h b/include/net/netfilter/nf_conntrack_timestamp.h
index 2b8aeba649aa..820ea34b6029 100644
--- a/include/net/netfilter/nf_conntrack_timestamp.h
+++ b/include/net/netfilter/nf_conntrack_timestamp.h
@@ -38,22 +38,6 @@ struct nf_conn_tstamp *nf_ct_tstamp_ext_add(struct nf_conn *ct, gfp_t gfp)
 #endif
 };
 
-static inline bool nf_ct_tstamp_enabled(struct net *net)
-{
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
-	return net->ct.sysctl_tstamp != 0;
-#else
-	return false;
-#endif
-}
-
-static inline void nf_ct_set_tstamp(struct net *net, bool enable)
-{
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
-	net->ct.sysctl_tstamp = enable;
-#endif
-}
-
 #ifdef CONFIG_NF_CONNTRACK_TIMESTAMP
 void nf_conntrack_tstamp_pernet_init(struct net *net);
 
-- 
2.11.0

