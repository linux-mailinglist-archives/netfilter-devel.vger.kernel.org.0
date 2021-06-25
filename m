Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77DAF3B49C2
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Jun 2021 22:30:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFYUdM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 25 Jun 2021 16:33:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:52982 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhFYUdM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 25 Jun 2021 16:33:12 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 0D87961641;
        Fri, 25 Jun 2021 22:30:49 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kadlec@netfilter.org
Subject: [PATCH ipset,v4 1/4] lib: split parser from command execution
Date:   Fri, 25 Jun 2021 22:30:40 +0200
Message-Id: <20210625203043.17265-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210625203043.17265-1-pablo@netfilter.org>
References: <20210625203043.17265-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ipset_parse_argv() parses, builds and send the netlink messages to the
kernel. This patch extracts the parser and wrap it around the new
ipset_parser() function.

This patch comes is preparation for the ipset to nftables translation
infrastructure.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v4: no changes.

 lib/ipset.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/lib/ipset.c b/lib/ipset.c
index 672991965770..3077f9793f84 100644
--- a/lib/ipset.c
+++ b/lib/ipset.c
@@ -923,20 +923,8 @@ static const char *cmd_prefix[] = {
 	[IPSET_TEST]   = "test   SETNAME",
 };
 
-/* Workhorses */
-
-/**
- * ipset_parse_argv - parse and argv array and execute the command
- * @ipset: ipset structure
- * @argc: length of the array
- * @argv: array of strings
- *
- * Parse an array of strings and execute the ipset command.
- *
- * Returns 0 on success or a negative error code.
- */
-int
-ipset_parse_argv(struct ipset *ipset, int oargc, char *oargv[])
+static int
+ipset_parser(struct ipset *ipset, int oargc, char *oargv[])
 {
 	int ret = 0;
 	enum ipset_cmd cmd = IPSET_CMD_NONE;
@@ -1280,6 +1268,34 @@ ipset_parse_argv(struct ipset *ipset, int oargc, char *oargv[])
 	if (argc > 1)
 		return ipset->custom_error(ipset, p, IPSET_PARAMETER_PROBLEM,
 			"Unknown argument %s", argv[1]);
+
+	return cmd;
+}
+
+/* Workhorses */
+
+/**
+ * ipset_parse_argv - parse and argv array and execute the command
+ * @ipset: ipset structure
+ * @argc: length of the array
+ * @argv: array of strings
+ *
+ * Parse an array of strings and execute the ipset command.
+ *
+ * Returns 0 on success or a negative error code.
+ */
+int
+ipset_parse_argv(struct ipset *ipset, int oargc, char *oargv[])
+{
+	struct ipset_session *session = ipset->session;
+	void *p = ipset_session_printf_private(session);
+	enum ipset_cmd cmd;
+	int ret;
+
+	cmd = ipset_parser(ipset, oargc, oargv);
+	if (cmd < 0)
+		return cmd;
+
 	ret = ipset_cmd(session, cmd, ipset->restore_line);
 	D("ret %d", ret);
 	/* In the case of warning, the return code is success */
-- 
2.20.1

