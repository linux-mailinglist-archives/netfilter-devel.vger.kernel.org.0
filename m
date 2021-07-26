Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42C763D56F4
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jul 2021 12:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhGZJVY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 26 Jul 2021 05:21:24 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60568 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232617AbhGZJVX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 26 Jul 2021 05:21:23 -0400
Received: from salvia.lan (bl11-146-165.dsl.telepac.pt [85.244.146.165])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3387860702
        for <netfilter-devel@vger.kernel.org>; Mon, 26 Jul 2021 12:01:22 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] parser_bison: stateful statement support in map
Date:   Mon, 26 Jul 2021 12:01:44 +0200
Message-Id: <20210726100144.11907-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Missing parser extension to support for stateful statements in map.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 5545a43d160e..b9b3d026a4ee 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -2052,6 +2052,12 @@ map_block		:	/* empty */	{ $$ = $<set>-1; }
 				$1->flags |= $3;
 				$$ = $1;
 			}
+			|	map_block	stateful_stmt_list		stmt_separator
+			{
+				list_splice_tail($2, &$1->stmt_list);
+				$$ = $1;
+				free($2);
+			}
 			|	map_block	ELEMENTS	'='		set_block_expr
 			{
 				$1->init = $4;
-- 
2.20.1

