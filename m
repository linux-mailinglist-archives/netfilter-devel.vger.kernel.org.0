Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E919AF6D7D
	for <lists+netfilter-devel@lfdr.de>; Mon, 11 Nov 2019 05:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbfKKER3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 10 Nov 2019 23:17:29 -0500
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:47746 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726754AbfKKER2 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 10 Nov 2019 23:17:28 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id DF4FA12DC49
        for <netfilter-devel@vger.kernel.org>; Mon, 11 Nov 2019 15:17:23 +1100 (AEDT)
Received: (qmail 30705 invoked by uid 501); 11 Nov 2019 04:17:23 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 1/2] src: pktb_trim() was not updating tail after updating len
Date:   Mon, 11 Nov 2019 15:17:22 +1100
Message-Id: <20191111041723.30660-2-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191111041723.30660-1-duncan_roe@optusnet.com.au>
References: <20191111041723.30660-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=G6BsK5s5 c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=MeAgGD-zjQ4A:10 a=RSmzAf-M6YYA:10
        a=PO7r1zJSAAAA:8 a=1OZKxPU71vBMjfv2Ac0A:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

skb->tail is used in many places, so it's important to keep it up to date.

Updated:

 src/extra/pktbuff.c: Fix pktb_trim()

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/pktbuff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/extra/pktbuff.c b/src/extra/pktbuff.c
index 00af037..3a08d49 100644
--- a/src/extra/pktbuff.c
+++ b/src/extra/pktbuff.c
@@ -156,6 +156,7 @@ EXPORT_SYMBOL
 void pktb_trim(struct pkt_buff *pktb, unsigned int len)
 {
 	pktb->len = len;
+	pktb->tail = pktb->head + len;
 }
 
 /**
-- 
2.14.5

