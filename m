Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4B287AA6
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 19:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730694AbgJHRKY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Oct 2020 13:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730685AbgJHRKY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 13:10:24 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D63EC061755
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 10:10:24 -0700 (PDT)
Received: from localhost ([::1]:38112 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kQZQr-0007kt-VK; Thu, 08 Oct 2020 19:10:22 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH] json: Fix memleak in set_dtype_json()
Date:   Thu,  8 Oct 2020 19:10:13 +0200
Message-Id: <20201008171013.17076-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Turns out json_string() already dups the input, so the temporary dup
passed to it is lost.

Fixes: e70354f53e9f6 ("libnftables: Implement JSON output support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/json.c b/src/json.c
index 121dfb247d967..a8824d3fc05a9 100644
--- a/src/json.c
+++ b/src/json.c
@@ -62,7 +62,7 @@ static json_t *set_dtype_json(const struct expr *key)
 
 	tok = strtok(namedup, " .");
 	while (tok) {
-		json_t *jtok = json_string(xstrdup(tok));
+		json_t *jtok = json_string(tok);
 		if (!root)
 			root = jtok;
 		else if (json_is_string(root))
-- 
2.28.0

