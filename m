Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37A6707CB1
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbjERJVq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:21:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjERJVp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:21:45 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 954DA1FDC
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:21:44 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack,v2] conntrack: do not silence EEXIST error, use NLM_F_EXCL
Date:   Thu, 18 May 2023 11:21:41 +0200
Message-Id: <20230518092141.90735-1-pablo@netfilter.org>
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

Instead of silencing EEXIST error with -A/--add, unset NLM_F_EXCL
netlink flag.

Do not ignore error from kernel for command invocation.

This patch revisits e42ea65e9c93 ("conntrack: introduce new -A
command").

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v2: squash
    https://patchwork.ozlabs.org/project/netfilter-devel/patch/20230518091832.90570-1-pablo@netfilter.org/
    into this patch, it is actually part of the same logical update.

 src/conntrack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index 23eaf274a78a..b9fcf8e44ee2 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -2886,7 +2886,7 @@ static int print_stats(const struct ct_cmd *cmd)
 		fprintf(stderr, "%s v%s (conntrack-tools): ",PROGNAME,VERSION);
 		fprintf(stderr, exit_msg[cmd->cmd], counter);
 		if (counter == 0 &&
-		    !(cmd->command & (CT_LIST | EXP_LIST | CT_ADD)))
+		    !(cmd->command & (CT_LIST | EXP_LIST)))
 			return -1;
 	}
 
@@ -3219,6 +3219,7 @@ static int do_command_ct(const char *progname, struct ct_cmd *cmd,
 	struct nfct_mnl_socket *modifier_sock = &_modifier_sock;
 	struct nfct_mnl_socket *event_sock = &_event_sock;
 	struct nfct_filter_dump *filter_dump;
+	uint16_t nl_flags = 0;
 	int res = 0;
 
 	switch(cmd->command) {
@@ -3305,14 +3306,15 @@ static int do_command_ct(const char *progname, struct ct_cmd *cmd,
 			nfct_set_attr(cmd->tmpl.ct, ATTR_CONNLABELS,
 					xnfct_bitmask_clone(cmd->tmpl.label_modify));
 
+		if (cmd->command == CT_CREATE)
+			nl_flags = NLM_F_EXCL;
+
 		res = nfct_mnl_request(sock, NFNL_SUBSYS_CTNETLINK, cmd->family,
 				       IPCTNL_MSG_CT_NEW,
-				       NLM_F_CREATE | NLM_F_ACK | NLM_F_EXCL,
+				       NLM_F_CREATE | NLM_F_ACK | nl_flags,
 				       NULL, cmd->tmpl.ct, NULL);
 		if (res >= 0)
 			counter++;
-		else if (errno == EEXIST && cmd->command == CT_ADD)
-			res = 0;
 		break;
 
 	case EXP_CREATE:
@@ -3835,7 +3837,7 @@ int main(int argc, char *argv[])
 			exit_error(OTHER_PROBLEM, "OOM");
 
 		do_parse(cmd, argc, argv);
-		do_command_ct(argv[0], cmd, sock);
+		res |= do_command_ct(argv[0], cmd, sock);
 		res = print_stats(cmd);
 		free(cmd);
 	}
-- 
2.30.2

