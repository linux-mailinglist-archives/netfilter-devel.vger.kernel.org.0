Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9421912D565
	for <lists+netfilter-devel@lfdr.de>; Tue, 31 Dec 2019 02:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbfLaBGU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Dec 2019 20:06:20 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:37125 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727804AbfLaBGU (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Dec 2019 20:06:20 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id F353543F6C6
        for <netfilter-devel@vger.kernel.org>; Tue, 31 Dec 2019 12:06:07 +1100 (AEDT)
Received: (qmail 14357 invoked by uid 501); 31 Dec 2019 01:06:07 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] src: checksum.c: remove redundant 0xFFFF mask of uint16_t
Date:   Tue, 31 Dec 2019 12:06:07 +1100
Message-Id: <20191231010607.14313-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191230113345.olr3yifqqmytv3ce@salvia>
References: <20191230113345.olr3yifqqmytv3ce@salvia>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=pxVhFHJ0LMsA:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=C-bAANjjlkjK3RISWyUA:9 a=sf3CtFEyI9xkhxYo:21
        a=zjc2EziNNk5vQrcc:21
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/checksum.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/extra/checksum.c b/src/extra/checksum.c
index 8b23997..a650b64 100644
--- a/src/extra/checksum.c
+++ b/src/extra/checksum.c
@@ -70,10 +70,10 @@ uint16_t nfq_checksum_tcpudp_ipv6(struct ip6_hdr *ip6h, void *transport_hdr,
 	int i;
 
 	for (i=0; i<8; i++) {
-		sum += (ip6h->ip6_src.s6_addr16[i]) & 0xFFFF;
+		sum += (ip6h->ip6_src.s6_addr16[i]);
 	}
 	for (i=0; i<8; i++) {
-		sum += (ip6h->ip6_dst.s6_addr16[i]) & 0xFFFF;
+		sum += (ip6h->ip6_dst.s6_addr16[i]);
 	}
 	sum += htons(protonum);
 	sum += htons(len);
-- 
2.14.5

