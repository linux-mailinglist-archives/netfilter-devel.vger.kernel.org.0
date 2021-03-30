Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74F6D34E163
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Mar 2021 08:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhC3Gmy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 02:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbhC3Gmp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 02:42:45 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27704C061762;
        Mon, 29 Mar 2021 23:42:45 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1lR85J-0002FN-F0; Tue, 30 Mar 2021 08:42:41 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     lvs-devel@vger.kernel.org, ja@ssi.bg, horms@verge.net.au,
        Florian Westphal <fw@strlen.de>
Subject: [PATCH nf-next] netfilter: ipvs: do not printk on netns creation
Date:   Tue, 30 Mar 2021 08:42:32 +0200
Message-Id: <20210330064232.11960-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This causes dmesg spew during normal operation, so remove this.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/ipvs/ip_vs_ftp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/netfilter/ipvs/ip_vs_ftp.c b/net/netfilter/ipvs/ip_vs_ftp.c
index cf925906f59b..ef1f45e43b63 100644
--- a/net/netfilter/ipvs/ip_vs_ftp.c
+++ b/net/netfilter/ipvs/ip_vs_ftp.c
@@ -591,8 +591,6 @@ static int __net_init __ip_vs_ftp_init(struct net *net)
 		ret = register_ip_vs_app_inc(ipvs, app, app->protocol, ports[i]);
 		if (ret)
 			goto err_unreg;
-		pr_info("%s: loaded support on port[%d] = %u\n",
-			app->name, i, ports[i]);
 	}
 	return 0;
 
-- 
2.26.3

