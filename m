Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29404398E7E
	for <lists+netfilter-devel@lfdr.de>; Wed,  2 Jun 2021 17:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbhFBPZ4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 2 Jun 2021 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhFBPZ4 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 2 Jun 2021 11:25:56 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F10C061574
        for <netfilter-devel@vger.kernel.org>; Wed,  2 Jun 2021 08:24:13 -0700 (PDT)
Received: from localhost ([::1]:43086 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1loSj5-0007OA-Sx; Wed, 02 Jun 2021 17:24:11 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/9] libxtables: Drop leftover variable in xtables_numeric_to_ip6addr()
Date:   Wed,  2 Jun 2021 17:23:55 +0200
Message-Id: <20210602152403.5689-2-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210602152403.5689-1-phil@nwl.cc>
References: <20210602152403.5689-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Variable 'err' was only used in removed debug code, so drop it as well.

Fixes: 7f526c9373c17 ("libxtables: xtables: remove unnecessary debug code")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 libxtables/xtables.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/libxtables/xtables.c b/libxtables/xtables.c
index e6edfb5b49464..82815cae70576 100644
--- a/libxtables/xtables.c
+++ b/libxtables/xtables.c
@@ -1808,9 +1808,8 @@ const char *xtables_ip6mask_to_numeric(const struct in6_addr *addrp)
 struct in6_addr *xtables_numeric_to_ip6addr(const char *num)
 {
 	static struct in6_addr ap;
-	int err;
 
-	if ((err = inet_pton(AF_INET6, num, &ap)) == 1)
+	if (inet_pton(AF_INET6, num, &ap) == 1)
 		return &ap;
 
 	return NULL;
-- 
2.31.1

