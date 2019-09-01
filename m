Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E6E3A4C08
	for <lists+netfilter-devel@lfdr.de>; Sun,  1 Sep 2019 22:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfIAUvb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 1 Sep 2019 16:51:31 -0400
Received: from kadath.azazel.net ([81.187.231.250]:53362 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729059AbfIAUva (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 1 Sep 2019 16:51:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=H12Ygv/ZWHIPzG5kSXpja+K4C0xnU27gilCQPRe/jTY=; b=RNcPT+ZUZU9Tz7LinAUUxCneAr
        z0z+xsR8e2sI0RI4ukC8/KjxSZkSxExIOdgVMO5Alk1t7EZ6zVvagXdQVJXd/4YuhDcDsyIvdfHom
        kg5P1jnZLHGcFYdBkrqai9y1CYlDqOLEtrmWbwYVsmCfApGNsxgF/UKk9AkjigfeqZb+JBqis6+fr
        jiPSOKagKheoaCjGbzLC9gb/0PMNuGBqyWh2Ga2X/M4NbJm2sbmT5vQvVbWJYdg5/xvyH813rhlHv
        fnnTBeZ1P6BCnYI8TnB1ROx/7eFb39ZF/Vtown3Ukq6Ztpz4LxtP1faiumaLUxzFoy00H1E6Za11b
        UOgNhe3Q==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4Wop-0002Uf-75; Sun, 01 Sep 2019 21:51:27 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next 07/29] netfilter: remove stray semicolons.
Date:   Sun,  1 Sep 2019 21:51:03 +0100
Message-Id: <20190901205126.6935-8-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190901205126.6935-1-jeremy@azazel.net>
References: <20190901205126.6935-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There are a couple of semicolons at the end of function definitions.
Remove them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_conntrack_acct.h   | 2 +-
 include/net/netfilter/nf_conntrack_ecache.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/net/netfilter/nf_conntrack_acct.h b/include/net/netfilter/nf_conntrack_acct.h
index ad9f2172dee1..5b5287bb49db 100644
--- a/include/net/netfilter/nf_conntrack_acct.h
+++ b/include/net/netfilter/nf_conntrack_acct.h
@@ -45,7 +45,7 @@ struct nf_conn_acct *nf_ct_acct_ext_add(struct nf_conn *ct, gfp_t gfp)
 #else
 	return NULL;
 #endif
-};
+}
 
 /* Check if connection tracking accounting is enabled */
 static inline bool nf_ct_acct_enabled(struct net *net)
diff --git a/include/net/netfilter/nf_conntrack_ecache.h b/include/net/netfilter/nf_conntrack_ecache.h
index 52b44192b43f..0815bfadfefe 100644
--- a/include/net/netfilter/nf_conntrack_ecache.h
+++ b/include/net/netfilter/nf_conntrack_ecache.h
@@ -61,7 +61,7 @@ nf_ct_ecache_ext_add(struct nf_conn *ct, u16 ctmask, u16 expmask, gfp_t gfp)
 #else
 	return NULL;
 #endif
-};
+}
 
 #ifdef CONFIG_NF_CONNTRACK_EVENTS
 /* This structure is passed to event handler */
-- 
2.23.0.rc1

