Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1EB1C48
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 13:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbfIMLbo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 07:31:44 -0400
Received: from correo.us.es ([193.147.175.20]:42632 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388173AbfIMLba (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 07:31:30 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B94424FFE0A
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 13:31:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id AA439A7E21
        for <netfilter-devel@vger.kernel.org>; Fri, 13 Sep 2019 13:31:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 9FAA4A7E11; Fri, 13 Sep 2019 13:31:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9B510A7E26;
        Fri, 13 Sep 2019 13:31:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 13 Sep 2019 13:31:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 67C3142EE393;
        Fri, 13 Sep 2019 13:31:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 24/27] netfilter: conntrack: remove CONFIG_NF_CONNTRACK check from nf_conntrack_acct.h.
Date:   Fri, 13 Sep 2019 13:30:59 +0200
Message-Id: <20190913113102.15776-25-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190913113102.15776-1-pablo@netfilter.org>
References: <20190913113102.15776-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Jeremy Sowden <jeremy@azazel.net>

There is a superfluous `#if IS_ENABLED(CONFIG_NF_CONNTRACK)` check
wrapping some function declarations.  Remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/net/netfilter/nf_conntrack_acct.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_acct.h b/include/net/netfilter/nf_conntrack_acct.h
index 5b5287bb49db..f7a060c6eb28 100644
--- a/include/net/netfilter/nf_conntrack_acct.h
+++ b/include/net/netfilter/nf_conntrack_acct.h
@@ -65,11 +65,9 @@ static inline void nf_ct_set_acct(struct net *net, bool enable)
 #endif
 }
 
-#if IS_ENABLED(CONFIG_NF_CONNTRACK)
 void nf_conntrack_acct_pernet_init(struct net *net);
 
 int nf_conntrack_acct_init(void);
 void nf_conntrack_acct_fini(void);
-#endif /* IS_ENABLED(CONFIG_NF_CONNTRACK) */
 
 #endif /* _NF_CONNTRACK_ACCT_H */
-- 
2.11.0

