Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1FD47338E
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 Dec 2021 19:08:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbhLMSIJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 Dec 2021 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238767AbhLMSIJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 Dec 2021 13:08:09 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE665C061574
        for <netfilter-devel@vger.kernel.org>; Mon, 13 Dec 2021 10:08:08 -0800 (PST)
Received: from localhost ([::1]:58958 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mwpk7-0004I8-3I; Mon, 13 Dec 2021 19:08:07 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 1/6] xshared: Share print_match_save() between legacy ip*tables
Date:   Mon, 13 Dec 2021 19:07:42 +0100
Message-Id: <20211213180747.20707-2-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211213180747.20707-1-phil@nwl.cc>
References: <20211213180747.20707-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The only difference between the former two copies was the type of
ip*_entry parameter. But since it is treated opaque, just hide that
detail by casting to void.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/ip6tables.c | 31 -------------------------------
 iptables/iptables.c  | 31 -------------------------------
 iptables/xshared.c   | 30 ++++++++++++++++++++++++++++++
 iptables/xshared.h   |  2 ++
 4 files changed, 32 insertions(+), 62 deletions(-)

diff --git a/iptables/ip6tables.c b/iptables/ip6tables.c
index 5a64566eecd2a..0509c36c839b7 100644
--- a/iptables/ip6tables.c
+++ b/iptables/ip6tables.c
@@ -644,37 +644,6 @@ list_entries(const xt_chainlabel chain, int rulenum, int verbose, int numeric,
 	return found;
 }
 
-static int print_match_save(const struct xt_entry_match *e,
-			const struct ip6t_ip6 *ip)
-{
-	const char *name = e->u.user.name;
-	const int revision = e->u.user.revision;
-	struct xtables_match *match, *mt, *mt2;
-
-	match = xtables_find_match(name, XTF_TRY_LOAD, NULL);
-	if (match) {
-		mt = mt2 = xtables_find_match_revision(name, XTF_TRY_LOAD,
-						       match, revision);
-		if (!mt2)
-			mt2 = match;
-		printf(" -m %s", mt2->alias ? mt2->alias(e) : name);
-
-		/* some matches don't provide a save function */
-		if (mt && mt->save)
-			mt->save(ip, e);
-		else if (match->save)
-			printf(unsupported_rev);
-	} else {
-		if (e->u.match_size) {
-			fprintf(stderr,
-				"Can't find library for match `%s'\n",
-				name);
-			exit(1);
-		}
-	}
-	return 0;
-}
-
 /* We want this to be readable, so only print out necessary fields.
  * Because that's the kind of world I want to live in.
  */
diff --git a/iptables/iptables.c b/iptables/iptables.c
index ac51c612d92f2..a69d42387f062 100644
--- a/iptables/iptables.c
+++ b/iptables/iptables.c
@@ -642,37 +642,6 @@ list_entries(const xt_chainlabel chain, int rulenum, int verbose, int numeric,
 
 #define IP_PARTS(n) IP_PARTS_NATIVE(ntohl(n))
 
-static int print_match_save(const struct xt_entry_match *e,
-			const struct ipt_ip *ip)
-{
-	const char *name = e->u.user.name;
-	const int revision = e->u.user.revision;
-	struct xtables_match *match, *mt, *mt2;
-
-	match = xtables_find_match(name, XTF_TRY_LOAD, NULL);
-	if (match) {
-		mt = mt2 = xtables_find_match_revision(name, XTF_TRY_LOAD,
-						       match, revision);
-		if (!mt2)
-			mt2 = match;
-		printf(" -m %s", mt2->alias ? mt2->alias(e) : name);
-
-		/* some matches don't provide a save function */
-		if (mt && mt->save)
-			mt->save(ip, e);
-		else if (match->save)
-			printf(unsupported_rev);
-	} else {
-		if (e->u.match_size) {
-			fprintf(stderr,
-				"Can't find library for match `%s'\n",
-				name);
-			exit(1);
-		}
-	}
-	return 0;
-}
-
 /* We want this to be readable, so only print out necessary fields.
  * Because that's the kind of world I want to live in.
  */
diff --git a/iptables/xshared.c b/iptables/xshared.c
index a1ca2b0fd7e3e..94a2d08815d92 100644
--- a/iptables/xshared.c
+++ b/iptables/xshared.c
@@ -1119,3 +1119,33 @@ void save_rule_details(const char *iniface, unsigned const char *iniface_mask,
 		printf(" -f");
 	}
 }
+
+int print_match_save(const struct xt_entry_match *e, const void *ip)
+{
+	const char *name = e->u.user.name;
+	const int revision = e->u.user.revision;
+	struct xtables_match *match, *mt, *mt2;
+
+	match = xtables_find_match(name, XTF_TRY_LOAD, NULL);
+	if (match) {
+		mt = mt2 = xtables_find_match_revision(name, XTF_TRY_LOAD,
+						       match, revision);
+		if (!mt2)
+			mt2 = match;
+		printf(" -m %s", mt2->alias ? mt2->alias(e) : name);
+
+		/* some matches don't provide a save function */
+		if (mt && mt->save)
+			mt->save(ip, e);
+		else if (match->save)
+			printf(" [unsupported revision]");
+	} else {
+		if (e->u.match_size) {
+			fprintf(stderr,
+				"Can't find library for match `%s'\n",
+				name);
+			exit(1);
+		}
+	}
+	return 0;
+}
diff --git a/iptables/xshared.h b/iptables/xshared.h
index 060c62ef0b5ca..1ee64d9e4010d 100644
--- a/iptables/xshared.h
+++ b/iptables/xshared.h
@@ -257,4 +257,6 @@ void save_rule_details(const char *iniface, unsigned const char *iniface_mask,
 		       const char *outiface, unsigned const char *outiface_mask,
 		       uint16_t proto, int frag, uint8_t invflags);
 
+int print_match_save(const struct xt_entry_match *e, const void *ip);
+
 #endif /* IPTABLES_XSHARED_H */
-- 
2.33.0

