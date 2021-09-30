Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0133641DBE4
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Sep 2021 16:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351742AbhI3OGn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Sep 2021 10:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351734AbhI3OGm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:06:42 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D2CC06176A
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Sep 2021 07:04:59 -0700 (PDT)
Received: from localhost ([::1]:51682 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mVwgE-0007PJ-40; Thu, 30 Sep 2021 16:04:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 11/17] xtables: Derive xtables_globals from family
Date:   Thu, 30 Sep 2021 16:04:13 +0200
Message-Id: <20210930140419.6170-12-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930140419.6170-1-phil@nwl.cc>
References: <20210930140419.6170-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Prepare xtables_main() for use with other families than IPV4 or IPV6
which both use the same xtables_globals object. Therefore introduce a
function to map from family value to xtables_globals object pointer.

In do_parse(), use xt_params pointer as well instead of direct
reference.

While being at it, Declare arptables_globals and ebtables_globals in
xtables_multi.h which seems to be the proper place for that.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-arp-standalone.c |  2 --
 iptables/xtables-eb-translate.c   |  1 -
 iptables/xtables-multi.h          |  3 +++
 iptables/xtables-standalone.c     | 23 +++++++++++++++++++----
 iptables/xtables.c                |  2 +-
 5 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/iptables/xtables-arp-standalone.c b/iptables/xtables-arp-standalone.c
index 04cf7dccc8206..82db3f3801c10 100644
--- a/iptables/xtables-arp-standalone.c
+++ b/iptables/xtables-arp-standalone.c
@@ -41,8 +41,6 @@
 
 #include "xtables-multi.h"
 
-extern struct xtables_globals arptables_globals;
-
 int xtables_arp_main(int argc, char *argv[])
 {
 	int ret;
diff --git a/iptables/xtables-eb-translate.c b/iptables/xtables-eb-translate.c
index 0539a829d3ff8..a6c86b6531e3f 100644
--- a/iptables/xtables-eb-translate.c
+++ b/iptables/xtables-eb-translate.c
@@ -87,7 +87,6 @@ static int parse_rule_number(const char *rule)
 /* Default command line options. Do not mess around with the already
  * assigned numbers unless you know what you are doing */
 extern struct option ebt_original_options[];
-extern struct xtables_globals ebtables_globals;
 #define opts ebtables_globals.opts
 #define prog_name ebtables_globals.program_name
 #define prog_vers ebtables_globals.program_version
diff --git a/iptables/xtables-multi.h b/iptables/xtables-multi.h
index 0fedb430e1a28..94c24d5a22c7e 100644
--- a/iptables/xtables-multi.h
+++ b/iptables/xtables-multi.h
@@ -22,6 +22,9 @@ extern int xtables_eb_restore_main(int, char **);
 extern int xtables_eb_save_main(int, char **);
 extern int xtables_config_main(int, char **);
 extern int xtables_monitor_main(int, char **);
+
+extern struct xtables_globals arptables_globals;
+extern struct xtables_globals ebtables_globals;
 #endif
 
 #endif /* _XTABLES_MULTI_H */
diff --git a/iptables/xtables-standalone.c b/iptables/xtables-standalone.c
index 54c70c5429766..19d663b02348c 100644
--- a/iptables/xtables-standalone.c
+++ b/iptables/xtables-standalone.c
@@ -39,19 +39,34 @@
 #include "xtables-multi.h"
 #include "nft.h"
 
+static struct xtables_globals *xtables_globals_lookup(int family)
+{
+	switch (family) {
+	case AF_INET:
+	case AF_INET6:
+		return &xtables_globals;
+	case NFPROTO_ARP:
+		return &arptables_globals;
+	case NFPROTO_BRIDGE:
+		return &ebtables_globals;
+	default:
+		xtables_error(OTHER_PROBLEM, "Unknown family value %d", family);
+	}
+}
+
 static int
 xtables_main(int family, const char *progname, int argc, char *argv[])
 {
-	int ret;
 	char *table = "filter";
 	struct nft_handle h;
+	int ret;
 
-	xtables_globals.program_name = progname;
-	ret = xtables_init_all(&xtables_globals, family);
+	ret = xtables_init_all(xtables_globals_lookup(family), family);
 	if (ret < 0) {
 		fprintf(stderr, "%s: Failed to initialize xtables\n", progname);
 		exit(1);
 	}
+	xt_params->program_name = progname;
 #if defined(ALL_INCLUSIVE) || defined(NO_SHARED_LIBS)
 	init_extensions();
 	init_extensions4();
@@ -60,7 +75,7 @@ xtables_main(int family, const char *progname, int argc, char *argv[])
 
 	if (nft_init(&h, family) < 0) {
 		fprintf(stderr, "%s: Failed to initialize nft: %s\n",
-			xtables_globals.program_name, strerror(errno));
+			xt_params->program_name, strerror(errno));
 		exit(EXIT_FAILURE);
 	}
 
diff --git a/iptables/xtables.c b/iptables/xtables.c
index 2b3cc9301c455..dc67affc19dbe 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -659,7 +659,7 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
 			exit_tryhelp(2);
 
 		default:
-			if (command_default(cs, &xtables_globals, invert))
+			if (command_default(cs, xt_params, invert))
 				/* cf. ip6tables.c */
 				continue;
 			break;
-- 
2.33.0

