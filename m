Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8E96ED134
	for <lists+netfilter-devel@lfdr.de>; Sun,  3 Nov 2019 01:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727364AbfKCAKp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 2 Nov 2019 20:10:45 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:50403 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726689AbfKCAKp (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 2 Nov 2019 20:10:45 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id EE8B143F5A0
        for <netfilter-devel@vger.kernel.org>; Sun,  3 Nov 2019 11:10:28 +1100 (AEDT)
Received: (qmail 31275 invoked by uid 501); 3 Nov 2019 00:10:27 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] src: doc: Fix spelling of CTA_LABELS in examples/nf-queue.c
Date:   Sun,  3 Nov 2019 11:10:27 +1100
Message-Id: <20191103001027.31233-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=P6RKvmIu c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=MeAgGD-zjQ4A:10 a=PO7r1zJSAAAA:8 a=JLH45OeQDlQPRsKksS0A:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 examples/nf-queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/examples/nf-queue.c b/examples/nf-queue.c
index c2bc6cc..f6d254a 100644
--- a/examples/nf-queue.c
+++ b/examples/nf-queue.c
@@ -50,7 +50,7 @@ nfq_send_verdict(int queue_num, uint32_t id)
 
 	/* then, add the connmark attribute: */
 	mnl_attr_put_u32(nlh, CTA_MARK, htonl(42));
-	/* more conntrack attributes, e.g. CTA_LABEL, could be set here */
+	/* more conntrack attributes, e.g. CTA_LABELS could be set here */
 
 	/* end conntrack section */
 	mnl_attr_nest_end(nlh, nest);
-- 
2.14.5

