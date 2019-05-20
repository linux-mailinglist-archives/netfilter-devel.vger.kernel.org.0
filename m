Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19314240E7
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2019 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725941AbfETTIf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 May 2019 15:08:35 -0400
Received: from mail.us.es ([193.147.175.20]:38442 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbfETTIf (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 May 2019 15:08:35 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id F2CAABAEEB
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:33 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id DC3CADA70F
        for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2019 21:08:33 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id C63FCDA70B; Mon, 20 May 2019 21:08:33 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id CE85DDA701;
        Mon, 20 May 2019 21:08:31 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 20 May 2019 21:08:31 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 9DC954265A32;
        Mon, 20 May 2019 21:08:31 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH iptables 6/6] nft: reset netlink sender buffer size of socket restart
Date:   Mon, 20 May 2019 21:08:22 +0200
Message-Id: <20190520190822.18873-7-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190520190822.18873-1-pablo@netfilter.org>
References: <20190520190822.18873-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Otherwise, mnl_set_sndbuffer() skips the buffer update after socket
restart. Then, sendmsg() fails with EMSGSIZE later on when sending the
batch to the kernel.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/nft.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/iptables/nft.c b/iptables/nft.c
index 9a3e9fdf4f12..2c61521455de 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -794,6 +794,7 @@ static int nft_restart(struct nft_handle *h)
 		return -1;
 
 	h->portid = mnl_socket_get_portid(h->nl);
+	nlbuffsiz = 0;
 
 	return 0;
 }
-- 
2.11.0

