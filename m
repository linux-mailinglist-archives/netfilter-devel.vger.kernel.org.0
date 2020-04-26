Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E178B1B9092
	for <lists+netfilter-devel@lfdr.de>; Sun, 26 Apr 2020 15:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgDZNYq (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 26 Apr 2020 09:24:46 -0400
Received: from correo.us.es ([193.147.175.20]:42940 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726342AbgDZNYQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:24:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id B3F311BFA8B
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Apr 2020 15:24:13 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9080BB7FFC
        for <netfilter-devel@vger.kernel.org>; Sun, 26 Apr 2020 15:24:13 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2DBE3B8008; Sun, 26 Apr 2020 15:24:03 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id E4A19BAC2F;
        Sun, 26 Apr 2020 15:24:01 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 26 Apr 2020 15:24:01 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id C8A2F42EF4E2;
        Sun, 26 Apr 2020 15:24:01 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     duncan_roe@optusnet.com.au
Subject: [PATCH libnetfilter_queue 2/3] example: nf-queue: use pkt_buff
Date:   Sun, 26 Apr 2020 15:23:55 +0200
Message-Id: <20200426132356.8346-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200426132356.8346-1-pablo@netfilter.org>
References: <20200426132356.8346-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Update example file to use the pkt_buff structure to store the payload.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 examples/nf-queue.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/examples/nf-queue.c b/examples/nf-queue.c
index 3da2c249da23..f0d4c2ee7276 100644
--- a/examples/nf-queue.c
+++ b/examples/nf-queue.c
@@ -14,6 +14,7 @@
 #include <linux/netfilter/nfnetlink_queue.h>
 
 #include <libnetfilter_queue/libnetfilter_queue.h>
+#include <libnetfilter_queue/pktbuff.h>
 
 /* only for NFQA_CT, not needed otherwise: */
 #include <linux/netfilter/nfnetlink_conntrack.h>
@@ -50,9 +51,12 @@ static int queue_cb(const struct nlmsghdr *nlh, void *data)
 {
 	struct nfqnl_msg_packet_hdr *ph = NULL;
 	struct nlattr *attr[NFQA_MAX+1] = {};
+	struct pkt_buff *pktb = data;
 	uint32_t id = 0, skbinfo;
 	struct nfgenmsg *nfg;
+	uint8_t *payload;
 	uint16_t plen;
+	int i;
 
 	if (nfq_nlmsg_parse(nlh, attr) < 0) {
 		perror("problems parsing");
@@ -69,7 +73,8 @@ static int queue_cb(const struct nlmsghdr *nlh, void *data)
 	ph = mnl_attr_get_payload(attr[NFQA_PACKET_HDR]);
 
 	plen = mnl_attr_get_payload_len(attr[NFQA_PAYLOAD]);
-	/* void *payload = mnl_attr_get_payload(attr[NFQA_PAYLOAD]); */
+
+	pktb_build_data(pktb, mnl_attr_get_payload(attr[NFQA_PAYLOAD]), plen);
 
 	skbinfo = attr[NFQA_SKB_INFO] ? ntohl(mnl_attr_get_u32(attr[NFQA_SKB_INFO])) : 0;
 
@@ -97,6 +102,14 @@ static int queue_cb(const struct nlmsghdr *nlh, void *data)
 		printf(", checksum not ready");
 	puts(")");
 
+	printf("payload (len=%d) [", plen);
+	payload = pktb_data(pktb);
+
+	for (i = 0; i < pktb_len(pktb); i++)
+		printf("%x", payload[i] & 0xff);
+
+	printf("]\n");
+
 	nfq_send_verdict(ntohs(nfg->res_id), id);
 
 	return MNL_CB_OK;
@@ -107,6 +120,7 @@ int main(int argc, char *argv[])
 	char *buf;
 	/* largest possible packet payload, plus netlink data overhead: */
 	size_t sizeof_buf = 0xffff + (MNL_SOCKET_BUFFER_SIZE/2);
+	struct pkt_buff *pktb;
 	struct nlmsghdr *nlh;
 	int ret;
 	unsigned int portid, queue_num;
@@ -161,6 +175,12 @@ int main(int argc, char *argv[])
 	ret = 1;
 	mnl_socket_setsockopt(nl, NETLINK_NO_ENOBUFS, &ret, sizeof(int));
 
+	pktb = pktb_alloc_head();
+	if (!pktb) {
+		perror("pktb_alloc");
+		exit(EXIT_FAILURE);
+	}
+
 	for (;;) {
 		ret = mnl_socket_recvfrom(nl, buf, sizeof_buf);
 		if (ret == -1) {
@@ -168,13 +188,14 @@ int main(int argc, char *argv[])
 			exit(EXIT_FAILURE);
 		}
 
-		ret = mnl_cb_run(buf, ret, 0, portid, queue_cb, NULL);
+		ret = mnl_cb_run(buf, ret, 0, portid, queue_cb, pktb);
 		if (ret < 0){
 			perror("mnl_cb_run");
 			exit(EXIT_FAILURE);
 		}
 	}
 
+	pktb_free(pktb);
 	mnl_socket_close(nl);
 
 	return 0;
-- 
2.20.1

