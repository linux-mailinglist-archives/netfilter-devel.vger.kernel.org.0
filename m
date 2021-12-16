Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6C8C47726E
	for <lists+netfilter-devel@lfdr.de>; Thu, 16 Dec 2021 13:59:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhLPM7C (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 16 Dec 2021 07:59:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237061AbhLPM7B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:59:01 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547FC06173E
        for <netfilter-devel@vger.kernel.org>; Thu, 16 Dec 2021 04:59:01 -0800 (PST)
Received: from localhost ([::1]:58974 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mxqLc-00044j-2I; Thu, 16 Dec 2021 13:59:00 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v3 5/6] libxtables: Extend basic_exit_err()
Date:   Thu, 16 Dec 2021 13:58:39 +0100
Message-Id: <20211216125840.385-6-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211216125840.385-1-phil@nwl.cc>
References: <20211216125840.385-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Basically merge the function with xtables_exit_error,
printing a status-specific footer for parameter or version problems.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Changes since v2:
- No need to account for possible program_variant.

Changes since v1:
- Do not require existence of exit_tryhelp() in libxtables, instead
  merge its code into basic_exit_error() - it's merely two printf()
  calls after all.
---
 iptables/ip6tables.c   | 22 ----------------------
 iptables/iptables.c    | 23 -----------------------
 iptables/xtables-arp.c |  2 --
 iptables/xtables-eb.c  |  2 --
 iptables/xtables.c     | 23 -----------------------
 libxtables/xtables.c   | 12 ++++++++++++
 6 files changed, 12 insertions(+), 72 deletions(-)

diff --git a/iptables/ip6tables.c b/iptables/ip6tables.c
index 44d2c08cddc42..2f3ff034fbbb7 100644
--- a/iptables/ip6tables.c
+++ b/iptables/ip6tables.c
@@ -87,12 +87,10 @@ static struct option original_opts[] = {
 	{NULL},
 };
 
-void ip6tables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
 struct xtables_globals ip6tables_globals = {
 	.option_offset = 0,
 	.program_version = PACKAGE_VERSION " (legacy)",
 	.orig_opts = original_opts,
-	.exit_err = ip6tables_exit_error,
 	.compat_rev = xtables_compatible_revision,
 };
 
@@ -107,26 +105,6 @@ exit_printhelp(const struct xtables_rule_match *matches)
 	exit(0);
 }
 
-void
-ip6tables_exit_error(enum xtables_exittype status, const char *msg, ...)
-{
-	va_list args;
-
-	va_start(args, msg);
-	fprintf(stderr, "%s v%s: ", prog_name, prog_vers);
-	vfprintf(stderr, msg, args);
-	va_end(args);
-	fprintf(stderr, "\n");
-	if (status == PARAMETER_PROBLEM)
-		exit_tryhelp(status, line);
-	if (status == VERSION_PROBLEM)
-		fprintf(stderr,
-			"Perhaps ip6tables or your kernel needs to be upgraded.\n");
-	/* On error paths, make sure that we don't leak memory */
-	xtables_free_opts(1);
-	exit(status);
-}
-
 /*
  *	All functions starting with "parse" should succeed, otherwise
  *	the program fails.
diff --git a/iptables/iptables.c b/iptables/iptables.c
index 191877ec1bb06..ba04fbc6a806e 100644
--- a/iptables/iptables.c
+++ b/iptables/iptables.c
@@ -84,13 +84,10 @@ static struct option original_opts[] = {
 	{NULL},
 };
 
-void iptables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
-
 struct xtables_globals iptables_globals = {
 	.option_offset = 0,
 	.program_version = PACKAGE_VERSION " (legacy)",
 	.orig_opts = original_opts,
-	.exit_err = iptables_exit_error,
 	.compat_rev = xtables_compatible_revision,
 };
 
@@ -105,26 +102,6 @@ exit_printhelp(const struct xtables_rule_match *matches)
 	exit(0);
 }
 
-void
-iptables_exit_error(enum xtables_exittype status, const char *msg, ...)
-{
-	va_list args;
-
-	va_start(args, msg);
-	fprintf(stderr, "%s v%s: ", prog_name, prog_vers);
-	vfprintf(stderr, msg, args);
-	va_end(args);
-	fprintf(stderr, "\n");
-	if (status == PARAMETER_PROBLEM)
-		exit_tryhelp(status, line);
-	if (status == VERSION_PROBLEM)
-		fprintf(stderr,
-			"Perhaps iptables or your kernel needs to be upgraded.\n");
-	/* On error paths, make sure that we don't leak memory */
-	xtables_free_opts(1);
-	exit(status);
-}
-
 /*
  *	All functions starting with "parse" should succeed, otherwise
  *	the program fails.
diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 8a226330a7124..805fb19a5f937 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -84,14 +84,12 @@ static struct option original_opts[] = {
 
 #define opts xt_params->opts
 
-extern void xtables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
 static void printhelp(const struct xtables_rule_match *m);
 struct xtables_globals arptables_globals = {
 	.option_offset		= 0,
 	.program_version	= PACKAGE_VERSION " (nf_tables)",
 	.optstring		= OPTSTRING_COMMON "C:R:S::" "h::l:nv" /* "m:" */,
 	.orig_opts		= original_opts,
