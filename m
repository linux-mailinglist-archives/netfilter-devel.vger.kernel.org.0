Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7441635F7
	for <lists+netfilter-devel@lfdr.de>; Tue, 18 Feb 2020 23:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726851AbgBRWVT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 18 Feb 2020 17:21:19 -0500
Received: from correo.us.es ([193.147.175.20]:57518 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726768AbgBRWVM (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 18 Feb 2020 17:21:12 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id DA394303D0A
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 23:21:10 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C8C8EDA3A5
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Feb 2020 23:21:10 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BCFB1DA3A3; Tue, 18 Feb 2020 23:21:10 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E0D62DA72F;
        Tue, 18 Feb 2020 23:21:08 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 18 Feb 2020 23:21:08 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B0FF942EE38E;
        Tue, 18 Feb 2020 23:21:08 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 8/9] netfilter: nft_set_pipapo: Fix mapping table example in comments
Date:   Tue, 18 Feb 2020 23:21:00 +0100
Message-Id: <20200218222101.635808-9-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200218222101.635808-1-pablo@netfilter.org>
References: <20200218222101.635808-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Stefano Brivio <sbrivio@redhat.com>

In both insertion and lookup examples, the two element pointers
of rule mapping tables were swapped. Fix that.

Reported-by: Pablo Neira Ayuso <pablo@netfilter.org>
Fixes: 3c4287f62044 ("nf_tables: Add set type for arbitrary concatenation of ranges")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_set_pipapo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_set_pipapo.c b/net/netfilter/nft_set_pipapo.c
index f0cb1e13af50..579600b39f39 100644
--- a/net/netfilter/nft_set_pipapo.c
+++ b/net/netfilter/nft_set_pipapo.c
@@ -203,7 +203,7 @@
  * ::
  *
  *       rule indices in last field:    0    1
- *       map to elements:             0x42  0x66
+ *       map to elements:             0x66  0x42
  *
  *
  * Matching
@@ -298,7 +298,7 @@
  * ::
  *
  *       rule indices in last field:    0    1
- *       map to elements:             0x42  0x66
+ *       map to elements:             0x66  0x42
  *
  *      the matching element is at 0x42.
  *
-- 
2.11.0

