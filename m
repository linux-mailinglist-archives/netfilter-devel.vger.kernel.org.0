Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7E4ACF003
	for <lists+netfilter-devel@lfdr.de>; Tue,  8 Oct 2019 02:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbfJHAuC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 7 Oct 2019 20:50:02 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:42019 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729659AbfJHAuC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 7 Oct 2019 20:50:02 -0400
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 970F143ECDA
        for <netfilter-devel@vger.kernel.org>; Tue,  8 Oct 2019 11:49:49 +1100 (AEDT)
Received: (qmail 25690 invoked by uid 501); 8 Oct 2019 00:49:48 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 5/5] src: doc: Minor fix
Date:   Tue,  8 Oct 2019 11:49:48 +1100
Message-Id: <20191008004948.25632-6-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20191008004948.25632-1-duncan_roe@optusnet.com.au>
References: <20191008004948.25632-1-duncan_roe@optusnet.com.au>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.2 cv=D+Q3ErZj c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=XobE76Q3jBoA:10 a=PO7r1zJSAAAA:8
        a=gLbFEQvy-HYiREUKmF4A:9 a=bz8UzQCR5MW_rGH2:21 a=3KLjBXUE_fgbUkWX:21
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The documentation generally uses OSI layer numbering, where TCP (i.e. Transport)
is layer 4 so that IP is layer 3.

Bring pktb_mangle documentation into line with this.

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/pktbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/extra/pktbuff.c b/src/extra/pktbuff.c
index 9c2e83a..05b211b 100644
--- a/src/extra/pktbuff.c
+++ b/src/extra/pktbuff.c
@@ -226,7 +226,7 @@ static int enlarge_pkt(struct pkt_buff *pkt, unsigned int extra)
 /**
  * pktb_mangle - adjust contents of a packet
  * \param pkt Pointer to packet buffer
- * \param dataoff Offset to layer 3 header. Specify zero to access layer 2 (IP)
+ * \param dataoff Offset to layer 4 header. Specify zero to access layer 3 (IP)
  * header
  * \param match_offset Further offset to content that you want to mangle
  * \param match_len Length of the existing content you want to mangle
-- 
2.14.5

