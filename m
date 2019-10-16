Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41863DA1E5
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 01:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395225AbfJPXDt (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 19:03:49 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40208 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfJPXDt (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:03:49 -0400
Received: from localhost ([::1]:53298 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKsKZ-0005fF-TQ; Thu, 17 Oct 2019 01:03:47 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/4] monitor: Add missing newline to error message
Date:   Thu, 17 Oct 2019 01:03:19 +0200
Message-Id: <20191016230322.24432-2-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016230322.24432-1-phil@nwl.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These shouldn't happen in practice and printing to stderr is not the
right thing either, but fix this anyway.

Fixes: f9563c0feb24d ("src: add events reporting")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/monitor.c b/src/monitor.c
index 40c381149cdaa..20810a5de0cfb 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -388,7 +388,7 @@ static int netlink_events_setelem_cb(const struct nlmsghdr *nlh, int type,
 
 	set = set_lookup_global(family, table, setname, &monh->ctx->nft->cache);
 	if (set == NULL) {
-		fprintf(stderr, "W: Received event for an unknown set.");
+		fprintf(stderr, "W: Received event for an unknown set.\n");
 		goto out;
 	}
 
-- 
2.23.0

