Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 07CB81943EB
	for <lists+netfilter-devel@lfdr.de>; Thu, 26 Mar 2020 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgCZQAd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 26 Mar 2020 12:00:33 -0400
Received: from fourcot.fr ([217.70.191.14]:54044 "EHLO olfflo.fourcot.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727916AbgCZQAd (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:00:33 -0400
X-Greylist: delayed 415 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2020 12:00:32 EDT
From:   Romain Bellan <romain.bellan@wifirst.fr>
To:     netfilter-devel@vger.kernel.org
Cc:     Romain Bellan <romain.bellan@wifirst.fr>,
        Florent Fourcot <florent.fourcot@wifirst.fr>
Subject: [PATCH nf-next v3 2/2] netfilter: ctnetlink: be more strict when NF_CONNTRACK_MARK is not set
Date:   Thu, 26 Mar 2020 16:53:13 +0100
Message-Id: <20200326155313.8417-2-romain.bellan@wifirst.fr>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200326155313.8417-1-romain.bellan@wifirst.fr>
References: <20200326155313.8417-1-romain.bellan@wifirst.fr>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When CONFIG_NF_CONNTRACK_MARK is not set, any CTA_MARK or CTA_MARK_MASK
in netlink message are not supported. We should return an error when one
of them is set, not both

Fixes: 9306425b70bf ("netfilter: ctnetlink: must check mark attributes vs NULL")
Signed-off-by: Romain Bellan <romain.bellan@wifirst.fr>
Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
---
 net/netfilter/nf_conntrack_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index e8fdfe0febee..c5eb57f3148e 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -919,7 +919,7 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 	int err;
 
 #ifndef CONFIG_NF_CONNTRACK_MARK
-	if (cda[CTA_MARK] && cda[CTA_MARK_MASK])
+	if (cda[CTA_MARK] || cda[CTA_MARK_MASK])
 		return ERR_PTR(-EOPNOTSUPP);
 #endif
 
-- 
2.20.1

