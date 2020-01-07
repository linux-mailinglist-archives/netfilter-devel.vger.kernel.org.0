Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CA9133516
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jan 2020 22:42:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgAGVmm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Jan 2020 16:42:42 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33423 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgAGVmm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:42:42 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 5D5EC7EB166
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Jan 2020 08:42:25 +1100 (AEDT)
Received: (qmail 9598 invoked by uid 501); 7 Jan 2020 21:42:24 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 1/1] src: Fix value returned by nfq_tcp_get_payload_len()
Date:   Wed,  8 Jan 2020 08:42:24 +1100
Message-Id: <20200107214224.9549-2-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200107214224.9549-1-duncan_roe@optusnet.com.au>
References: <20200107214224.9549-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=Jdjhy38mL1oA:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=r1guFdXvGmP_6AwhMRoA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Remember to subtract the TCP header length.

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/extra/tcp.c b/src/extra/tcp.c
index 0f83500..236663f 100644
--- a/src/extra/tcp.c
+++ b/src/extra/tcp.c
@@ -83,7 +83,7 @@ void *nfq_tcp_get_payload(struct tcphdr *tcph, struct pkt_buff *pktb)
 EXPORT_SYMBOL
 unsigned int nfq_tcp_get_payload_len(struct tcphdr *tcph, struct pkt_buff *pktb)
 {
-	return pktb->tail - pktb->transport_header;
+	return pktb->tail - pktb->transport_header -tcph->doff * 4;
 }
 
 /**
-- 
2.14.5

