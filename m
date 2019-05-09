Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 492E818915
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 May 2019 13:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfEILf4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 9 May 2019 07:35:56 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35032 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726054AbfEILf4 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 9 May 2019 07:35:56 -0400
Received: from localhost ([::1]:48122 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hOhL7-0000cB-I8; Thu, 09 May 2019 13:35:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 3/9] netlink: Fix printing of zero-length prefixes
Date:   Thu,  9 May 2019 13:35:39 +0200
Message-Id: <20190509113545.4017-4-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190509113545.4017-1-phil@nwl.cc>
References: <20190509113545.4017-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When delinearizing, an all-zero mask didn't qualify as prefix. Therefore
a statement:

| ip daddr 0.0.0.0/0

would be printed as:

| ip daddr & 0.0.0.0 == 0.0.0.0

To fix this, expr_mask_is_prefix() must return true if the initial 1-bit
search fails (the given value must be zero in this case). Additionally,
a shortcut is needed in conversion algorithm of expr_mask_to_prefix()
to not turn the zero prefix into a 1 by accident.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink_delinearize.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/netlink_delinearize.c b/src/netlink_delinearize.c
index 2c9b0a32a932e..c018e78b02925 100644
--- a/src/netlink_delinearize.c
+++ b/src/netlink_delinearize.c
@@ -1734,6 +1734,8 @@ static unsigned int expr_mask_to_prefix(const struct expr *expr)
 	unsigned long n;
 
 	n = mpz_scan1(expr->value, 0);
+	if (n == ULONG_MAX)
+		return 0;
 	return mpz_scan0(expr->value, n + 1) - n;
 }
 
@@ -1744,7 +1746,7 @@ static bool expr_mask_is_prefix(const struct expr *expr)
 
 	n1 = mpz_scan1(expr->value, 0);
 	if (n1 == ULONG_MAX)
-		return false;
+		return true;
 	n2 = mpz_scan0(expr->value, n1 + 1);
 	if (n2 < expr->len || n2 == ULONG_MAX)
 		return false;
-- 
2.21.0

