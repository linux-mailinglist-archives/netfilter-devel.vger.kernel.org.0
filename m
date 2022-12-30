Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19C2F65342A
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Dec 2022 17:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234471AbiLUQhx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Dec 2022 11:37:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbiLUQhv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:37:51 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B779D1FF8B
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Dec 2022 08:37:49 -0800 (PST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft] owner: Fix potential array out of bounds access
Date:   Wed, 21 Dec 2022 17:37:46 +0100
Message-Id: <20221221163746.63408-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If the link target length exceeds 'sizeof(tmp)' bytes, readlink() will
return 'sizeof(tmp)'. Using this value as index is illegal.

Original update from Phil, for the conntrack-tools tree, which also has
a copy of this function.

Fixes: 6d085b22a8b5 ("table: support for the table owner flag")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Same as:

https://patchwork.ozlabs.org/project/netfilter-devel/patch/20221220153847.24152-2-phil@nwl.cc/

 src/owner.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/owner.c b/src/owner.c
index 2d98a2e98028..20bed38b2a09 100644
--- a/src/owner.c
+++ b/src/owner.c
@@ -66,7 +66,7 @@ static char *portid2name(pid_t pid, uint32_t portid, unsigned long inode)
 			continue;
 
 		rl = readlink(procname, tmp, sizeof(tmp));
-		if (rl <= 0 || rl > (ssize_t)sizeof(tmp))
+		if (rl <= 0 || rl >= (ssize_t)sizeof(tmp))
 			continue;
 
 		tmp[rl] = 0;
-- 
2.30.2

