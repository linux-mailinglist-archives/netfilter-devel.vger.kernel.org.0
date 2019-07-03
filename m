Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5355DEF7
	for <lists+netfilter-devel@lfdr.de>; Wed,  3 Jul 2019 09:36:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfGCHgg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 3 Jul 2019 03:36:36 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45458 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726327AbfGCHgg (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 3 Jul 2019 03:36:36 -0400
Received: from localhost ([::1]:58548 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hiZoh-0003PU-2D; Wed, 03 Jul 2019 09:36:35 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 1/2] nft: Pass nft_handle down to mnl_batch_talk()
Date:   Wed,  3 Jul 2019 09:36:25 +0200
Message-Id: <20190703073626.18915-1-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From there, pass it along to mnl_nft_socket_sendmsg() and further down
to mnl_set_{snd,rcv}buffer(). This prepares the code path for keeping
stored socket buffer sizes in struct nft_handle.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c | 41 ++++++++++++++++++-----------------------
 1 file changed, 18 insertions(+), 23 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 3aa2c6c6b9166..4a5280916e3b1 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -188,18 +188,15 @@ static void mnl_err_list_free(struct mnl_err *err)
 
 static int nlbuffsiz;
 
-static void mnl_set_sndbuffer(const struct mnl_socket *nl,
-			      struct nftnl_batch *batch)
+static void mnl_set_sndbuffer(struct nft_handle *h)
 {
-	int newbuffsiz;
+	int newbuffsiz = nftnl_batch_iovec_len(h->batch) * BATCH_PAGE_SIZE;
 
-	if (nftnl_batch_iovec_len(batch) * BATCH_PAGE_SIZE <= nlbuffsiz)
+	if (newbuffsiz <= nlbuffsiz)
 		return;
 
-	newbuffsiz = nftnl_batch_iovec_len(batch) * BATCH_PAGE_SIZE;
-
 	/* Rise sender buffer length to avoid hitting -EMSGSIZE */
-	if (setsockopt(mnl_socket_get_fd(nl), SOL_SOCKET, SO_SNDBUFFORCE,
+	if (setsockopt(mnl_socket_get_fd(h->nl), SOL_SOCKET, SO_SNDBUFFORCE,
 		       &newbuffsiz, sizeof(socklen_t)) < 0)
 		return;
 
@@ -208,27 +205,26 @@ static void mnl_set_sndbuffer(const struct mnl_socket *nl,
 
 static int nlrcvbuffsiz;
 
-static void mnl_set_rcvbuffer(const struct mnl_socket *nl, int numcmds)
+static void mnl_set_rcvbuffer(struct nft_handle *h, int numcmds)
 {
 	int newbuffsiz = getpagesize() * numcmds;
 
 	if (newbuffsiz <= nlrcvbuffsiz)
 		return;
 
-	if (setsockopt(mnl_socket_get_fd(nl), SOL_SOCKET, SO_RCVBUFFORCE,
+	if (setsockopt(mnl_socket_get_fd(h->nl), SOL_SOCKET, SO_RCVBUFFORCE,
 		       &newbuffsiz, sizeof(socklen_t)) < 0)
 		return;
 
 	nlrcvbuffsiz = newbuffsiz;
 }
 
-static ssize_t mnl_nft_socket_sendmsg(const struct mnl_socket *nf_sock,
-				      struct nftnl_batch *batch, int numcmds)
+static ssize_t mnl_nft_socket_sendmsg(struct nft_handle *h, int numcmds)
 {
 	static const struct sockaddr_nl snl = {
 		.nl_family = AF_NETLINK
 	};
-	uint32_t iov_len = nftnl_batch_iovec_len(batch);
+	uint32_t iov_len = nftnl_batch_iovec_len(h->batch);
 	struct iovec iov[iov_len];
 	struct msghdr msg = {
 		.msg_name	= (struct sockaddr *) &snl,
@@ -237,18 +233,16 @@ static ssize_t mnl_nft_socket_sendmsg(const struct mnl_socket *nf_sock,
 		.msg_iovlen	= iov_len,
 	};
 
-	mnl_set_sndbuffer(nf_sock, batch);
-	mnl_set_rcvbuffer(nf_sock, numcmds);
-	nftnl_batch_iovec(batch, iov, iov_len);
+	mnl_set_sndbuffer(h);
+	mnl_set_rcvbuffer(h, numcmds);
+	nftnl_batch_iovec(h->batch, iov, iov_len);
 
-	return sendmsg(mnl_socket_get_fd(nf_sock), &msg, 0);
+	return sendmsg(mnl_socket_get_fd(h->nl), &msg, 0);
 }
 
-static int mnl_batch_talk(const struct mnl_socket *nf_sock,
-			  struct nftnl_batch *batch, int numcmds,
-			  struct list_head *err_list)
+static int mnl_batch_talk(struct nft_handle *h, int numcmds)
 {
-	const struct mnl_socket *nl = nf_sock;
+	const struct mnl_socket *nl = h->nl;
 	int ret, fd = mnl_socket_get_fd(nl), portid = mnl_socket_get_portid(nl);
 	char rcv_buf[MNL_SOCKET_BUFFER_SIZE];
 	fd_set readfds;
@@ -258,7 +252,7 @@ static int mnl_batch_talk(const struct mnl_socket *nf_sock,
 	};
 	int err = 0;
 
-	ret = mnl_nft_socket_sendmsg(nf_sock, batch, numcmds);
+	ret = mnl_nft_socket_sendmsg(h, numcmds);
 	if (ret == -1)
 		return -1;
 
@@ -280,7 +274,8 @@ static int mnl_batch_talk(const struct mnl_socket *nf_sock,
 		ret = mnl_cb_run(rcv_buf, ret, 0, portid, NULL, NULL);
 		/* Continue on error, make sure we get all acknowledgments */
 		if (ret == -1) {
-			mnl_err_list_node_add(err_list, errno, nlh->nlmsg_seq);
+			mnl_err_list_node_add(&h->err_list, errno,
+					      nlh->nlmsg_seq);
 			err = -1;
 		}
 
@@ -2936,7 +2931,7 @@ retry:
 	}
 
 	errno = 0;
-	ret = mnl_batch_talk(h->nl, h->batch, seq, &h->err_list);
+	ret = mnl_batch_talk(h, seq);
 	if (ret && errno == ERESTART) {
 		nft_rebuild_cache(h);
 
-- 
2.21.0

