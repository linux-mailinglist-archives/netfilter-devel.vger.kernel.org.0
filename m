Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77EE5229734
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Jul 2020 13:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGVLM0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 22 Jul 2020 07:12:26 -0400
Received: from correo.us.es ([193.147.175.20]:53176 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726028AbgGVLMZ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 22 Jul 2020 07:12:25 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id D7696E8622
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 13:12:22 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C714EDA801
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 13:12:22 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id BBFC7DA7B6; Wed, 22 Jul 2020 13:12:22 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 7FAF9DA789
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 13:12:20 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 22 Jul 2020 13:12:20 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 61E014265A32
        for <netfilter-devel@vger.kernel.org>; Wed, 22 Jul 2020 13:12:20 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH iptables] extensions: libxt_conntrack: provide translation for DNAT and SNAT --ctstate
Date:   Wed, 22 Jul 2020 13:12:14 +0200
Message-Id: <20200722111214.21896-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

iptables-translate -t filter -A INPUT -m conntrack --ctstate DNAT -j ACCEPT
nft add rule ip filter INPUT ct status dnat counter accept

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 extensions/libxt_conntrack.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/extensions/libxt_conntrack.c b/extensions/libxt_conntrack.c
index 6f3503933e66..7734509c9af8 100644
--- a/extensions/libxt_conntrack.c
+++ b/extensions/libxt_conntrack.c
@@ -1249,11 +1249,19 @@ static int _conntrack3_mt_xlate(struct xt_xlate *xl,
 	}
 
 	if (sinfo->match_flags & XT_CONNTRACK_STATE) {
-		xt_xlate_add(xl, "%sct state %s", space,
-			     sinfo->invert_flags & XT_CONNTRACK_STATE ?
-			     "!= " : "");
-		state_xlate_print(xl, sinfo->state_mask);
-		space = " ";
+		if ((sinfo->state_mask & XT_CONNTRACK_STATE_SNAT) ||
+		    (sinfo->state_mask & XT_CONNTRACK_STATE_DNAT)) {
+			xt_xlate_add(xl, "%sct status %s%s", space,
+				     sinfo->invert_flags & XT_CONNTRACK_STATUS ? "!=" : "",
+				     sinfo->state_mask & XT_CONNTRACK_STATE_SNAT ? "snat" : "dnat");
+			space = " ";
+		} else {
+			xt_xlate_add(xl, "%sct state %s", space,
+				     sinfo->invert_flags & XT_CONNTRACK_STATE ?
+				     "!= " : "");
+			state_xlate_print(xl, sinfo->state_mask);
+			space = " ";
+		}
 	}
 
 	if (sinfo->match_flags & XT_CONNTRACK_STATUS) {
-- 
2.20.1

