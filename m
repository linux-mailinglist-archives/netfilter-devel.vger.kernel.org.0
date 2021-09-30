Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AEAC41DBEC
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 Sep 2021 16:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351709AbhI3OHN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 Sep 2021 10:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351745AbhI3OHJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:07:09 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6ECC06176A
        for <netfilter-devel@vger.kernel.org>; Thu, 30 Sep 2021 07:05:26 -0700 (PDT)
Received: from localhost ([::1]:51720 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mVwgf-0007Ri-9O; Thu, 30 Sep 2021 16:05:25 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 02/17] xshared: Store optstring in xtables_globals
Date:   Thu, 30 Sep 2021 16:04:04 +0200
Message-Id: <20210930140419.6170-3-phil@nwl.cc>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210930140419.6170-1-phil@nwl.cc>
References: <20210930140419.6170-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Preparing for a common option parser, store the string of options for
each family inside the respective xtables_globals object. The
array of long option definitions sitting in there already indicates it's
the right place.

While being at it, drop '-m' support from arptables-nft.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/xtables.h      | 1 +
 iptables/xshared.h     | 2 ++
 iptables/xtables-arp.c | 4 ++--
 iptables/xtables-eb.c  | 5 +++--
 iptables/xtables.c     | 4 ++--
 5 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/include/xtables.h b/include/xtables.h
index e51f4bfda318a..c872a04220867 100644
--- a/include/xtables.h
+++ b/include/xtables.h
@@ -420,6 +420,7 @@ struct xtables_globals
 {
 	unsigned int option_offset;
 	const char *program_name, *program_version;
+	const char *optstring;
 	struct option *orig_opts;
 	struct option *opts;
 	void (*exit_err)(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
diff --git a/iptables/xshared.h b/iptables/xshared.h
index 823894f94b841..b59116ac49747 100644
--- a/iptables/xshared.h
+++ b/iptables/xshared.h
@@ -68,6 +68,8 @@ struct xtables_globals;
 struct xtables_rule_match;
 struct xtables_target;
 
+#define OPTSTRING_COMMON "-:A:C:D:E:F::I:L::M:N:P:VX::Z::" "c:d:i:j:o:p:s:t:"
+
 /* define invflags which won't collide with IPT ones */
 #define IPT_INV_SRCDEVADDR	0x0080
 #define IPT_INV_TGTDEVADDR	0x0100
diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 1d132bdf23546..a028ac340cba0 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -100,6 +100,7 @@ extern void xtables_exit_error(enum xtables_exittype status, const char *msg, ..
 struct xtables_globals arptables_globals = {
 	.option_offset		= 0,
 	.program_version	= PACKAGE_VERSION,
+	.optstring		= OPTSTRING_COMMON "R:S::" "h::l:nv" /* "m:" */,
 	.orig_opts		= original_opts,
 	.exit_err		= xtables_exit_error,
 	.compat_rev		= nft_compatible_revision,
@@ -444,8 +445,7 @@ int do_commandarp(struct nft_handle *h, int argc, char *argv[], char **table,
 	opterr = 0;
 
 	opts = xt_params->orig_opts;
-	while ((c = getopt_long(argc, argv,
-	   "-A:D:R:I:L::M:F::Z::N:X::E:P:Vh::o:p:s:d:j:l:i:vnt:m:c:",
+	while ((c = getopt_long(argc, argv, xt_params->optstring,
 					   opts, NULL)) != -1) {
 		switch (c) {
 			/*
diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 1ed6bcd8a7877..3f58754d14cee 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -220,6 +220,7 @@ extern void xtables_exit_error(enum xtables_exittype status, const char *msg, ..
 struct xtables_globals ebtables_globals = {
 	.option_offset 		= 0,
 	.program_version	= PACKAGE_VERSION,
+	.optstring		= OPTSTRING_COMMON "h",
 	.orig_opts		= ebt_original_options,
 	.exit_err		= xtables_exit_error,
 	.compat_rev		= nft_compatible_revision,
@@ -732,8 +733,8 @@ int do_commandeb(struct nft_handle *h, int argc, char *argv[], char **table,
 	opterr = false;
 
 	/* Getopt saves the day */
-	while ((c = getopt_long(argc, argv,
-	   "-A:D:C:I:N:E:X::L::Z::F::P:Vhi:o:j:c:p:s:d:t:M:", opts, NULL)) != -1) {
+	while ((c = getopt_long(argc, argv, xt_params->optstring,
+					opts, NULL)) != -1) {
 		cs.c = c;
 		switch (c) {
 
diff --git a/iptables/xtables.c b/iptables/xtables.c
index 0a700e0847400..c17cf7aec6178 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -89,6 +89,7 @@ void xtables_exit_error(enum xtables_exittype status, const char *msg, ...) __at
 struct xtables_globals xtables_globals = {
 	.option_offset = 0,
 	.program_version = PACKAGE_VERSION,
+	.optstring = OPTSTRING_COMMON "R:S::W::" "46bfg:h::m:nvw::x",
 	.orig_opts = original_opts,
 	.exit_err = xtables_exit_error,
 	.compat_rev = nft_compatible_revision,
@@ -455,8 +456,7 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
 	opterr = 0;
 
 	opts = xt_params->orig_opts;
-	while ((cs->c = getopt_long(argc, argv,
-	   "-:A:C:D:R:I:L::S::M:F::Z::N:X::E:P:Vh::o:p:s:d:j:i:fbvw::W::nt:m:xc:g:46",
+	while ((cs->c = getopt_long(argc, argv, xt_params->optstring,
 					   opts, NULL)) != -1) {
 		switch (cs->c) {
 			/*
-- 
2.33.0

