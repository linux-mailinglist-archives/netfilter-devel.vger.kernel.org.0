Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2372E572D6
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Jun 2019 22:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfFZUoR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 26 Jun 2019 16:44:17 -0400
Received: from fnsib-smtp07.srv.cat ([46.16.61.68]:58602 "EHLO
        fnsib-smtp07.srv.cat" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726271AbfFZUoQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 26 Jun 2019 16:44:16 -0400
Received: from localhost.localdomain (unknown [47.62.206.189])
        by fnsib-smtp07.srv.cat (Postfix) with ESMTPSA id DB0F881B2;
        Wed, 26 Jun 2019 22:44:11 +0200 (CEST)
From:   Ander Juaristi <a@juaristi.eus>
To:     netfilter-devel@vger.kernel.org
Cc:     Ander Juaristi <a@juaristi.eus>
Subject: [PATCH v2 4/7] nftables: tests/py: Add tests for day and hour
Date:   Wed, 26 Jun 2019 22:43:59 +0200
Message-Id: <20190626204402.5257-4-a@juaristi.eus>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190626204402.5257-1-a@juaristi.eus>
References: <20190626204402.5257-1-a@juaristi.eus>
Reply-To: a@juaristi.eus
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

