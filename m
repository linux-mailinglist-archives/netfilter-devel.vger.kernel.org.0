Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3F43969A5
	for <lists+netfilter-devel@lfdr.de>; Tue,  1 Jun 2021 00:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbhEaWUF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 May 2021 18:20:05 -0400
Received: from mail.netfilter.org ([217.70.188.207]:37718 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhEaWUE (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 May 2021 18:20:04 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id C1B6C64182;
        Tue,  1 Jun 2021 00:17:17 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     kadlec@netfilter.org
Subject: [PATCH ipset 2/3] lib: Detach restore routine from parser
Date:   Tue,  1 Jun 2021 00:18:17 +0200
Message-Id: <20210531221818.24867-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210531221818.24867-1-pablo@netfilter.org>
References: <20210531221818.24867-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Do not call restore() from ipset_parser(). Instead, ipset_parser()
returns the IPSET_CMD_RESTORE command and the caller invokes restore().

This patch comes in preparation for the ipset to nftables translation
infrastructure.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 lib/ipset.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/lib/ipset.c b/lib/ipset.c
index 3077f9793f84..5232d8b76c46 100644
--- a/lib/ipset.c
+++ b/lib/ipset.c
@@ -1231,7 +1231,7 @@ ipset_parser(struct ipset *ipset, int oargc, char *oargv[])
 			return ipset->custom_error(ipset,
 				p, IPSET_PARAMETER_PROBLEM,
 				"Unknown argument %s", argv[1]);
-		return restore(ipset);
+		return IPSET_CMD_RESTORE;
 	case IPSET_CMD_ADD:
 	case IPSET_CMD_DEL:
 	case IPSET_CMD_TEST:
@@ -1296,6 +1296,9 @@ ipset_parse_argv(struct ipset *ipset, int oargc, char *oargv[])
 	if (cmd < 0)
 		return cmd;
 
+	if (cmd == IPSET_CMD_RESTORE)
+		return restore(ipset);
+
 	ret = ipset_cmd(session, cmd, ipset->restore_line);
 	D("ret %d", ret);
 	/* In the case of warning, the return code is success */
-- 
2.20.1

