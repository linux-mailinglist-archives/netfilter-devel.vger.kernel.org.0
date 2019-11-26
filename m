Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA3F1109C44
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 Nov 2019 11:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbfKZK0A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 26 Nov 2019 05:26:00 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:45265 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727831AbfKZK0A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 26 Nov 2019 05:26:00 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 610495EA4FA
        for <netfilter-devel@vger.kernel.org>; Tue, 26 Nov 2019 21:25:47 +1100 (AEDT)
Received: (qmail 6862 invoked by uid 501); 26 Nov 2019 10:25:46 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue v2] src: Delete code not needed since Linux 3.8 in examples/nf-queue.c
Date:   Tue, 26 Nov 2019 21:25:46 +1100
Message-Id: <20191126102546.6751-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191125211059.b2k7e52cgllyk53x@salvia>
References: <20191125211059.b2k7e52cgllyk53x@salvia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=vNVEUF_xQQuxJVIZdzwA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The removed code sent configuration commands NFQNL_CFG_CMD_PF_UNBIND &
NFQNL_CFG_CMD_PF_BIND which the kernel required prior to 3.8.

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 examples/nf-queue.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/examples/nf-queue.c b/examples/nf-queue.c
index f6d254a..960e244 100644
--- a/examples/nf-queue.c
+++ b/examples/nf-queue.c
@@ -150,23 +150,6 @@ int main(int argc, char *argv[])
 		exit(EXIT_FAILURE);
 	}
 
-	/* PF_(UN)BIND is not needed with kernels 3.8 and later */
-	nlh = nfq_hdr_put(buf, NFQNL_MSG_CONFIG, 0);
-	nfq_nlmsg_cfg_put_cmd(nlh, AF_INET, NFQNL_CFG_CMD_PF_UNBIND);
-
-	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
-		perror("mnl_socket_send");
-		exit(EXIT_FAILURE);
-	}
-
-	nlh = nfq_hdr_put(buf, NFQNL_MSG_CONFIG, 0);
-	nfq_nlmsg_cfg_put_cmd(nlh, AF_INET, NFQNL_CFG_CMD_PF_BIND);
-
-	if (mnl_socket_sendto(nl, nlh, nlh->nlmsg_len) < 0) {
-		perror("mnl_socket_send");
-		exit(EXIT_FAILURE);
-	}
-
 	nlh = nfq_hdr_put(buf, NFQNL_MSG_CONFIG, queue_num);
 	nfq_nlmsg_cfg_put_cmd(nlh, AF_INET, NFQNL_CFG_CMD_BIND);
 
-- 
2.14.5

