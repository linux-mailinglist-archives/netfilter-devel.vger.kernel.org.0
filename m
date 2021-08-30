Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5523FBEA0
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Aug 2021 23:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238554AbhH3V6n (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Aug 2021 17:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhH3V6m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Aug 2021 17:58:42 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC2DC061575
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Aug 2021 14:57:48 -0700 (PDT)
Received: from localhost ([::1]:33744 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1mKpHm-0006dJ-E8; Mon, 30 Aug 2021 23:57:46 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org,
        =?UTF-8?q?Adam=20W=C3=B3jcik?= <a.wojcik@hyp.home.pl>
Subject: [iptables PATCH] extensions: libxt_mac: Fix for missing space in listing
Date:   Mon, 30 Aug 2021 23:58:17 +0200
Message-Id: <20210830215817.4114-1-phil@nwl.cc>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Listing the extension using 'iptables -L', there was no space between
'MAC' and the following Address.

Reported-by: Adam Wójcik <a.wojcik@hyp.home.pl>
Fixes: 1bdb5535f561a ("libxtables: Extend MAC address printing/parsing support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 extensions/libxt_mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/extensions/libxt_mac.c b/extensions/libxt_mac.c
index b90eef207c98e..55891b2be7104 100644
--- a/extensions/libxt_mac.c
+++ b/extensions/libxt_mac.c
@@ -42,10 +42,10 @@ mac_print(const void *ip, const struct xt_entry_match *match, int numeric)
 {
 	const struct xt_mac_info *info = (void *)match->data;
 
-	printf(" MAC");
+	printf(" MAC ");
 
 	if (info->invert)
-		printf(" !");
+		printf("! ");
 
 	xtables_print_mac(info->srcaddr);
 }
-- 
2.32.0

