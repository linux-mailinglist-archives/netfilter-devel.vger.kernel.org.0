Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A88022FAB7
	for <lists+netfilter-devel@lfdr.de>; Thu, 30 May 2019 13:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfE3LMy (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 30 May 2019 07:12:54 -0400
Received: from mail.us.es ([193.147.175.20]:49206 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725440AbfE3LMy (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 30 May 2019 07:12:54 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 49DEDC04A4
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 13:12:52 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 3B2E4DA706
        for <netfilter-devel@vger.kernel.org>; Thu, 30 May 2019 13:12:52 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3A710DA704; Thu, 30 May 2019 13:12:52 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 20B5FDA704;
        Thu, 30 May 2019 13:12:50 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Thu, 30 May 2019 13:12:50 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id ECC0C4265A31;
        Thu, 30 May 2019 13:12:49 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH nft,v3 2/7] mnl: mnl_set_rcvbuffer() skips buffer size update if it is too small
Date:   Thu, 30 May 2019 13:12:46 +0200
Message-Id: <20190530111246.14550-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Check for existing buffer size, if this is larger than the newer buffer
size, skip this size update.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
v3: 'len' variable was not properly set.

 src/mnl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/mnl.c b/src/mnl.c
index 288a887df097..2270a084ad29 100644
--- a/src/mnl.c
+++ b/src/mnl.c
@@ -235,8 +235,15 @@ static void mnl_set_sndbuffer(const struct mnl_socket *nl,
 
 static int mnl_set_rcvbuffer(const struct mnl_socket *nl, size_t bufsiz)
 {
+	unsigned int cur_bufsiz;
+	socklen_t len = sizeof(cur_bufsiz);
 	int ret;
 
+	ret = getsockopt(mnl_socket_get_fd(nl), SOL_SOCKET, SO_RCVBUF,
+			 &cur_bufsiz, &len);
+	if (cur_bufsiz > bufsiz)
+		return 0;
+
 	ret = setsockopt(mnl_socket_get_fd(nl), SOL_SOCKET, SO_RCVBUFFORCE,
 			 &bufsiz, sizeof(socklen_t));
 	if (ret < 0) {
-- 
2.11.0

