Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D66444ADD
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Nov 2021 23:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230168AbhKCWdJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Nov 2021 18:33:09 -0400
Received: from fourcot.fr ([217.70.191.14]:52500 "EHLO olfflo.fourcot.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229728AbhKCWdJ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Nov 2021 18:33:09 -0400
X-Greylist: delayed 502 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Nov 2021 18:33:09 EDT
From:   Florent Fourcot <florent.fourcot@wifirst.fr>
To:     netfilter-devel@vger.kernel.org
Cc:     Florent Fourcot <florent.fourcot@wifirst.fr>
Subject: [PATCH nf] netfilter: ctnetlink: fix filtering with CTA_TUPLE_REPLY
Date:   Wed,  3 Nov 2021 23:21:54 +0100
Message-Id: <20211103222155.17981-1-florent.fourcot@wifirst.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

filter->orig_flags was used for a reply context.

Signed-off-by: Florent Fourcot <florent.fourcot@wifirst.fr>
Fixes: cb8aa9a3affb ("netfilter: ctnetlink: add kernel side filtering for dump")
---
 net/netfilter/nf_conntrack_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index f1e5443fe7c7..2663764d0b6e 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -1011,7 +1011,7 @@ ctnetlink_alloc_filter(const struct nlattr * const cda[], u8 family)
 						   CTA_TUPLE_REPLY,
 						   filter->family,
 						   &filter->zone,
-						   filter->orig_flags);
+						   filter->reply_flags);
 		if (err < 0) {
 			err = -EINVAL;
 			goto err_filter;
-- 
2.20.1

