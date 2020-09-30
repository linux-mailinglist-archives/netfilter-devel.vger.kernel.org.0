Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B5F27DFD5
	for <lists+netfilter-devel@lfdr.de>; Wed, 30 Sep 2020 07:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725385AbgI3FEa (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 30 Sep 2020 01:04:30 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:58973 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725320AbgI3FEa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 30 Sep 2020 01:04:30 -0400
X-Greylist: delayed 1101 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Sep 2020 01:04:29 EDT
Received: from dimstar.local.net (n49-192-70-185.sun3.vic.optusnet.com.au [49.192.70.185])
        by mail105.syd.optusnet.com.au (Postfix) with SMTP id D09873AC060
        for <netfilter-devel@vger.kernel.org>; Wed, 30 Sep 2020 15:04:26 +1000 (AEST)
Received: (qmail 12504 invoked by uid 501); 30 Sep 2020 05:04:26 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org, dunc@dimstar.local.net
Subject: [PATCH libnetfilter_queue] src: doc: Fix doxygen warning
Date:   Wed, 30 Sep 2020 15:04:26 +1000
Message-Id: <20200930050426.12462-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.17.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=YKPhNiOx c=1 sm=1 tr=0 cx=a_idp_d
        a=zRnOCfNoldqEzXEIOSrMkw==:117 a=zRnOCfNoldqEzXEIOSrMkw==:17
        a=reM5J-MqmosA:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=lYee_BwEX8FsesqnFeAA:9
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

src/extra/checksum.c had a stray group close sequnce at the end.

(Spotted after sending doxygen o/p to /dev/null)

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 src/extra/checksum.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/src/extra/checksum.c b/src/extra/checksum.c
index a650b64..ffc8c75 100644
--- a/src/extra/checksum.c
+++ b/src/extra/checksum.c
@@ -80,7 +80,3 @@ uint16_t nfq_checksum_tcpudp_ipv6(struct ip6_hdr *ip6h, void *transport_hdr,
 
 	return nfq_checksum(sum, (uint16_t *)payload, len);
 }
-
-/**
- * @}
- */
-- 
2.17.5

