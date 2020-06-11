Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930E21F63EE
	for <lists+netfilter-devel@lfdr.de>; Thu, 11 Jun 2020 10:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgFKIqy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 11 Jun 2020 04:46:54 -0400
Received: from correo.us.es ([193.147.175.20]:53024 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726756AbgFKIqx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 11 Jun 2020 04:46:53 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 9504DDA705
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Jun 2020 10:46:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 855B1DA73F
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Jun 2020 10:46:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 7A987DA78C; Thu, 11 Jun 2020 10:46:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 33B6CDA73F
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Jun 2020 10:46:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 11 Jun 2020 10:46:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 2115F41E4800
        for <netfilter-devel@vger.kernel.org>; Thu, 11 Jun 2020 10:46:49 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nf] netfilter: ctnetlink: memleak in filter initialization error path
Date:   Thu, 11 Jun 2020 10:46:45 +0200
Message-Id: <20200611084646.9253-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Release the filter object in case of error.

Fixes: cb8aa9a3affb ("netfilter: ctnetlink: add kernel side filtering for dump")
Reported-by: syzbot+38b8b548a851a01793c5@syzkaller.appspotmail.com
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_conntrack_netlink.c | 32 +++++++++++++++++++---------
 1 file changed, 22 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index d7bd8b1f27d5..832eabecfbdd 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -939,7 +939,8 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 			filter->mark.mask = 0xffffffff;
 		}
 	} else if (cda[CTA_MARK_MASK]) {
-		return ERR_PTR(-EINVAL);
+		err = -EINVAL;
+		goto err_filter;
 	}
 #endif
 	if (!cda[CTA_FILTER])
@@ -947,15 +948,17 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 
 	err = ctnetlink_parse_zone(cda[CTA_ZONE], &filter->zone);
 	if (err < 0)
-		return ERR_PTR(err);
+		goto err_filter;
 
 	err = ctnetlink_parse_filter(cda[CTA_FILTER], filter);
 	if (err < 0)
-		return ERR_PTR(err);
+		goto err_filter;
 
 	if (filter->orig_flags) {
-		if (!cda[CTA_TUPLE_ORIG])
-			return ERR_PTR(-EINVAL);
+		if (!cda[CTA_TUPLE_ORIG]) {
+			err = -EINVAL;
+			goto err_filter;
+		}
 
 		err = ctnetlink_parse_tuple_filter(cda, &filter->orig,
 						   CTA_TUPLE_ORIG,
@@ -963,23 +966,32 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 						   &filter->zone,
 						   filter->orig_flags);
 		if (err < 0)
-			return ERR_PTR(err);
+			goto err_filter;
 	}
 
 	if (filter->reply_flags) {
-		if (!cda[CTA_TUPLE_REPLY])
-			return ERR_PTR(-EINVAL);
+		if (!cda[CTA_TUPLE_REPLY]) {
+			err = -EINVAL;
+			goto err_filter;
+		}
 
 		err = ctnetlink_parse_tuple_filter(cda, &filter->reply,
 						   CTA_TUPLE_REPLY,
 						   filter->family,
 						   &filter->zone,
 						   filter->orig_flags);
-		if (err < 0)
-			return ERR_PTR(err);
+		if (err < 0) {
+			err = -EINVAL;
+			goto err_filter;
+		}
 	}
 
 	return filter;
+
+err_filter:
+	kfree(filter);
+
+	return ERR_PTR(err);
 }
 
 static bool ctnetlink_needs_filter(u8 family, const struct nlattr * const *cda)
-- 
2.20.1

