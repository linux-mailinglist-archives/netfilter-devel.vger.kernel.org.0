Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 78A662365E
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388974AbfETMpV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 08:45:21 -0400
Received: from mail.us.es ([193.147.175.20]:34202 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388327AbfETM04 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 08:26:56 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1E0DD1D94A1
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 14:26:55 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0D06CDA711
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 14:26:55 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 02CE0DA70F; Mon, 20 May 2019 14:26:55 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0DB35DA702;
        Mon, 20 May 2019 14:26:53 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 14:26:53 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id CE3D94265A32;
        Mon, 20 May 2019 14:26:52 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH iptables 2/6] nft: statify nft_rebuild_cache()
Date:   Mon, 20 May 2019 14:26:42 +0200
Message-Id: <20190520122646.17788-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520122646.17788-1-pablo@netfilter.org>
References: <20190520122646.17788-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 2 +-
 iptables/nft.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 167237ab45b1..6c6cd787c06f 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1540,7 +1540,7 @@ void nft_build_cache(struct nft_handle *h)
 		__nft_build_cache(h);
 }
 
-void nft_rebuild_cache(struct nft_handle *h)
+static void nft_rebuild_cache(struct nft_handle *h)
 {
 	if (!h->have_cache)
 		flush_chain_cache(h, NULL);
diff --git a/iptables/nft.h b/iptables/nft.h
index 8292a2922d6a..c137c5c6708d 100644
--- a/iptables/nft.h
+++ b/iptables/nft.h
@@ -70,7 +70,6 @@ int mnl_talk(struct nft_handle *h, struct nlmsghdr *nlh,
 int nft_init(struct nft_handle *h, const struct builtin_table *t);
 void nft_fini(struct nft_handle *h);
 void nft_build_cache(struct nft_handle *h);
-void nft_rebuild_cache(struct nft_handle *h);
 
 /*
  * Operations with tables.
-- 
2.11.0

