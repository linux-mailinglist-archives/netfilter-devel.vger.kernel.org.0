Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 907201ECCDC
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jun 2020 11:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgFCJok (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jun 2020 05:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726482AbgFCJok (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jun 2020 05:44:40 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6A58C05BD43
        for <netfilter-devel@vger.kernel.org>; Wed,  3 Jun 2020 02:44:39 -0700 (PDT)
Received: from localhost ([::1]:41078 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1jgPwq-0007pY-7w; Wed, 03 Jun 2020 11:44:36 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] build: bump dependency on libnftnl
Date:   Wed,  3 Jun 2020 11:44:27 +0200
Message-Id: <20200603094427.26317-1-phil@nwl.cc>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Recently added full among match support depends on concatenated ranges
in nftables sets, a feature which was not available in libnftnl before
version 1.1.6.

Fixes: c33bae9c6c7a4 ("ebtables: among: Support mixed MAC and MAC/IP entries")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 02f6481ca52ed..d2f63694e7f58 100644
--- a/configure.ac
+++ b/configure.ac
@@ -131,7 +131,7 @@ if test "x$enable_nftables" = "xyes"; then
 		exit 1
 	fi
 
-	PKG_CHECK_MODULES([libnftnl], [libnftnl >= 1.1.5], [nftables=1], [nftables=0])
+	PKG_CHECK_MODULES([libnftnl], [libnftnl >= 1.1.6], [nftables=1], [nftables=0])
 
 	if test "$nftables" = 0;
 	then
-- 
2.26.2

