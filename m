Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B138E30FF9
	for <lists+netfilter-devel@lfdr.de>; Fri, 31 May 2019 16:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbfEaORx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 31 May 2019 10:17:53 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45534 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726546AbfEaORx (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 31 May 2019 10:17:53 -0400
Received: from localhost ([::1]:58624 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hWiLv-0000WO-2S; Fri, 31 May 2019 16:17:51 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 2/2] mnl: Simplify mnl_batch_talk()
Date:   Fri, 31 May 2019 16:17:43 +0200
Message-Id: <20190531141743.15049-3-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190531141743.15049-1-phil@nwl.cc>
References: <20190531141743.15049-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

By mimicking mnl_nft_event_listener() code, mnl_batch_talk() may be
simplified quite a bit:

* Turn the conditional loop into an unconditional one.
* Call select() at loop start, which merges the two call sites.
* Check readfds content after select() returned instead of in loop
  condition - if fd is not set, break to return error state stored in
  'err' variable.
* Old code checked that select() return code is > 0, but that was
  redundant: if FD_ISSET() returns true, select return code was 1.
* Move 'nlh' helper variable definition into error handling block, it is
  not used outside of it.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 492d7517d40e2..724decad2e44d 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -278,16 +278,17 @@ int mnl_batch_talk(struct netlink_ctx *ctx, struct list_head *err_list)
 	if (ret == -1)
 		return -1;
 
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
-
 	/* receive and digest all the acknowledgments from the kernel. */
-	ret = select(fd+1, &readfds, NULL, NULL, &tv);
-	if (ret == -1)
-		return -1;
+	while (true) {
+		FD_ZERO(&readfds);
+		FD_SET(fd, &readfds);
+
+		ret = select(fd+1, &readfds, NULL, NULL, &tv);
+		if (ret == -1)
+			return -1;
 
-	while (ret > 0 && FD_ISSET(fd, &readfds)) {
-		struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buf;
+		if (!FD_ISSET(fd, &readfds))
+			break;
 
 		ret = mnl_socket_recvfrom(nl, rcv_buf, sizeof(rcv_buf));
 		if (ret == -1)
@@ -296,16 +297,11 @@ int mnl_batch_talk(struct netlink_ctx *ctx, struct list_head *err_list)
 		ret = mnl_cb_run(rcv_buf, ret, 0, portid, &netlink_echo_callback, ctx);
 		/* Continue on error, make sure we get all acknowledgments */
 		if (ret == -1) {
+			struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buf;
+
 			mnl_err_list_node_add(err_list, errno, nlh->nlmsg_seq);
 			err = -1;
 		}
-
-		FD_ZERO(&readfds);
-		FD_SET(fd, &readfds);
-
-		ret = select(fd+1, &readfds, NULL, NULL, &tv);
-		if (ret == -1)
-			return -1;
 	}
 	return err;
 }
-- 
2.21.0

