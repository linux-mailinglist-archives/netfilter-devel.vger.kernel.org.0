Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7191FE74C
	for <lists+netfilter-devel@lfdr.de>; Fri, 15 Nov 2019 22:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbfKOVy3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 16:54:29 -0500
Received: from correo.us.es ([193.147.175.20]:33742 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbfKOVy3 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 16:54:29 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 7A8EEEBAC4
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 22:54:25 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6CC0BDA4CA
        for <netfilter-devel@vger.kernel.org>; Fri, 15 Nov 2019 22:54:25 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 62837DA840; Fri, 15 Nov 2019 22:54:25 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6234DDA4CA;
        Fri, 15 Nov 2019 22:54:23 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Fri, 15 Nov 2019 22:54:23 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 3F25C4251481;
        Fri, 15 Nov 2019 22:54:23 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     eric@garver.life
Subject: [PATCH libnftnl] flowtable: remove NFTA_FLOWTABLE_SIZE
Date:   Fri, 15 Nov 2019 22:54:21 +0100
Message-Id: <20191115215421.5023-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Never defined in upstream Linux kernel uAPI, remove it.

Reported-by: Eric Garver <eric@garver.life>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/linux/netfilter/nf_tables.h | 2 --
 src/flowtable.c                     | 6 ------
 2 files changed, 8 deletions(-)

diff --git a/include/linux/netfilter/nf_tables.h b/include/linux/netfilter/nf_tables.h
index 81c27d3c9ffd..bb9b049310df 100644
--- a/include/linux/netfilter/nf_tables.h
+++ b/include/linux/netfilter/nf_tables.h
@@ -1518,7 +1518,6 @@ enum nft_object_attributes {
  * @NFTA_FLOWTABLE_HOOK: netfilter hook configuration(NLA_U32)
  * @NFTA_FLOWTABLE_USE: number of references to this flow table (NLA_U32)
  * @NFTA_FLOWTABLE_HANDLE: object handle (NLA_U64)
- * @NFTA_FLOWTABLE_SIZE: maximum size (NLA_U32)
  * @NFTA_FLOWTABLE_FLAGS: flags (NLA_U32)
  */
 enum nft_flowtable_attributes {
@@ -1529,7 +1528,6 @@ enum nft_flowtable_attributes {
 	NFTA_FLOWTABLE_USE,
 	NFTA_FLOWTABLE_HANDLE,
 	NFTA_FLOWTABLE_PAD,
-	NFTA_FLOWTABLE_SIZE,
 	NFTA_FLOWTABLE_FLAGS,
 	__NFTA_FLOWTABLE_MAX
 };
diff --git a/src/flowtable.c b/src/flowtable.c
index ec89b952e47d..324e80f7e6ad 100644
--- a/src/flowtable.c
+++ b/src/flowtable.c
@@ -324,8 +324,6 @@ void nftnl_flowtable_nlmsg_build_payload(struct nlmsghdr *nlh,
 		mnl_attr_put_u32(nlh, NFTA_FLOWTABLE_FLAGS, htonl(c->ft_flags));
 	if (c->flags & (1 << NFTNL_FLOWTABLE_USE))
 		mnl_attr_put_u32(nlh, NFTA_FLOWTABLE_USE, htonl(c->use));
-	if (c->flags & (1 << NFTNL_FLOWTABLE_SIZE))
-		mnl_attr_put_u32(nlh, NFTA_FLOWTABLE_SIZE, htonl(c->size));
 	if (c->flags & (1 << NFTNL_FLOWTABLE_HANDLE))
 		mnl_attr_put_u64(nlh, NFTA_FLOWTABLE_HANDLE, htobe64(c->handle));
 }
@@ -489,10 +487,6 @@ int nftnl_flowtable_nlmsg_parse(const struct nlmsghdr *nlh, struct nftnl_flowtab
 		c->use = ntohl(mnl_attr_get_u32(tb[NFTA_FLOWTABLE_USE]));
 		c->flags |= (1 << NFTNL_FLOWTABLE_USE);
 	}
-	if (tb[NFTA_FLOWTABLE_SIZE]) {
-		c->size = ntohl(mnl_attr_get_u32(tb[NFTA_FLOWTABLE_SIZE]));
-		c->flags |= (1 << NFTNL_FLOWTABLE_SIZE);
-	}
 	if (tb[NFTA_FLOWTABLE_HANDLE]) {
 		c->handle = be64toh(mnl_attr_get_u64(tb[NFTA_FLOWTABLE_HANDLE]));
 		c->flags |= (1 << NFTNL_FLOWTABLE_HANDLE);
-- 
2.11.0

