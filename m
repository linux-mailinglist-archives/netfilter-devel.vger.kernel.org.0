Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15F4410F5B
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 May 2019 00:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfEAWuv (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 1 May 2019 18:50:51 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:46695 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726126AbfEAWuv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 1 May 2019 18:50:51 -0400
X-Greylist: delayed 1500 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 May 2019 18:50:51 EDT
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id E6A3E7409
        for <netfilter-devel@vger.kernel.org>; Wed,  1 May 2019 17:01:14 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id LxHuh5DFGiQerLxHuhksTO; Wed, 01 May 2019 17:01:14 -0500
X-Authority-Reason: nr=8
Received: from [189.250.119.203] (port=58416 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.91)
        (envelope-from <gustavo@embeddedor.com>)
        id 1hLxHr-000EDy-Su; Wed, 01 May 2019 17:01:11 -0500
Date:   Wed, 1 May 2019 17:01:08 -0500
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>,
        Florian Westphal <fw@strlen.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] netfilter: xt_hashlimit: use struct_size() helper
Message-ID: <20190501220108.GA30487@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.250.119.203
X-Source-L: No
X-Exim-ID: 1hLxHr-000EDy-Su
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.250.119.203]:58416
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes, in particular in the
context in which this code is being used.

So, replace code of the following form:

sizeof(struct xt_hashlimit_htable) + sizeof(struct hlist_head) * size

with:

struct_size(hinfo, hash, size)

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 net/netfilter/xt_hashlimit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
index 8d86e39d6280..a30536b17ee1 100644
--- a/net/netfilter/xt_hashlimit.c
+++ b/net/netfilter/xt_hashlimit.c
@@ -288,8 +288,7 @@ static int htable_create(struct net *net, struct hashlimit_cfg3 *cfg,
 			size = 16;
 	}
 	/* FIXME: don't use vmalloc() here or anywhere else -HW */
-	hinfo = vmalloc(sizeof(struct xt_hashlimit_htable) +
-	                sizeof(struct hlist_head) * size);
+	hinfo = vmalloc(struct_size(hinfo, hash, size));
 	if (hinfo == NULL)
 		return -ENOMEM;
 	*out_hinfo = hinfo;
-- 
2.21.0

