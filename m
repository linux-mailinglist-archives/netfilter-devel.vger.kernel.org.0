Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70AFD3A46A5
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbhFKQnE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQnD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:03 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E93C061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:05 -0700 (PDT)
Received: from localhost ([::1]:41318 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDQ-0005cc-7A; Fri, 11 Jun 2021 18:41:04 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 06/10] netlink: Avoid memleak in error path of netlink_delinearize_chain()
Date:   Fri, 11 Jun 2021 18:41:00 +0200
Message-Id: <20210611164104.8121-7-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If parsing udata fails, 'chain' has to be freed before returning to
caller.

Fixes: 702ac2b72c0e8 ("src: add comment support for chains")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netlink.c b/src/netlink.c
index 41cce3379ca50..1bbdf98bd2ee2 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -599,6 +599,7 @@ struct chain *netlink_delinearize_chain(struct netlink_ctx *ctx,
 		udata = nftnl_chain_get_data(nlc, NFTNL_CHAIN_USERDATA, &ulen);
 		if (nftnl_udata_parse(udata, ulen, chain_parse_udata_cb, ud) < 0) {
 			netlink_io_error(ctx, NULL, "Cannot parse userdata");
+			chain_free(chain);
 			return NULL;
 		}
 		if (ud[NFTNL_UDATA_CHAIN_COMMENT])
-- 
2.31.1

