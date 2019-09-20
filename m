Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A80A3B945F
	for <lists+netfilter-devel@lfdr.de>; Fri, 20 Sep 2019 17:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404040AbfITPta (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 20 Sep 2019 11:49:30 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:32864 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403836AbfITPta (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 20 Sep 2019 11:49:30 -0400
Received: from localhost ([::1]:45954 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iBLA1-0002Uq-C1; Fri, 20 Sep 2019 17:49:29 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xtables-restore: Fix --table parameter check
Date:   Fri, 20 Sep 2019 17:49:20 +0200
Message-Id: <20190920154920.7927-1-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Xtables-restore tries to reject rule commands in input which contain a
--table parameter (since it is adding this itself based on the previous
table line). Sadly getopt_long's flexibility makes it hard to get this
check right: Since the last fix, comments starting with a dash and
containing a 't' character somewhere later were rejected. Simple
example:

| *filter
| -A FORWARD -m comment --comment "- allow this one" -j ACCEPT
| COMMIT

To hopefully sort this once and for all, introduce is_table_param()
which should cover all possible variants of legal and illegal
parameters. Also add a test to make sure it does what it is supposed to.

Fixes: f8e5ebc5986bf ("iptables: Fix crash on malformed iptables-restore")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 .../ipt-restore/0009-table-name-comment_0     | 48 +++++++++++++++++++
 iptables/xshared.c                            | 44 ++++++++++++++---
 2 files changed, 86 insertions(+), 6 deletions(-)
 create mode 100755 iptables/tests/shell/testcases/ipt-restore/0009-table-name-comment_0

diff --git a/iptables/tests/shell/testcases/ipt-restore/0009-table-name-comment_0 b/iptables/tests/shell/testcases/ipt-restore/0009-table-name-comment_0
new file mode 100755
index 0000000000000..71c8feffd5adf
--- /dev/null
+++ b/iptables/tests/shell/testcases/ipt-restore/0009-table-name-comment_0
@@ -0,0 +1,48 @@
+#!/bin/bash
+
+OKLINES="- some comment
+--asdf
+-asdf t
+-?t"
+
+NONOLINES="-t foo
+-t
+--table
+--table foo
+--table=foo
+-asdft
+-tasdf
+--tab=foo
+-dfetbl"
+
+to_dump() { # (comment)
+	echo "*filter"
+	echo "-A FORWARD -m comment --comment \"$@\" -j ACCEPT"
+	echo "COMMIT"
+}
+
+ret=0
+
+while read okline; do
+	$XT_MULTI iptables -A FORWARD -m comment --comment "$okline" -j ACCEPT || {
+		echo "iptables failed for comment '$okline'"
+		ret=1
+	}
+	to_dump "$okline" | $XT_MULTI iptables-restore || {
+		echo "iptables-restore failed for comment '$okline'"
+		ret=1
+	}
+done <<< "$OKLINES"
+
+while read nonoline; do
+	$XT_MULTI iptables -A FORWARD -m comment --comment "$nonoline" -j ACCEPT >/dev/null 2>&1 || {
+		echo "iptables accepted comment '$nonoline'"
+		ret=1
+	}
+	to_dump "$nonoline" | $XT_MULTI iptables-restore >/dev/null 2>&1 && {
+		echo "iptables-restore accepted comment '$nonoline'"
+		ret=1
+	}
+done <<< "$NONOLINES"
+
+exit $ret
diff --git a/iptables/xshared.c b/iptables/xshared.c
index 36a2ec5f193d3..faa21d6cd69af 100644
--- a/iptables/xshared.c
+++ b/iptables/xshared.c
@@ -446,6 +446,43 @@ static void add_param(struct xt_param_buf *param, const char *curchar)
 			      "Parameter too long!");
 }
 
+static bool is_table_param(const char *s)
+{
+	if (s[0] != '-')
+		return false;
+
+	/* it is an option */
+	switch (s[1]) {
+	case 't':
+		/* -t found */
+		return true;
+	case '-':
+		/* it is a long option */
+		if (s[2] != 't')
+			return false;
+		if (index(s, '='))
+			return !strncmp(s, "--table", index(s, '=') - s);
+		return !strncmp(s, "--table", 7);
+	default:
+		break;
+	}
+	/* short options may be combined, check if 't' is among them */
+next:
+	s++;
+	switch (*s) {
+	case 't':
+	case ' ':
+	case '\0':
+		break;
+	case 'a' ... 's':
+	case 'u' ... 'z':
+	case 'A' ... 'Z':
+	case '0' ... '9':
+		goto next;
+	}
+	return *s == 't';
+}
+
 void add_param_to_argv(char *parsestart, int line)
 {
 	int quote_open = 0, escaped = 0;
@@ -499,15 +536,10 @@ void add_param_to_argv(char *parsestart, int line)
 		param.buffer[param.len] = '\0';
 
 		/* check if table name specified */
-		if ((param.buffer[0] == '-' &&
-		     param.buffer[1] != '-' &&
-		     strchr(param.buffer, 't')) ||
-		    (!strncmp(param.buffer, "--t", 3) &&
-		     !strncmp(param.buffer, "--table", strlen(param.buffer)))) {
+		if (is_table_param(param.buffer))
 			xtables_error(PARAMETER_PROBLEM,
 				      "The -t option (seen in line %u) cannot be used in %s.\n",
 				      line, xt_params->program_name);
-		}
 
 		add_argv(param.buffer, 0);
 		param.len = 0;
-- 
2.23.0

