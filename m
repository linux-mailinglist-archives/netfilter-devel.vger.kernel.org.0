Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEE3A46A3
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229753AbhFKQnA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbhFKQm7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:42:59 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305BDC061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:40:55 -0700 (PDT)
Received: from localhost ([::1]:41306 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDF-0005bp-Jk; Fri, 11 Jun 2021 18:40:53 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 08/10] netlink: Avoid memleak in error path of netlink_delinearize_obj()
Date:   Fri, 11 Jun 2021 18:41:02 +0200
Message-Id: <20210611164104.8121-9-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If parsing udata fails, 'obj' has to be freed before returning to
caller.

Fixes: 293c9b114faef ("src: add comment support for objects")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/netlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/netlink.c b/src/netlink.c
index be98bfb7f5c12..f2c1a4a15dee8 100644
--- a/src/netlink.c
+++ b/src/netlink.c
@@ -1450,6 +1450,7 @@ struct obj *netlink_delinearize_obj(struct netlink_ctx *ctx,
 		udata = nftnl_obj_get_data(nlo, NFTNL_OBJ_USERDATA, &ulen);
 		if (nftnl_udata_parse(udata, ulen, obj_parse_udata_cb, ud) < 0) {
 			netlink_io_error(ctx, NULL, "Cannot parse userdata");
+			obj_free(obj);
 			return NULL;
 		}
 		if (ud[NFTNL_UDATA_OBJ_COMMENT])
-- 
2.31.1

