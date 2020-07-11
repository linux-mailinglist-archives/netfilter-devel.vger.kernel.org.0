Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 793B721C3AD
	for <lists+netfilter-devel@lfdr.de>; Sat, 11 Jul 2020 12:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGKKTg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 11 Jul 2020 06:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgGKKTg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 11 Jul 2020 06:19:36 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E630C08C5DD
        for <netfilter-devel@vger.kernel.org>; Sat, 11 Jul 2020 03:19:36 -0700 (PDT)
Received: from localhost ([::1]:59466 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1juCbW-0007H6-F0; Sat, 11 Jul 2020 12:19:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 04/18] nft: Drop pointless nft_xt_builtin_init() call
Date:   Sat, 11 Jul 2020 12:18:17 +0200
Message-Id: <20200711101831.29506-5-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200711101831.29506-1-phil@nwl.cc>
References: <20200711101831.29506-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When renaming a chain, either everything is in place already or the
command will bail anyway. So just drop this superfluous call.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 52ee809b6bc07..e3811f5fb20b0 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1937,8 +1937,6 @@ int nft_chain_user_rename(struct nft_handle *h,const char *chain,
 		return 0;
 	}
 
-	nft_xt_builtin_init(h, table);
-
 	/* Config load changed errno. Ensure genuine info for our callers. */
 	errno = 0;
 
-- 
2.27.0

