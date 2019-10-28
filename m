Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B005CE7579
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 16:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390062AbfJ1PtQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 11:49:16 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40152 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390007AbfJ1PtQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:49:16 -0400
Received: from localhost ([::1]:53242 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iP7Gc-00027y-Bb; Mon, 28 Oct 2019 16:49:14 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 05/10] xtables-arp: Drop generic_opt_check()
Date:   Mon, 28 Oct 2019 16:48:13 +0100
Message-Id: <20191028154818.31257-6-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028154818.31257-1-phil@nwl.cc>
References: <20191028154818.31257-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With all fields in commands_v_options[][] being whitespace, the function
is effectively a noop.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-arp.c | 66 ------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 88a7d534da4f1..ae69baf2a9346 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -139,34 +139,6 @@ struct xtables_globals arptables_globals = {
 	.compat_rev		= nft_compatible_revision,
 };
 
-/* Table of legal combinations of commands and options.  If any of the
- * given commands make an option legal, that option is legal (applies to
- * CMD_LIST and CMD_ZERO only).
- * Key:
- *  +  compulsory
- *  x  illegal
- *     optional
- */
-
-static char commands_v_options[NUMBER_OF_CMD][NUMBER_OF_OPT] =
-/* Well, it's better than "Re: Linux vs FreeBSD" */
-{
-	/*     -n  -s  -d  -p  -j  -v  -x  -i  -o  -f  --line */
-/*INSERT*/    {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*DELETE*/    {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*DELETE_NUM*/{' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*REPLACE*/   {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*APPEND*/    {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*LIST*/      {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*FLUSH*/     {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*ZERO*/      {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*NEW_CHAIN*/ {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*DEL_CHAIN*/ {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*SET_POLICY*/{' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*CHECK*/     {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '},
-/*RENAME*/    {' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' ',' '}
-};
-
 static int inverse_for_options[NUMBER_OF_OPT] =
 {
 /* -n */ 0,
@@ -395,42 +367,6 @@ exit_printhelp(void)
 	exit(0);
 }
 
-static void
-generic_opt_check(int command, int options)
-{
-	int i, j, legal = 0;
-
-	/* Check that commands are valid with options.  Complicated by the
-	 * fact that if an option is legal with *any* command given, it is
-	 * legal overall (ie. -z and -l).
-	 */
-	for (i = 0; i < NUMBER_OF_OPT; i++) {
-		legal = 0; /* -1 => illegal, 1 => legal, 0 => undecided. */
-
-		for (j = 0; j < NUMBER_OF_CMD; j++) {
-			if (!(command & (1<<j)))
-				continue;
-
-			if (!(options & (1<<i))) {
-				if (commands_v_options[j][i] == '+')
-					xtables_error(PARAMETER_PROBLEM,
-						      "You need to supply the `-%c' "
-						      "option for this command\n",
-						      optflags[i]);
-			} else {
-				if (commands_v_options[j][i] != 'x')
-					legal = 1;
-				else if (legal == 0)
-					legal = -1;
-			}
-		}
-		if (legal == -1)
-			xtables_error(PARAMETER_PROBLEM,
-				      "Illegal option `-%c' with this command\n",
-				      optflags[i]);
-	}
-}
-
 static char
 opt2char(int option)
 {
@@ -1059,8 +995,6 @@ int do_commandarp(struct nft_handle *h, int argc, char *argv[], char **table,
 		xtables_error(PARAMETER_PROBLEM, "Replacement rule does not "
 						 "specify a unique address");
 
-	generic_opt_check(command, options);
-
 	if (chain && strlen(chain) > ARPT_FUNCTION_MAXNAMELEN)
 		xtables_error(PARAMETER_PROBLEM,
 				"chain name `%s' too long (must be under %i chars)",
-- 
2.23.0

