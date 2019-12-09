Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 082E811644A
	for <lists+netfilter-devel@lfdr.de>; Mon,  9 Dec 2019 01:05:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfLIAFV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 8 Dec 2019 19:05:21 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:41487 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726422AbfLIAFV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 8 Dec 2019 19:05:21 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id C859D3A1E28
        for <netfilter-devel@vger.kernel.org>; Mon,  9 Dec 2019 11:05:06 +1100 (AEDT)
Received: (qmail 14896 invoked by uid 501); 9 Dec 2019 00:05:06 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 1/2] src: doc: Update sample code to agree with documentation
Date:   Mon,  9 Dec 2019 11:05:05 +1100
Message-Id: <20191209000506.14854-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=LYdCFQXi c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=-LNT-4Upm2ibfe7E0_oA:9 a=IDKqgSdm1Z70hi2K:21 a=ZwjD4sJjuNA619Pe:21
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Updated:

 src/nlmsg.c: Update nfq_nlmsg_verdict_put_pkt() sample code to use pktb_len()
              as recommended in src/extra/pktbuff.c, pktb_len() doco

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/nlmsg.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/nlmsg.c b/src/nlmsg.c
index c40a9e4..c950110 100644
--- a/src/nlmsg.c
+++ b/src/nlmsg.c
@@ -90,14 +90,13 @@ EXPORT_SYMBOL
 	pktb = pktb_alloc(AF_INET, payload, plen, 255);
 	// (decide that this packet needs mangling)
 	nfq_udp_mangle_ipv4(pktb, match_offset, match_len, rep_data, rep_len);
-	// Update IP Datagram length
-	plen += rep_len - match_len;
+	// nfq_udp_mangle_ipv4 updates packet length, no need to track locally
 
 	// Eventually nfq_send_verdict (line 39) gets called
 	// The received packet may or may not have been modified.
 	// Add this code before nfq_nlmsg_verdict_put call:
 	if (pktb_mangled(pktb))
-		nfq_nlmsg_verdict_put_pkt(nlh, pktb_data(pktb), plen);
+		nfq_nlmsg_verdict_put_pkt(nlh, pktb_data(pktb), pktb_len(pktb));
 \endverbatim
  */
 void nfq_nlmsg_verdict_put_pkt(struct nlmsghdr *nlh, const void *pkt,
-- 
2.14.5

