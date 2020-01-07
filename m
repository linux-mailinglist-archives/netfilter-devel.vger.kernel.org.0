Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63A6A133515
	for <lists+netfilter-devel@lfdr.de>; Tue,  7 Jan 2020 22:42:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgAGVmi (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 7 Jan 2020 16:42:38 -0500
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:33405 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726470AbgAGVmi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 7 Jan 2020 16:42:38 -0500
Received: from dimstar.local.net (n122-110-44-45.sun2.vic.optusnet.com.au [122.110.44.45])
        by mail104.syd.optusnet.com.au (Postfix) with SMTP id 56A277EB165
        for <netfilter-devel@vger.kernel.org>; Wed,  8 Jan 2020 08:42:25 +1100 (AEDT)
Received: (qmail 9594 invoked by uid 501); 7 Jan 2020 21:42:24 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 0/1] src: Fix value returned by nfq_tcp_get_payload_len()
Date:   Wed,  8 Jan 2020 08:42:23 +1100
Message-Id: <20200107214224.9549-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=4DzML1vCOQ6Odsy8BUtSXQ==:117 a=4DzML1vCOQ6Odsy8BUtSXQ==:17
        a=Jdjhy38mL1oA:10 a=RSmzAf-M6YYA:10 a=vRU8Pz2XuPfUow-IeOQA:9
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 This fix is similar to nfq_udp_get_payload_len fix b09038c
 
 Both nfq_tcp_get_payload_len & nfq_udp_get_payload_len are one-liners,
 unlike nfq_{tcp,udp}_get_payload which have checks for a malformed packet.
 
 It is not a given that programs will always call xx_get_payload before
 xx_get_payload_len so if you like I can make a v2 where
 nfq_{tcp,udp}_get_payload_len do have such checks.
 
 Cheers ... Duncan.

Duncan Roe (1):
  src: Fix value returned by nfq_tcp_get_payload_len()

 src/extra/tcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.14.5

