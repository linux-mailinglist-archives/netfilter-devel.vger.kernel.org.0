Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 441433A46B0
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230344AbhFKQnm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQnl (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:41 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D7CC061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:42 -0700 (PDT)
Received: from localhost ([::1]:41360 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkE1-0005f5-9U; Fri, 11 Jun 2021 18:41:41 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 10/10] rule: Fix for potential off-by-one in cmd_add_loc()
Date:   Fri, 11 Jun 2021 18:41:04 +0200
Message-Id: <20210611164104.8121-11-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Using num_attrs as index means it must be at max one less than the
array's size at function start.

Fixes: 27362a5bfa433 ("rule: larger number of error locations")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/rule.c b/src/rule.c
index dbbe744eee0d8..92daf2f33b76b 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1275,7 +1275,7 @@ struct cmd *cmd_alloc(enum cmd_ops op, enum cmd_obj obj,
 
 void cmd_add_loc(struct cmd *cmd, uint16_t offset, const struct location *loc)
 {
-	if (cmd->num_attrs > NFT_NLATTR_LOC_MAX)
+	if (cmd->num_attrs >= NFT_NLATTR_LOC_MAX)
 		return;
 
 	cmd->attr[cmd->num_attrs].offset = offset;
-- 
2.31.1

