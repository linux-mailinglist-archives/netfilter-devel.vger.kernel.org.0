Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6971C7806
	for <lists+netfilter-devel@lfdr.de>; Wed,  6 May 2020 19:34:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729631AbgEFRef (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 6 May 2020 13:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728047AbgEFRef (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 6 May 2020 13:34:35 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B219C061A0F
        for <netfilter-devel@vger.kernel.org>; Wed,  6 May 2020 10:34:35 -0700 (PDT)
Received: from localhost ([::1]:58750 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jWNwI-0002mU-2O; Wed, 06 May 2020 19:34:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 09/15] nft: Fix leak when deleting rules
Date:   Wed,  6 May 2020 19:33:25 +0200
Message-Id: <20200506173331.9347-10-phil@nwl.cc>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200506173331.9347-1-phil@nwl.cc>
References: <20200506173331.9347-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

For NFT_COMPAT_RULE_DELETE jobs, batch_obj_del() has to do the rule
freeing, they are no longer in cache.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index c0b5e2fc524a7..01268f7859e9b 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2680,8 +2680,8 @@ static void batch_obj_del(struct nft_handle *h, struct obj_update *o)
 	case NFT_COMPAT_RULE_APPEND:
 	case NFT_COMPAT_RULE_INSERT:
 	case NFT_COMPAT_RULE_REPLACE:
-	case NFT_COMPAT_RULE_DELETE:
 		break;
+	case NFT_COMPAT_RULE_DELETE:
 	case NFT_COMPAT_RULE_FLUSH:
 		nftnl_rule_free(o->rule);
 		break;
-- 
2.25.1

