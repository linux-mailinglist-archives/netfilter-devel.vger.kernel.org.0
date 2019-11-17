Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28DF5FF744
	for <lists+netfilter-devel@lfdr.de>; Sun, 17 Nov 2019 03:36:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbfKQCf7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 16 Nov 2019 21:35:59 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:32877 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725974AbfKQCf7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 16 Nov 2019 21:35:59 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id E70E93A0D1B
        for <netfilter-devel@vger.kernel.org>; Sun, 17 Nov 2019 13:35:42 +1100 (AEDT)
Received: (qmail 23374 invoked by uid 501); 17 Nov 2019 02:35:40 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue v2] src: Fix IPv4 checksum calculation in AF_BRIDGE packet buffer
Date:   Sun, 17 Nov 2019 13:35:40 +1100
Message-Id: <20191117023540.23332-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191116031834.13445-1-duncan_roe@optusnet.com.au>
References: <20191116031834.13445-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=5MUvSgtflXIMSxYH55oA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Updated:

 src/extra/pktbuff.c: If pktb was created in family AF_BRIDGE, then pktb->len
                      will include the bytes in the network header.
                      So set the IPv4 length to "tail - network_header"
                      rather than len

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
v2: fix whitespace
 src/extra/ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/extra/ipv4.c b/src/extra/ipv4.c
index 0227b62..c03f23f 100644
--- a/src/extra/ipv4.c
+++ b/src/extra/ipv4.c
@@ -117,7 +117,7 @@ int nfq_ip_mangle(struct pkt_buff *pktb, unsigned int dataoff,
 		return 0;
 
 	/* fix IP hdr checksum information */
-	iph->tot_len = htons(pktb->len);
+	iph->tot_len = htons(pktb->tail - pktb->network_header);
 	nfq_ip_set_checksum(iph);
 
 	return 1;
-- 
2.14.5