-	.exit_err		= xtables_exit_error,
 	.compat_rev		= nft_compatible_revision,
 	.print_help		= printhelp,
 };
diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 604d4d39e90f7..ed8f733246ca3 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -216,13 +216,11 @@ struct option ebt_original_options[] =
 	{ 0 }
 };
 
-extern void xtables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
 struct xtables_globals ebtables_globals = {
 	.option_offset 		= 0,
 	.program_version	= PACKAGE_VERSION " (nf_tables)",
 	.optstring		= OPTSTRING_COMMON "h",
 	.orig_opts		= ebt_original_options,
-	.exit_err		= xtables_exit_error,
 	.compat_rev		= nft_compatible_revision,
 };
 
diff --git a/iptables/xtables.c b/iptables/xtables.c
index a6b10cf846d58..5255fa340d55d 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -86,14 +86,11 @@ static struct option original_opts[] = {
 	{NULL},
 };
 
-void xtables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
-
 struct xtables_globals xtables_globals = {
 	.option_offset = 0,
 	.program_version = PACKAGE_VERSION " (nf_tables)",
 	.optstring = OPTSTRING_COMMON "R:S::W::" "46bfg:h::m:nvw::x",
 	.orig_opts = original_opts,
-	.exit_err = xtables_exit_error,
 	.compat_rev = nft_compatible_revision,
 	.print_help = xtables_printhelp,
 };
@@ -102,26 +99,6 @@ struct xtables_globals xtables_globals = {
 #define prog_name xt_params->program_name
 #define prog_vers xt_params->program_version
 
-void
-xtables_exit_error(enum xtables_exittype status, const char *msg, ...)
-{
-	va_list args;
-
-	va_start(args, msg);
-	fprintf(stderr, "%s v%s: ", prog_name, prog_vers);
-	vfprintf(stderr, msg, args);
-	va_end(args);
-	fprintf(stderr, "\n");
-	if (status == PARAMETER_PROBLEM)
-		exit_tryhelp(status, line);
-	if (status == VERSION_PROBLEM)
-		fprintf(stderr,
-			"Perhaps iptables or your kernel needs to be upgraded.\n");
-	/* On error paths, make sure that we don't leak memory */
-	xtables_free_opts(1);
-	exit(status);
-}
-
 /*
  *	All functions starting with "parse" should succeed, otherwise
  *	the program fails.
diff --git a/libxtables/xtables.c b/libxtables/xtables.c
index d670175db2236..50fd6a44b0100 100644
--- a/libxtables/xtables.c
+++ b/libxtables/xtables.c
@@ -90,6 +90,18 @@ void basic_exit_err(enum xtables_exittype status, const char *msg, ...)
 	vfprintf(stderr, msg, args);
 	va_end(args);
 	fprintf(stderr, "\n");
+	if (status == PARAMETER_PROBLEM) {
+		if (line != -1)
+			fprintf(stderr, "Error occurred at line: %d\n", line);
+		fprintf(stderr, "Try `%s -h' or '%s --help' for more information.\n",
+				xt_params->program_name, xt_params->program_name);
+	} else if (status == VERSION_PROBLEM) {
+		fprintf(stderr,
+			"Perhaps %s or your kernel needs to be upgraded.\n",
+			xt_params->program_name);
+	}
+	/* On error paths, make sure that we don't leak memory */
+	xtables_free_opts(1);
 	exit(status);
 }
 
-- 
2.33.0

