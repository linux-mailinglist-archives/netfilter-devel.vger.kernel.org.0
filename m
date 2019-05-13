Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B75B11BB08
	for <lists+netfilter-devel@lfdr.de>; Mon, 13 May 2019 18:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfEMQch (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 13 May 2019 12:32:37 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45956 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbfEMQch (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 13 May 2019 12:32:37 -0400
Received: from localhost ([::1]:59046 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hQDsR-00058y-7X; Mon, 13 May 2019 18:32:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xtables: Fix for explicit rule flushes
Date:   Mon, 13 May 2019 18:32:37 +0200
Message-Id: <20190513163237.4656-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The commit this fixes added a new parameter to __nft_rule_flush() to
mark a rule flush job as implicit or not. Yet the code added to that
function ignores the parameter and instead always sets batch job's
'implicit' flag to 1.

Fixes: 77e6a93d5c9dc ("xtables: add and set "implict" flag on transaction objects")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 3e8f2d501d0c5..f25ab032712fc 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -1698,7 +1698,7 @@ __nft_rule_flush(struct nft_handle *h, const char *table,
 		return;
 	}
 
-	obj->implicit = 1;
+	obj->implicit = implicit;
 }
 
 int nft_rule_flush(struct nft_handle *h, const char *chain, const char *table,
-- 
2.21.0

