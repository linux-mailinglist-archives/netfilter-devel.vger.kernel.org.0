Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E71F020488B
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 06:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgFWENO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 00:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728290AbgFWENO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 00:13:14 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50166C061573
        for <netfilter-devel@vger.kernel.org>; Mon, 22 Jun 2020 21:13:13 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 05:35:03 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [libnf_ct PATCH 3/8] Replace strncpy with snprintf to improve null byte handling
Date:   Tue, 23 Jun 2020 05:34:38 +0200
Message-Id: <20200623033443.18184-4-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623033443.18184-1-dxld@darkboxed.org>
References: <20200623033443.18184-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-report: Spam detection software, running on the system "Janet.clients.dxld.at",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 @@CONTACT_ADDRESS@@ for details.
 Content preview:  We currently use strncpy in a bunch of places which has this
    weird quirk where it doesn't write a terminating null byte if the input string
    is >= the max length. To mitigate this we write a null byte [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

We currently use strncpy in a bunch of places which has this weird quirk
where it doesn't write a terminating null byte if the input string is >=
the max length. To mitigate this we write a null byte to the last character
manually.

While this works it is easy to forget. Instead we should just be using
snprintf which has more sensible behaviour as it always writes a null byte
even when truncating the string.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 src/conntrack/copy.c      |  4 ++--
 src/conntrack/parse_mnl.c |  5 ++---
 src/conntrack/setter.c    |  3 +--
 src/expect/parse_mnl.c    | 16 ++++++++--------
 src/expect/setter.c       |  6 ++----
 5 files changed, 15 insertions(+), 19 deletions(-)

diff --git a/src/conntrack/copy.c b/src/conntrack/copy.c
index eca202e..5a53df5 100644
--- a/src/conntrack/copy.c
+++ b/src/conntrack/copy.c
@@ -427,8 +427,8 @@ static void copy_attr_repl_off_aft(struct nf_conntrack *dest,
 static void copy_attr_helper_name(struct nf_conntrack *dest,
 				  const struct nf_conntrack *orig)
 {
-	strncpy(dest->helper_name, orig->helper_name, NFCT_HELPER_NAME_MAX);
-	dest->helper_name[NFCT_HELPER_NAME_MAX-1] = '\0';
+	snprintf(dest->helper_name, NFCT_HELPER_NAME_MAX, "%s",
+                 orig->helper_name);
 }
 
 static void copy_attr_zone(struct nf_conntrack *dest,
diff --git a/src/conntrack/parse_mnl.c b/src/conntrack/parse_mnl.c
index 515deff..3cbfc6a 100644
--- a/src/conntrack/parse_mnl.c
+++ b/src/conntrack/parse_mnl.c
@@ -690,9 +690,8 @@ nfct_parse_helper(const struct nlattr *attr, struct nf_conntrack *ct)
 	if (!tb[CTA_HELP_NAME])
 		return 0;
 
-	strncpy(ct->helper_name, mnl_attr_get_str(tb[CTA_HELP_NAME]),
-		NFCT_HELPER_NAME_MAX);
-	ct->helper_name[NFCT_HELPER_NAME_MAX-1] = '\0';
+	snprintf(ct->helper_name, NFCT_HELPER_NAME_MAX, "%s",
+		 mnl_attr_get_str(tb[CTA_HELP_NAME]));
 	set_bit(ATTR_HELPER_NAME, ct->head.set);
 
 	if (!tb[CTA_HELP_INFO])
diff --git a/src/conntrack/setter.c b/src/conntrack/setter.c
index 7b96936..0157de4 100644
--- a/src/conntrack/setter.c
+++ b/src/conntrack/setter.c
@@ -389,8 +389,7 @@ set_attr_repl_off_aft(struct nf_conntrack *ct, const void *value, size_t len)
 static void
 set_attr_helper_name(struct nf_conntrack *ct, const void *value, size_t len)
 {
-	strncpy(ct->helper_name, value, NFCT_HELPER_NAME_MAX);
-	ct->helper_name[NFCT_HELPER_NAME_MAX-1] = '\0';
+	snprintf(ct->helper_name, NFCT_HELPER_NAME_MAX, "%s", (char*)value);
 }
 
 static void
diff --git a/src/expect/parse_mnl.c b/src/expect/parse_mnl.c
index 091a8ae..1c94cad 100644
--- a/src/expect/parse_mnl.c
+++ b/src/expect/parse_mnl.c
@@ -10,6 +10,7 @@
  */
 
 #include "internal/internal.h"
+#include <assert.h>
 #include <libmnl/libmnl.h>
 
 static int nlmsg_parse_expection_attr_cb(const struct nlattr *attr, void *data)
@@ -139,11 +140,9 @@ int nfexp_nlmsg_parse(const struct nlmsghdr *nlh, struct nf_expect *exp)
 		set_bit(ATTR_EXP_FLAGS, exp->set);
 	}
 	if (tb[CTA_EXPECT_HELP_NAME]) {
-		strncpy(exp->helper_name,
-			mnl_attr_get_str(tb[CTA_EXPECT_HELP_NAME]),
-			NFCT_HELPER_NAME_MAX);
-		exp->helper_name[NFCT_HELPER_NAME_MAX - 1] = '\0';
-		set_bit(ATTR_EXP_HELPER_NAME, exp->set);
+		snprintf(exp->helper_name, NFCT_HELPER_NAME_MAX, "%s",
+			 mnl_attr_get_str(tb[CTA_EXPECT_HELP_NAME]));
+ 		set_bit(ATTR_EXP_HELPER_NAME, exp->set);
 	}
 	if (tb[CTA_EXPECT_CLASS]) {
 		exp->class = ntohl(mnl_attr_get_u32(tb[CTA_EXPECT_CLASS]));
@@ -153,9 +152,10 @@ int nfexp_nlmsg_parse(const struct nlmsghdr *nlh, struct nf_expect *exp)
 		nfexp_nlmsg_parse_nat(nfg, tb[CTA_EXPECT_NAT], exp);
 
 	if (tb[CTA_EXPECT_FN]) {
-		strncpy(exp->expectfn, mnl_attr_get_payload(tb[CTA_EXPECT_FN]),
-			__NFCT_EXPECTFN_MAX);
-		exp->expectfn[__NFCT_EXPECTFN_MAX - 1] = '\0';
+		int len = mnl_attr_get_payload_len(tb[CTA_EXPECT_FN]);
+		assert(len <= __NFCT_EXPECTFN_MAX); /* the kernel doesn't impose a max lenght on this str */
+		snprintf(exp->expectfn, __NFCT_EXPECTFN_MAX, "%s",
+			 (char*)mnl_attr_get_payload(tb[CTA_EXPECT_FN]));
 		set_bit(ATTR_EXP_FN, exp->set);
 	}
 
diff --git a/src/expect/setter.c b/src/expect/setter.c
index 18c925a..0a950c2 100644
--- a/src/expect/setter.c
+++ b/src/expect/setter.c
@@ -46,8 +46,7 @@ static void set_exp_attr_class(struct nf_expect *exp, const void *value)
 
 static void set_exp_attr_helper_name(struct nf_expect *exp, const void *value)
 {
-	strncpy(exp->helper_name, value, NFCT_HELPER_NAME_MAX);
-	exp->helper_name[NFCT_HELPER_NAME_MAX-1] = '\0';
+	snprintf(exp->helper_name, NFCT_HELPER_NAME_MAX, "%s", (char*)value);
 }
 
 static void set_exp_attr_nat_dir(struct nf_expect *exp, const void *value)
@@ -62,8 +61,7 @@ static void set_exp_attr_nat_tuple(struct nf_expect *exp, const void *value)
 
 static void set_exp_attr_expectfn(struct nf_expect *exp, const void *value)
 {
-	strncpy(exp->expectfn, value, __NFCT_EXPECTFN_MAX);
-	exp->expectfn[__NFCT_EXPECTFN_MAX-1] = '\0';
+	snprintf(exp->expectfn, __NFCT_EXPECTFN_MAX, "%s", (char*)value);
 }
 
 const set_exp_attr set_exp_attr_array[ATTR_EXP_MAX] = {
-- 
2.20.1

