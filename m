Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5BB81CBFA7
	for <lists+netfilter-devel@lfdr.de>; Sat,  9 May 2020 11:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgEIJLw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 9 May 2020 05:11:52 -0400
Received: from correo.us.es ([193.147.175.20]:52066 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgEIJLw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 9 May 2020 05:11:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 6037A4DE735
        for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2020 11:11:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 52688115408
        for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2020 11:11:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 47D9B115409; Sat,  9 May 2020 11:11:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6237F1158E2
        for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2020 11:11:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sat, 09 May 2020 11:11:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 4E09F42EF4E2
        for <netfilter-devel@vger.kernel.org>; Sat,  9 May 2020 11:11:49 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 2/2] pktbuff: add pktb_head_alloc(), pktb_setup() and pktb_head_size()
Date:   Sat,  9 May 2020 11:11:41 +0200
Message-Id: <20200509091141.10619-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200509091141.10619-1-pablo@netfilter.org>
References: <20200509091141.10619-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add two new helper functions, as alternative to pktb_alloc().

* pktb_setup() allows you to skip memcpy()'ing the payload from the
  netlink message.

* pktb_head_size() returns the size of the pkt_buff opaque object.

* pktb_head_alloc() allows you to allocate the pkt_buff in the heap.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/libnetfilter_queue/pktbuff.h |  7 +++++++
 src/extra/pktbuff.c                  | 20 ++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/libnetfilter_queue/pktbuff.h b/include/libnetfilter_queue/pktbuff.h
index 42bc153ec337..a27582b02840 100644
--- a/include/libnetfilter_queue/pktbuff.h
+++ b/include/libnetfilter_queue/pktbuff.h
@@ -6,6 +6,13 @@ struct pkt_buff;
 struct pkt_buff *pktb_alloc(int family, void *data, size_t len, size_t extra);
 void pktb_free(struct pkt_buff *pktb);
 
+#define NFQ_BUFFER_SIZE	(0xffff + (MNL_SOCKET_BUFFER_SIZE / 2)
+struct pkt_buff *pktb_setup(struct pkt_buff *pktb, int family, uint8_t *data,
+			    size_t len, size_t extra);
+size_t pktb_head_size(void);
+
+#define pktb_head_alloc()	(struct pkt_buff *)(malloc(pktb_head_size()))
+
 uint8_t *pktb_data(struct pkt_buff *pktb);
 uint32_t pktb_len(struct pkt_buff *pktb);
 
diff --git a/src/extra/pktbuff.c b/src/extra/pktbuff.c
index 118ad898f63b..6acefbe72a9b 100644
--- a/src/extra/pktbuff.c
+++ b/src/extra/pktbuff.c
@@ -103,6 +103,26 @@ struct pkt_buff *pktb_alloc(int family, void *data, size_t len, size_t extra)
 	return pktb;
 }
 
+EXPORT_SYMBOL
+struct pkt_buff *pktb_setup(struct pkt_buff *pktb, int family, uint8_t *buf,
+			    size_t len, size_t extra)
+{
+	pktb->data_len = len + extra;
+	pktb->data = buf;
+	pktb->len = len;
+
+	if (__pktb_setup(family, pktb) < 0)
+		return NULL;
+
+	return pktb;
+}
+
+EXPORT_SYMBOL
+size_t pktb_head_size(void)
+{
+	return sizeof(struct pkt_buff);
+}
+
 /**
  * pktb_data - get pointer to network packet
  * \param pktb Pointer to userspace packet buffer
-- 
2.20.1

