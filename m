Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 415BEC05D4
	for <lists+netfilter-devel@lfdr.de>; Fri, 27 Sep 2019 14:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfI0M5A (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 27 Sep 2019 08:57:00 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:43526 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727088AbfI0M5A (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 27 Sep 2019 08:57:00 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 6DBFD43EEAB
        for <netfilter-devel@vger.kernel.org>; Fri, 27 Sep 2019 22:56:45 +1000 (AEST)
Received: (qmail 7912 invoked by uid 501); 27 Sep 2019 12:56:45 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] BUG: src: Update UDP header length field after mangling
Date:   Fri, 27 Sep 2019 22:56:45 +1000
Message-Id: <20190927125645.7869-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=FNpr/6gs c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=J70Eh1EUuV4A:10 a=6nuk8M2LySgND5QPvBgA:9 a=pLouTN30JE-JXwSG:21
        a=taJqi5g1KmyLCurM:21
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

One would expect nfq_udp_mangle_ipv4() to take care of the length field in
the UDP header but it did not.
With this patch, it does.
This patch is very unlikely to adversely affect any existing userspace
software (that did its own length adjustment),
because UDP checksumming was broken
---
 src/extra/udp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/extra/udp.c b/src/extra/udp.c
index 8c44a66..6836230 100644
--- a/src/extra/udp.c
+++ b/src/extra/udp.c
@@ -140,6 +140,8 @@ nfq_udp_mangle_ipv4(struct pkt_buff *pkt,
 	iph = (struct iphdr *)pkt->network_header;
 	udph = (struct udphdr *)(pkt->network_header + iph->ihl*4);
 
+	udph->len = htons(ntohs(udph->len) + rep_len - match_len);
+
 	if (!nfq_ip_mangle(pkt, iph->ihl*4 + sizeof(struct udphdr),
 				match_offset, match_len, rep_buffer, rep_len))
 		return 0;
-- 
2.14.5

