Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E0812DDCD
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 May 2019 15:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbfE2NOA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 29 May 2019 09:14:00 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40266 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbfE2NOA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 29 May 2019 09:14:00 -0400
Received: from localhost ([::1]:53354 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hVyP0-0006wT-In; Wed, 29 May 2019 15:13:58 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Eric Garver <e@erig.me>
Subject: [nft PATCH 3/4] mnl: Fix and simplify mnl_batch_talk()
Date:   Wed, 29 May 2019 15:13:45 +0200
Message-Id: <20190529131346.23659-4-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190529131346.23659-1-phil@nwl.cc>
References: <20190529131346.23659-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use of select() after the first call to mnl_socket_recvfrom() was
incorrect, FD_SET() was called after the call to select() returned. This
effectively turned the FD_ISSET() check into a noop (always true
condition).

Rewrite the receive loop using mnl_nft_event_listener() as an example:

* Combine the two calls to FD_ZERO(), FD_SET() and select() into one at
  loop start.
* Check ENOBUFS condition and warn the user, also upon other errors.
* Continue on ENOBUFS, it is not a permanent error.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/mnl.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/src/mnl.c b/src/mnl.c
index 06280aa2cb50a..4fbfd059c0228 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -299,34 +299,39 @@ int mnl_batch_talk(struct netlink_ctx *ctx, struct list_head *err_list)
 	if (ret == -1)
 		return -1;
 
-	FD_ZERO(&readfds);
-	FD_SET(fd, &readfds);
+	while (true) {
+		FD_ZERO(&readfds);
+		FD_SET(fd, &readfds);
 
-	/* receive and digest all the acknowledgments from the kernel. */
-	ret = select(fd+1, &readfds, NULL, NULL, &tv);
-	if (ret == -1)
-		return -1;
+		/* receive and digest all the acknowledgments from the kernel. */
+		ret = select(fd + 1, &readfds, NULL, NULL, &tv);
+		if (ret < 0)
+			return -1;
 
-	while (ret > 0 && FD_ISSET(fd, &readfds)) {
-		struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buf;
+		if (!FD_ISSET(fd, &readfds))
+			break;
 
 		ret = mnl_socket_recvfrom(nl, rcv_buf, sizeof(rcv_buf));
-		if (ret == -1)
-			return -1;
+		if (ret < 0) {
+			if (errno == ENOBUFS) {
+				nft_print(&ctx->nft->output,
+					  "# ERROR: We lost some netlink events!\n");
+				continue;
+			}
+			nft_print(&ctx->nft->output, "# ERROR: %s\n",
+				  strerror(errno));
+			err = ret;
+			break;
+		}
 
 		ret = mnl_cb_run(rcv_buf, ret, 0, portid, &netlink_echo_callback, ctx);
 		/* Continue on error, make sure we get all acknowledgments */
 		if (ret == -1) {
+			struct nlmsghdr *nlh = (struct nlmsghdr *)rcv_buf;
+
 			mnl_err_list_node_add(err_list, errno, nlh->nlmsg_seq);
 			err = -1;
 		}
-
-		ret = select(fd+1, &readfds, NULL, NULL, &tv);
-		if (ret == -1)
-			return -1;
-
-		FD_ZERO(&readfds);
-		FD_SET(fd, &readfds);
 	}
 	return err;
 }
-- 
2.21.0

