Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3C1BB90DF
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2019 15:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbfITNoc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Sep 2019 09:44:32 -0400
Received: from correo.us.es ([193.147.175.20]:44894 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726924AbfITNob (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Sep 2019 09:44:31 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7DAA8508CC7
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:27 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6F785DA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:27 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 65195D190C; Fri, 20 Sep 2019 15:44:27 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 50623DA72F
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:25 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 20 Sep 2019 15:44:25 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [5.182.56.138])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 07E374265A5A
        for <netfilter-devel@vger.kernel.org>; Fri, 20 Sep 2019 15:44:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack-tools 1/2] conntrackd: Fix "Address Accept" filter case
Date:   Fri, 20 Sep 2019 15:44:20 +0200
Message-Id: <20190920134421.11628-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Robin Geuze <robing@transip.nl>

This fixes a bug in the Address Accept filter case where if you only
specify either addresses or masks it would never match, eg.

Filter From Usespace {
    Address Accept {
        IPv4_address 127.0.0.1
    }
}

or

Filter From Usespace {
    Address Accept {
        IPv4_address 0.0.0.0/0
    }
}

Signed-off-by: Robin Geuze <robing@transip.nl>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/filter.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/src/filter.c b/src/filter.c
index 00a5e96ecc24..3c5ab6fc66f1 100644
--- a/src/filter.c
+++ b/src/filter.c
@@ -335,16 +335,24 @@ ct_filter_check(struct ct_filter *f, const struct nf_conntrack *ct)
 		switch(nfct_get_attr_u8(ct, ATTR_L3PROTO)) {
 		case AF_INET:
 			ret = vector_iterate(f->v, ct, __ct_filter_test_mask4);
-			if (ret ^ f->logic[CT_FILTER_ADDRESS])
-				return 0;
+			if (ret) {
+				if (f->logic[CT_FILTER_ADDRESS])
+					break;
+				else if (!f->logic[CT_FILTER_ADDRESS])
+					return 0;
+			}
 			ret = __ct_filter_test_ipv4(f, ct);
 			if (ret ^ f->logic[CT_FILTER_ADDRESS])
 				return 0;
 			break;
 		case AF_INET6:
 			ret = vector_iterate(f->v6, ct, __ct_filter_test_mask6);
-			if (ret ^ f->logic[CT_FILTER_ADDRESS])
-				return 0;
+			if (ret) {
+				if (f->logic[CT_FILTER_ADDRESS])
+					break;
+				else if (!f->logic[CT_FILTER_ADDRESS])
+					return 0;
+			}
 			ret = __ct_filter_test_ipv6(f, ct);
 			if (ret ^ f->logic[CT_FILTER_ADDRESS])
 				return 0;
-- 
2.11.0

