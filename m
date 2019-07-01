Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63FE159470
	for <lists+netfilter-devel@lfdr.de>; Fri, 28 Jun 2019 08:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbfF1Gx1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 28 Jun 2019 02:53:27 -0400
Received: from fnsib-smtp05.srv.cat ([46.16.61.54]:43397 "EHLO
        fnsib-smtp05.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727296AbfF1Gx0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 28 Jun 2019 02:53:26 -0400
Received: from bubu.das-nano.com (242.red-83-48-67.staticip.rima-tde.net [83.48.67.242])
        by fnsib-smtp05.srv.cat (Postfix) with ESMTPSA id 77C7C1EF131
        for <netfilter-devel@vger.kernel.org>; Fri, 28 Jun 2019 08:53:23 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH v3 2/4] tests/py: Add tests for day and hour
Date:   Fri, 28 Jun 2019 08:53:17 +0200
Message-Id: <20190628065319.15834-2-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190628065319.15834-1-a@juaristi.eus>
References: <20190628065319.15834-1-a@juaristi.eus>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Ander Juaristi <a@juaristi.eus>
---
 tests/py/ip/meta.t         |  2 ++
 tests/py/ip/meta.t.payload | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/tests/py/ip/meta.t b/tests/py/ip/meta.t
index 4db8835..02ba11d 100644
--- a/tests/py/ip/meta.t
+++ b/tests/py/ip/meta.t
@@ -3,6 +3,8 @@
 *ip;test-ip4;input
 
 icmp type echo-request;ok
+meta day "Saturday" drop;ok;meta day "Saturday" drop
+meta hour "17:00" drop;ok;meta hour "17:00" drop
 meta l4proto icmp icmp type echo-request;ok;icmp type echo-request
 meta l4proto ipv6-icmp icmpv6 type nd-router-advert;ok;icmpv6 type nd-router-advert
 meta l4proto 58 icmpv6 type nd-router-advert;ok;icmpv6 type nd-router-advert
diff --git a/tests/py/ip/meta.t.payload b/tests/py/ip/meta.t.payload
index 322c087..ad00a1a 100644
--- a/tests/py/ip/meta.t.payload
+++ b/tests/py/ip/meta.t.payload
@@ -1,3 +1,15 @@
+# meta day "Saturday" drop
+ip test-ip4 input
+  [ meta load unknown => reg 1 ]
+  [ cmp eq reg 1 0x00000006 ]
+  [ immediate reg 0 drop ]
+
+# meta hour "17:00" drop
+ip test-ip4 input
+  [ meta load unknown => reg 1 ]
+  [ cmp eq reg 1 0x0000d2f0 0x00000000 ]
+  [ immediate reg 0 drop ]
+
 # icmp type echo-request
 ip test-ip4 input
   [ meta load l4proto => reg 1 ]
-- 
2.17.1

