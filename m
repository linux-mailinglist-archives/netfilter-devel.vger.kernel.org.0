Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCF226B9AAA
	for <lists+netfilter-devel@lfdr.de>; Tue, 14 Mar 2023 17:06:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230293AbjCNQGI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 14 Mar 2023 12:06:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbjCNQGB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:06:01 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E329D41095
        for <netfilter-devel@vger.kernel.org>; Tue, 14 Mar 2023 09:05:42 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft] parser_bison: simplify reset syntax
Date:   Tue, 14 Mar 2023 17:05:37 +0100
Message-Id: <20230314160537.827655-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Simplify:

*reset rules* *chain* ['family'] 'table' ['chain]'
to
*reset rules* ['family'] 'table' 'chain'

*reset rules* *table* ['family'] 'table'
to
*reset rules* ['family'] 'table'

*reset counters* ['family'] *table* 'table'
to
*reset counters* ['family'] 'table'

*reset quotas* ['family'] *table* 'table'
to
*reset quotas* ['family'] 'table'

Previous syntax remains in place for backward compatibility.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/nft.txt        |  8 ++++----
 src/parser_bison.y | 20 ++++++++++++++++++++
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/doc/nft.txt b/doc/nft.txt
index 0d60c7520d31..8624d5dd8f60 100644
--- a/doc/nft.txt
+++ b/doc/nft.txt
@@ -491,8 +491,8 @@ RULES
 {*delete* | *reset*} *rule* ['family'] 'table' 'chain' *handle* 'handle'
 *destroy rule* ['family'] 'table' 'chain' *handle* 'handle'
 *reset rules* ['family']
-*reset rules* *table* ['family'] 'table'
-*reset rules* *chain* ['family'] 'table' ['chain']
+*reset rules* ['family'] 'table'
+*reset chain* ['family'] 'table' 'chain'
 
 Rules are added to chains in the given table. If the family is not specified, the
 ip family is used. Rules are constructed from two kinds of components according
@@ -762,8 +762,8 @@ STATEFUL OBJECTS
 *list limits* ['family']
 *reset counters* ['family']
 *reset quotas* ['family']
-*reset counters* ['family'] *table* 'table'
-*reset quotas* ['family'] *table* 'table'
+*reset counters* ['family'] 'table'
+*reset quotas* ['family'] 'table'
 
 Stateful objects are attached to tables and are identified by a unique name.
 They group stateful information from rules, to reference them in rules the
diff --git a/src/parser_bison.y b/src/parser_bison.y
index ccedfafe1bfa..e4f21ca1a722 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -1650,11 +1650,16 @@ basehook_spec		:	ruleset_spec
 			;
 
 reset_cmd		:	COUNTERS	ruleset_spec
+			{
+				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_COUNTERS, &$2, &@$, NULL);
+			}
+			|	COUNTERS	table_spec
 			{
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_COUNTERS, &$2, &@$, NULL);
 			}
 			|	COUNTERS	TABLE	table_spec
 			{
+				/* alias of previous rule. */
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_COUNTERS, &$3, &@$, NULL);
 			}
 			|       COUNTER         obj_spec	close_scope_counter
@@ -1669,6 +1674,11 @@ reset_cmd		:	COUNTERS	ruleset_spec
 			{
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_QUOTAS, &$3, &@$, NULL);
 			}
+			|	QUOTAS		table_spec
+			{
+				/* alias of previous rule. */
+				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_QUOTAS, &$2, &@$, NULL);
+			}
 			|       QUOTA           obj_spec	close_scope_quota
 			{
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_QUOTA, &$2, &@$, NULL);
@@ -1677,12 +1687,22 @@ reset_cmd		:	COUNTERS	ruleset_spec
 			{
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_RULES, &$2, &@$, NULL);
 			}
+			|	RULES		table_spec
+			{
+				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_RULES, &$2, &@$, NULL);
+			}
 			|	RULES		TABLE	table_spec
 			{
+				/* alias of previous rule. */
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_RULES, &$3, &@$, NULL);
 			}
+			|	RULES		chain_spec
+			{
+				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_RULES, &$2, &@$, NULL);
+			}
 			|	RULES		CHAIN	chain_spec
 			{
+				/* alias of previous rule. */
 				$$ = cmd_alloc(CMD_RESET, CMD_OBJ_RULES, &$3, &@$, NULL);
 			}
 			|	RULE		ruleid_spec
-- 
2.30.2

