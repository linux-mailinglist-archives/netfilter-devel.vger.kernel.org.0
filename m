Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 685D61A104F
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Apr 2020 17:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729426AbgDGPhB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Apr 2020 11:37:01 -0400
Received: from correo.us.es ([193.147.175.20]:58358 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729432AbgDGPhB (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:37:01 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5B56DE8621
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Apr 2020 17:36:59 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 4C0C4100A47
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Apr 2020 17:36:59 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 41D5E100A45; Tue,  7 Apr 2020 17:36:59 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 62324100A5A
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Apr 2020 17:36:57 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 07 Apr 2020 17:36:57 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 4F1DB42EF42A
        for <netfilter-devel@vger.kernel.org>; Tue,  7 Apr 2020 17:36:57 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf 2/2] netfilter: nf_tables: reintroduce the NFT_SET_CONCAT flag
Date:   Tue,  7 Apr 2020 17:36:53 +0200
Message-Id: <20200407153653.137377-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200407153653.137377-1-pablo@netfilter.org>
References: <20200407153653.137377-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Stefano originally proposed to introduce this flag, users hit EOPNOTSUPP
in new binaries with old kernels when defining a set with ranges in
a concatenation.

Fixes: f3a2181e16f1 ("netfilter: nf_tables: Support for sets with multiple ranged fields")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/uapi/linux/netfilter/nf_tables.h | 2 ++
 net/netfilter/nf_tables_api.c            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/netfilter/nf_tables.h b/include/uapi/linux/netfilter/nf_tables.h
index 30f2a87270dc..4565456c0ef4 100644
--- a/include/uapi/linux/netfilter/nf_tables.h
+++ b/include/uapi/linux/netfilter/nf_tables.h
@@ -276,6 +276,7 @@ enum nft_rule_compat_attributes {
  * @NFT_SET_TIMEOUT: set uses timeouts
  * @NFT_SET_EVAL: set can be updated from the evaluation path
  * @NFT_SET_OBJECT: set contains stateful objects
+ * @NFT_SET_CONCAT: set contains a concatenation
  */
 enum nft_set_flags {
 	NFT_SET_ANONYMOUS		= 0x1,
@@ -285,6 +286,7 @@ enum nft_set_flags {
 	NFT_SET_TIMEOUT			= 0x10,
 	NFT_SET_EVAL			= 0x20,
 	NFT_SET_OBJECT			= 0x40,
+	NFT_SET_CONCAT			= 0x80,
 };
 
 /**
diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index 21cbde6ecee3..9adfbc7e8ae7 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -3962,7 +3962,7 @@ static int nf_tables_newset(struct net *net, struct sock *nlsk,
 		if (flags & ~(NFT_SET_ANONYMOUS | NFT_SET_CONSTANT |
 			      NFT_SET_INTERVAL | NFT_SET_TIMEOUT |
 			      NFT_SET_MAP | NFT_SET_EVAL |
-			      NFT_SET_OBJECT))
+			      NFT_SET_OBJECT | NFT_SET_CONCAT))
 			return -EOPNOTSUPP;
 		/* Only one of these operations is supported */
 		if ((flags & (NFT_SET_MAP | NFT_SET_OBJECT)) ==
-- 
2.11.0

