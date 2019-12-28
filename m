Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF6912BC19
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Dec 2019 02:24:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbfL1BYL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Dec 2019 20:24:11 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:55487 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725820AbfL1BYL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Dec 2019 20:24:11 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id B21C13A2FC1
        for <netfilter-devel@vger.kernel.org>; Sat, 28 Dec 2019 12:23:58 +1100 (AEDT)
Received: (qmail 2520 invoked by uid 501); 28 Dec 2019 01:23:57 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 1/2] src: tcp.c: change 1 remaining pkt formal arg to pktb
Date:   Sat, 28 Dec 2019 12:23:56 +1100
Message-Id: <20191228012357.2474-2-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191228012357.2474-1-duncan_roe@optusnet.com.au>
References: <20191228012357.2474-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=0NM-NOkpf67_Awr4vBEA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/tcp.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/extra/tcp.c b/src/extra/tcp.c
index 8119843..2296bef 100644
--- a/src/extra/tcp.c
+++ b/src/extra/tcp.c
@@ -188,17 +188,17 @@ int nfq_tcp_snprintf(char *buf, size_t size, const struct tcphdr *tcph)
  * \note This function recalculates the IPv4 and TCP checksums for you.
  */
 EXPORT_SYMBOL
-int nfq_tcp_mangle_ipv4(struct pkt_buff *pkt,
+int nfq_tcp_mangle_ipv4(struct pkt_buff *pktb,
 			unsigned int match_offset, unsigned int match_len,
 			const char *rep_buffer, unsigned int rep_len)
 {
 	struct iphdr *iph;
 	struct tcphdr *tcph;
 
-	iph = (struct iphdr *)pkt->network_header;
-	tcph = (struct tcphdr *)(pkt->network_header + iph->ihl*4);
+	iph = (struct iphdr *)pktb->network_header;
+	tcph = (struct tcphdr *)(pktb->network_header + iph->ihl*4);
 
-	if (!nfq_ip_mangle(pkt, iph->ihl*4 + tcph->doff*4,
+	if (!nfq_ip_mangle(pktb, iph->ihl*4 + tcph->doff*4,
 				match_offset, match_len, rep_buffer, rep_len))
 		return 0;
 
-- 
2.14.5

