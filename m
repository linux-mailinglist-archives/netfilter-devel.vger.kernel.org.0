Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34493306884
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Jan 2021 01:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbhA1AS0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Jan 2021 19:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231378AbhA1ARz (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Jan 2021 19:17:55 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46EAC06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 27 Jan 2021 16:17:15 -0800 (PST)
Received: from localhost ([::1]:47878 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1l4uzp-0001rO-RD; Thu, 28 Jan 2021 01:17:13 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] ebtables: Exit gracefully on invalid table names
Date:   Thu, 28 Jan 2021 01:17:05 +0100
Message-Id: <20210128001705.13967-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Users are able to cause program abort by passing a table name that
doesn't exist:

| # ebtables-nft -t dummy -P INPUT ACCEPT
| ebtables: nft-cache.c:455: fetch_chain_cache: Assertion `t' failed.
| Aborted

Avoid this by checking table existence just like iptables-nft does upon
parsing '-t' optarg. Since the list of tables is known and fixed,
checking the given name's length is pointless. So just drop that check
in return.

With this patch in place, output looks much better:

| # ebtables-nft -t dummy -P INPUT ACCEPT
| ebtables v1.8.7 (nf_tables): table 'dummy' does not exist
| Perhaps iptables or your kernel needs to be upgraded.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-eb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index cfa9317c78e94..5bb34d6d292a9 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -914,10 +914,10 @@ print_zero:
 				xtables_error(PARAMETER_PROBLEM,
 					      "The -t option (seen in line %u) cannot be used in %s.\n",
 					      line, xt_params->program_name);
-			if (strlen(optarg) > EBT_TABLE_MAXNAMELEN - 1)
-				xtables_error(PARAMETER_PROBLEM,
-					      "Table name length cannot exceed %d characters",
-					      EBT_TABLE_MAXNAMELEN - 1);
+			if (!nft_table_builtin_find(h, optarg))
+				xtables_error(VERSION_PROBLEM,
+					      "table '%s' does not exist",
+					      optarg);
 			*table = optarg;
 			table_set = true;
 			break;
-- 
2.28.0

