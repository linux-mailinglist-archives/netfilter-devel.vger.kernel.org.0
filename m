Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E31F0D90
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2020 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgFGSEv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Jun 2020 14:04:51 -0400
Received: from correo.us.es ([193.147.175.20]:39170 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgFGSEv (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:04:51 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3F95511D162
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:50 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 32549DA73F
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:50 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 27CEBDA72F; Sun,  7 Jun 2020 20:04:50 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0DA09DA73F
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:48 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 07 Jun 2020 20:04:48 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id E255A41E4800
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:47 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] segtree: fix asan runtime error
Date:   Sun,  7 Jun 2020 20:04:43 +0200
Message-Id: <20200607180444.17736-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ASAN reports:

 segtree.c:387:30: runtime error: variable length array bound evaluates to non-positive value 0

Update array definition to be the set size plus 1.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/segtree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/segtree.c b/src/segtree.c
index 266a2b4dc98b..b6ca6083ea0b 100644
--- a/src/segtree.c
+++ b/src/segtree.c
@@ -383,8 +383,8 @@ static bool interval_overlap(const struct elementary_interval *e1,
 static int set_overlap(struct list_head *msgs, const struct set *set,
 		       struct expr *init, unsigned int keylen, bool add)
 {
-	struct elementary_interval *new_intervals[init->size];
-	struct elementary_interval *intervals[set->init->size];
+	struct elementary_interval *new_intervals[init->size + 1];
+	struct elementary_interval *intervals[set->init->size + 1];
 	unsigned int n, m, i, j;
 	int ret = 0;
 
-- 
2.20.1

