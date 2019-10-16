Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 61DE4DA1E3
	for <lists+netfilter-devel@lfdr.de>; Thu, 17 Oct 2019 01:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731956AbfJPXDi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 16 Oct 2019 19:03:38 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40196 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731616AbfJPXDi (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 16 Oct 2019 19:03:38 -0400
Received: from localhost ([::1]:53286 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iKsKP-0005eV-0R; Thu, 17 Oct 2019 01:03:37 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/4] Revert "monitor: fix double cache update with --echo"
Date:   Thu, 17 Oct 2019 01:03:20 +0200
Message-Id: <20191016230322.24432-3-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191016230322.24432-1-phil@nwl.cc>
References: <20191016230322.24432-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This reverts commit 9b032cd6477b847f48dc8454f0e73935e9f48754.

While it is true that a cache exists, we still need to capture new sets
and their elements if they are anonymous. This is because the name
changes and rules will refer to them by name.

Given that there is no easy way to identify the anonymous set in cache
(kernel doesn't (and shouldn't) dump SET_ID value) to update its name,
just go with cache updates. Assuming that echo option is typically used
for single commands, there is not much cache updating happening anyway.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/monitor.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/monitor.c b/src/monitor.c
index 20810a5de0cfb..f353c5b09cf5d 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -900,6 +900,7 @@ int netlink_echo_callback(const struct nlmsghdr *nlh, void *data)
 		.ctx = ctx,
 		.loc = &netlink_location,
 		.monitor_flags = 0xffffffff,
+		.cache_needed = true,
 	};
 
 	if (!nft_output_echo(&echo_monh.ctx->nft->output))
-- 
2.23.0

