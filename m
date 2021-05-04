Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B96372C35
	for <lists+netfilter-devel@lfdr.de>; Tue,  4 May 2021 16:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbhEDOlG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 4 May 2021 10:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbhEDOlG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 4 May 2021 10:41:06 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AAC0C061574
        for <netfilter-devel@vger.kernel.org>; Tue,  4 May 2021 07:40:09 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1ldwDW-0004E8-OZ; Tue, 04 May 2021 16:40:06 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nf] netfilter: conntrack: unregister ipv4 sockopts on error unwind
Date:   Tue,  4 May 2021 16:40:00 +0200
Message-Id: <20210504144000.18155-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When ipv6 sockopt register fails, the ipv4 one needs to be removed.

Fixes: a0ae2562c6c ("netfilter: conntrack: remove l3proto abstraction")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
The should be no confict/overlap with an existing sockopt range,
so I don't think the registration can fail in the first place.

However, its broken as-is.
An alternate solution (in -next), might be to change return type to void
and have nf_register_sockopt WARN() instead.

 net/netfilter/nf_conntrack_proto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_proto.c b/net/netfilter/nf_conntrack_proto.c
index 89e5bac384d7..dc9ca12b0489 100644
--- a/net/netfilter/nf_conntrack_proto.c
+++ b/net/netfilter/nf_conntrack_proto.c
@@ -664,7 +664,7 @@ int nf_conntrack_proto_init(void)
 
 #if IS_ENABLED(CONFIG_IPV6)
 cleanup_sockopt:
-	nf_unregister_sockopt(&so_getorigdst6);
+	nf_unregister_sockopt(&so_getorigdst);
 #endif
 	return ret;
 }
-- 
2.26.3

