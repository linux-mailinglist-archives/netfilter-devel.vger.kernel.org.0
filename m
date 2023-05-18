Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE2707C9E
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjERJST (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjERJST (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:18:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D5D32102
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:18:08 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrack 1/2] conntrack: do not ignore errors coming from the kernel
Date:   Thu, 18 May 2023 11:18:00 +0200
Message-Id: <20230518091803.90494-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518091803.90494-1-pablo@netfilter.org>
References: <20230518091803.90494-1-pablo@netfilter.org>
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

Do not ignore error from kernel for command invocation.

e42ea65e9c93 ("conntrack: introduce new -A command") ignores CT_ADD
in print_stats, which should not be required.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index 23eaf274a78a..926213a27efc 100644
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
 
@@ -3835,7 +3835,7 @@ int main(int argc, char *argv[])
 			exit_error(OTHER_PROBLEM, "OOM");
 
 		do_parse(cmd, argc, argv);
-		do_command_ct(argv[0], cmd, sock);
+		res |= do_command_ct(argv[0], cmd, sock);
 		res = print_stats(cmd);
 		free(cmd);
 	}
-- 
2.30.2

