Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B723D2D9B86
	for <lists+netfilter-devel@lfdr.de>; Mon, 14 Dec 2020 16:56:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729704AbgLNPyS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 14 Dec 2020 10:54:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbgLNPyS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 14 Dec 2020 10:54:18 -0500
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E45C0613D3
        for <netfilter-devel@vger.kernel.org>; Mon, 14 Dec 2020 07:53:37 -0800 (PST)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1koqAI-0007GZ-LB; Mon, 14 Dec 2020 16:53:34 +0100
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] json: don't leave dangling pointers on hlist
Date:   Mon, 14 Dec 2020 16:53:29 +0100
Message-Id: <20201214155329.4567-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

unshare -n tests/json_echo/run-test.py
[..]
Adding chain c
free(): double free detected in tcache 2
Aborted (core dumped)

The element must be deleted from the hlist prior to freeing it.

Fixes: 389a0e1edc89a ("json: echo: Speedup seqnum_to_json()")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/parser_json.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/parser_json.c b/src/parser_json.c
index 09e394dfc26d..f0486b77a225 100644
--- a/src/parser_json.c
+++ b/src/parser_json.c
@@ -3786,8 +3786,10 @@ static void json_cmd_assoc_free(void)
 
 	for (i = 0; i < CMD_ASSOC_HSIZE; i++) {
 		hlist_for_each_entry_safe(cur, pos, n,
-					  &json_cmd_assoc_hash[i], hnode)
+					  &json_cmd_assoc_hash[i], hnode) {
+			hlist_del(&cur->hnode);
 			free(cur);
+		}
 	}
 }
 
-- 
2.26.2

