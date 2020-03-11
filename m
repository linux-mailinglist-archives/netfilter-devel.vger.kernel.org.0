Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94C2D181B34
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2020 15:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729511AbgCKOa0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Mar 2020 10:30:26 -0400
Received: from correo.us.es ([193.147.175.20]:41074 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729309AbgCKOa0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:30:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 94BF7C04A3
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:30:02 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 867AADA72F
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:30:02 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7C42BDA788; Wed, 11 Mar 2020 15:30:02 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C31C7DA390
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:30:00 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Wed, 11 Mar 2020 15:30:00 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id A7C6B42EF42B
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Mar 2020 15:30:00 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH 5/5] netfilter: nft_lookup: update element stateful expression
Date:   Wed, 11 Mar 2020 15:30:16 +0100
Message-Id: <20200311143016.4414-6-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200311143016.4414-1-pablo@netfilter.org>
References: <20200311143016.4414-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the set element comes with an stateful expression, update it.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nft_lookup.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nft_lookup.c b/net/netfilter/nft_lookup.c
index 660bad688e2b..1e70359d633c 100644
--- a/net/netfilter/nft_lookup.c
+++ b/net/netfilter/nft_lookup.c
@@ -43,6 +43,7 @@ void nft_lookup_eval(const struct nft_expr *expr,
 		nft_data_copy(&regs->data[priv->dreg],
 			      nft_set_ext_data(ext), set->dlen);
 
+	nft_set_elem_update_expr(ext, regs, pkt);
 }
 
 static const struct nla_policy nft_lookup_policy[NFTA_LOOKUP_MAX + 1] = {
-- 
2.11.0

