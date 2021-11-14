Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD244F7BB
	for <lists+netfilter-devel@lfdr.de>; Sun, 14 Nov 2021 12:58:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhKNMBZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 14 Nov 2021 07:01:25 -0500
Received: from mail.netfilter.org ([217.70.188.207]:60828 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbhKNMBT (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 14 Nov 2021 07:01:19 -0500
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 601D66009B
        for <netfilter-devel@vger.kernel.org>; Sun, 14 Nov 2021 12:56:21 +0100 (CET)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack,v2] conntrack: add nfct_nlmsg_build_filter() helper
Date:   Sun, 14 Nov 2021 12:58:20 +0100
Message-Id: <20211114115820.608279-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This helper function builds the payload of the netlink dump request
including the filtering criteria.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: incorrect call to nfct_nlmsg_build_filter_dump() in src/conntrack/filter_dump.c

 .../libnetfilter_conntrack.h                  |  1 +
 src/conntrack/build_mnl.c                     | 22 +++++++++++++++++++
 src/conntrack/filter_dump.c                   | 18 ++-------------
 3 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/include/libnetfilter_conntrack/libnetfilter_conntrack.h b/include/libnetfilter_conntrack/libnetfilter_conntrack.h
index 6233434cfeb8..e2294723cd51 100644
--- a/include/libnetfilter_conntrack/libnetfilter_conntrack.h
+++ b/include/libnetfilter_conntrack/libnetfilter_conntrack.h
@@ -587,6 +587,7 @@ int nfct_build_query(struct nfnl_subsys_handle *ssh,
 /* New low level API: netlink functions */
 
 extern int nfct_nlmsg_build(struct nlmsghdr *nlh, const struct nf_conntrack *ct);
+extern int nfct_nlmsg_build_filter(struct nlmsghdr *nlh, const struct nfct_filter_dump *filter_dump);
 extern int nfct_nlmsg_parse(const struct nlmsghdr *nlh, struct nf_conntrack *ct);
 extern int nfct_payload_parse(const void *payload, size_t payload_len, uint16_t l3num, struct nf_conntrack *ct);
 
diff --git a/src/conntrack/build_mnl.c b/src/conntrack/build_mnl.c
index 0067a1c2315b..c3198c57cdcd 100644
--- a/src/conntrack/build_mnl.c
+++ b/src/conntrack/build_mnl.c
@@ -595,3 +595,25 @@ nfct_nlmsg_build(struct nlmsghdr *nlh, const struct nf_conntrack *ct)
 
 	return 0;
 }
+
+int nfct_nlmsg_build_filter(struct nlmsghdr *nlh,
+			    const struct nfct_filter_dump *filter_dump)
+{
+	struct nfgenmsg *nfg;
+
+	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_MARK)) {
+		mnl_attr_put_u32(nlh, CTA_MARK, htonl(filter_dump->mark.val));
+		mnl_attr_put_u32(nlh, CTA_MARK_MASK, htonl(filter_dump->mark.mask));
+	}
+	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_L3NUM)) {
+		nfg = mnl_nlmsg_get_payload(nlh);
+		nfg->nfgen_family = filter_dump->l3num;
+	}
+	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_STATUS)) {
+		mnl_attr_put_u32(nlh, CTA_STATUS, htonl(filter_dump->status.val));
+		mnl_attr_put_u32(nlh, CTA_STATUS_MASK,
+				 htonl(filter_dump->status.mask));
+	}
+
+	return 0;
+}
diff --git a/src/conntrack/filter_dump.c b/src/conntrack/filter_dump.c
index 3894d0638a72..9bf92962441a 100644
--- a/src/conntrack/filter_dump.c
+++ b/src/conntrack/filter_dump.c
@@ -8,6 +8,7 @@
  */
 
 #include "internal/internal.h"
+#include <libmnl/libmnl.h>
 
 static void
 set_filter_dump_attr_mark(struct nfct_filter_dump *filter_dump,
@@ -45,20 +46,5 @@ const set_filter_dump_attr set_filter_dump_attr_array[NFCT_FILTER_DUMP_MAX] = {
 void __build_filter_dump(struct nfnlhdr *req, size_t size,
 			 const struct nfct_filter_dump *filter_dump)
 {
-	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_MARK)) {
-		nfnl_addattr32(&req->nlh, size, CTA_MARK,
-				htonl(filter_dump->mark.val));
-		nfnl_addattr32(&req->nlh, size, CTA_MARK_MASK,
-				htonl(filter_dump->mark.mask));
-	}
-	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_L3NUM)) {
-		struct nfgenmsg *nfg = NLMSG_DATA(&req->nlh);
-		nfg->nfgen_family = filter_dump->l3num;
-	}
-	if (filter_dump->set & (1 << NFCT_FILTER_DUMP_STATUS)) {
-		nfnl_addattr32(&req->nlh, size, CTA_STATUS,
-				htonl(filter_dump->status.val));
-		nfnl_addattr32(&req->nlh, size, CTA_STATUS_MASK,
-				htonl(filter_dump->status.mask));
-	}
+	nfct_nlmsg_build_filter(&req->nlh, filter_dump);
 }
-- 
2.30.2

