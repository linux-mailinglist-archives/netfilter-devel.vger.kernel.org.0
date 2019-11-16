Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55130FEA65
	for <lists+netfilter-devel@lfdr.de>; Sat, 16 Nov 2019 04:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727378AbfKPDSu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 15 Nov 2019 22:18:50 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:33533 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727345AbfKPDSu (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 15 Nov 2019 22:18:50 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id AC2213A16EE
        for <netfilter-devel@vger.kernel.org>; Sat, 16 Nov 2019 14:18:35 +1100 (AEDT)
Received: (qmail 13487 invoked by uid 501); 16 Nov 2019 03:18:34 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] src: Fix IPv4 checksum calculation in AF_BRIDGE packet buffer
Date:   Sat, 16 Nov 2019 14:18:34 +1100
Message-Id: <20191116031834.13445-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=5MUvSgtflXIMSxYH55oA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Updated:

 src/extra/pktbuff.c If pktb was created in family AF_BRIDGE, then pktb->len
                     will include the bytes in the network header.
                     So set the IPv4 length to "tail - network_header"
                     rather than len

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/ipv4.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/extra/ipv4.c b/src/extra/ipv4.c
index 0227b62..1b0f96b 100644
--- a/src/extra/ipv4.c
+++ b/src/extra/ipv4.c
@@ -117,7 +117,7 @@ int nfq_ip_mangle(struct pkt_buff *pktb, unsigned int dataoff,
 		return 0;
 
 	/* fix IP hdr checksum information */
-	iph->tot_len = htons(pktb->len);
+	iph->tot_len = htons(pktb->tail -pktb->network_header);
 	nfq_ip_set_checksum(iph);
 
 	return 1;
-- 
2.14.5

