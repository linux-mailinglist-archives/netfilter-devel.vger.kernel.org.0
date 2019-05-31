Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26B4C30FFC
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 16:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfEaOSD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 10:18:03 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45546 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbfEaOSD (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 10:18:03 -0400
Received: from localhost ([::1]:58636 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hWiM5-0000X6-MI; Fri, 31 May 2019 16:18:01 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/2] mnl: Initialize fd_set before select(), not after
Date:   Fri, 31 May 2019 16:17:42 +0200
Message-Id: <20190531141743.15049-2-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531141743.15049-1-phil@nwl.cc>
References: <20190531141743.15049-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Calling FD_SET() in between return of select() and call to FD_ISSET()
effectively renders the whole thing useless: FD_ISSET() will always
return true no matter what select() actually did.

Fixes: a72315d2bad47 ("src: add rule batching support")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index f6363560721c1..492d7517d40e2 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -300,12 +300,12 @@ int mnl_batch_talk(struct netlink_ctx *ctx, struct list_head *err_list)
 			err = -1;
 		}
 
+		FD_ZERO(&readfds);
+		FD_SET(fd, &readfds);
+
 		ret = select(fd+1, &readfds, NULL, NULL, &tv);
 		if (ret == -1)
 			return -1;
-
-		FD_ZERO(&readfds);
-		FD_SET(fd, &readfds);
 	}
 	return err;
 }
-- 
2.21.0

