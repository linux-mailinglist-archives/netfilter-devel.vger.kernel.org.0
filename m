Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B38DC10DE78
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Nov 2019 18:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfK3R6t (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Nov 2019 12:58:49 -0500
Received: from kadath.azazel.net ([81.187.231.250]:54246 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfK3R6s (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Nov 2019 12:58:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FQTskD11BXu3Iey6eJM0Z5A7Uj/U1A9ELCxxZ7p5teU=; b=Fp+2IskNqwmffXBLSfCUQ4dwsP
        xrSU3IcAtNwNBVeAe2QssdYCS9rzb9qVE0z7rZPoWCypTrJ4+DaX0jVLv2yVu0/ubwTiQ3ywbfZLJ
        tihDK0qSuh2nMsNhzcuwuJXM2RJyEIOcXbhDsmyQ2X0kv4b4DSLvstAwaYDylck75AJc0Ek2V8aqq
        YqEScB2thVer/TZ2jibgr9Gc0Pij2BlUQCWw3jdjLjcjxJaNPv7p4Hx4rL0auBNTV5+pHqALVxiJM
        mxbINfUxJPSFoKTAgpAkrAhUeRHEKH2tWIb7SVbf9Z9qRkV/44QOCTuei3LtJecmJAqRlJi4Blmg+
        v6HT/5ow==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1ib714-0002eP-AX; Sat, 30 Nov 2019 17:58:46 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        "Thomas B . Clark" <kernel@clark.bz>
Subject: [PATCH xtables-addons v2 2/3] xt_geoip: white-space fixes.
Date:   Sat, 30 Nov 2019 17:58:44 +0000
Message-Id: <20191130175845.369240-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130175845.369240-1-jeremy@azazel.net>
References: <3971b408-51e6-d90e-f291-7a43e46e84c1@ferree-clark.org>
 <20191130175845.369240-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Fix the indentation of some xt_geoip module function parameters.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/xt_geoip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/extensions/xt_geoip.c b/extensions/xt_geoip.c
index 27e60a4643b7..d64d951f19a9 100644
--- a/extensions/xt_geoip.c
+++ b/extensions/xt_geoip.c
@@ -140,7 +140,7 @@ static void geoip_try_remove_node(struct geoip_country_kernel *p)
 }
 
 static struct geoip_country_kernel *find_node(unsigned short cc,
-    enum geoip_proto proto)
+					      enum geoip_proto proto)
 {
 	struct geoip_country_kernel *p;
 	spin_lock(&geoip_lock);
@@ -172,7 +172,7 @@ ipv6_cmp(const struct in6_addr *p, const struct in6_addr *q)
 }
 
 static bool geoip_bsearch6(const struct geoip_subnet6 *range,
-    const struct in6_addr *addr, int lo, int hi)
+			   const struct in6_addr *addr, int lo, int hi)
 {
 	int mid;
 
@@ -227,7 +227,7 @@ xt_geoip_mt6(const struct sk_buff *skb, struct xt_action_param *par)
 }
 
 static bool geoip_bsearch4(const struct geoip_subnet4 *range,
-    uint32_t addr, int lo, int hi)
+			   uint32_t addr, int lo, int hi)
 {
 	int mid;
 
-- 
2.24.0

