Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1085606F4
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Jun 2022 19:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbiF2REo (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 Jun 2022 13:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbiF2REn (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 Jun 2022 13:04:43 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9DEB424F2B
        for <netfilter-devel@vger.kernel.org>; Wed, 29 Jun 2022 10:04:42 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kfm@plushkava.net
Subject: [PATCH libmnl] nlmsg: Only print ECMA-48 colour sequences to terminals
Date:   Wed, 29 Jun 2022 19:04:38 +0200
Message-Id: <20220629170438.207871-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Kerin Millar <kfm@plushkava.net>

Check isatty() to skip colors for non-terminals.

Add mnl_fprintf_attr_color() and mnl_fprintf_attr_raw() helper function.

Joint work with Pablo.

Signed-off-by: Kerin Millar <kfm@plushkava.net>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/nlmsg.c | 76 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 53 insertions(+), 23 deletions(-)

diff --git a/src/nlmsg.c b/src/nlmsg.c
index ce37cbc63191..e7014bdc0b85 100644
--- a/src/nlmsg.c
+++ b/src/nlmsg.c
@@ -12,6 +12,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <string.h>
+#include <unistd.h>
 #include <libmnl/libmnl.h>
 #include "internal.h"
 
@@ -244,11 +245,57 @@ static void mnl_nlmsg_fprintf_header(FILE *fd, const struct nlmsghdr *nlh)
 	fprintf(fd, "----------------\t------------------\n");
 }
 
+static void mnl_fprintf_attr_color(FILE *fd, const struct nlattr *attr)
+{
+	fprintf(fd, "|%c[%d;%dm"
+		    "%.5u"
+		    "%c[%dm"
+		    "|"
+		    "%c[%d;%dm"
+		    "%c%c"
+		    "%c[%dm"
+		    "|"
+		    "%c[%d;%dm"
+		    "%.5u"
+		    "%c[%dm|\t",
+		    27, 1, 31,
+		    attr->nla_len,
+		    27, 0,
+		    27, 1, 32,
+		    attr->nla_type & NLA_F_NESTED ? 'N' : '-',
+		    attr->nla_type & NLA_F_NET_BYTEORDER ? 'B' : '-',
+		    27, 0,
+		    27, 1, 34,
+		    attr->nla_type & NLA_TYPE_MASK,
+		    27, 0);
+}
+
+static void mnl_fprintf_attr_raw(FILE *fd, const struct nlattr *attr)
+{
+	fprintf(fd, "|"
+		    "%.5u"
+		    "|"
+		    "%c%c"
+		    "|"
+		    "%.5u"
+		    "|\t",
+		    attr->nla_len,
+		    attr->nla_type & NLA_F_NESTED ? 'N' : '-',
+		    attr->nla_type & NLA_F_NET_BYTEORDER ? 'B' : '-',
+		    attr->nla_type & NLA_TYPE_MASK);
+}
+
 static void mnl_nlmsg_fprintf_payload(FILE *fd, const struct nlmsghdr *nlh,
 				      size_t extra_header_size)
 {
-	int rem = 0;
+	int colorize = 0;
 	unsigned int i;
+	int rem = 0;
+	int fdnum;
+
+	fdnum = fileno(fd);
+	if (fdnum != -1)
+		colorize = isatty(fdnum);
 
 	for (i=sizeof(struct nlmsghdr); i<nlh->nlmsg_len; i+=4) {
 		char *b = (char *) nlh;
@@ -269,28 +316,11 @@ static void mnl_nlmsg_fprintf_payload(FILE *fd, const struct nlmsghdr *nlh,
 			fprintf(fd, "|  extra header  |\n");
 		/* this seems like an attribute header. */
 		} else if (rem == 0 && (attr->nla_type & NLA_TYPE_MASK) != 0) {
-			fprintf(fd, "|%c[%d;%dm"
-				    "%.5u"
-				    "%c[%dm"
-				    "|"
-				    "%c[%d;%dm"
-				    "%c%c"
-				    "%c[%dm"
-				    "|"
-				    "%c[%d;%dm"
-				    "%.5u"
-				    "%c[%dm|\t",
-				27, 1, 31,
-				attr->nla_len,
-				27, 0,
-				27, 1, 32,
-				attr->nla_type & NLA_F_NESTED ? 'N' : '-',
-				attr->nla_type &
-					NLA_F_NET_BYTEORDER ? 'B' : '-',
-				27, 0,
-				27, 1, 34,
-				attr->nla_type & NLA_TYPE_MASK,
-				27, 0);
+			if (colorize) {
+				mnl_fprintf_attr_color(fd, attr);
+			} else {
+				mnl_fprintf_attr_raw(fd, attr);
+			}
 			fprintf(fd, "|len |flags| type|\n");
 
 			if (!(attr->nla_type & NLA_F_NESTED)) {
-- 
2.30.2

