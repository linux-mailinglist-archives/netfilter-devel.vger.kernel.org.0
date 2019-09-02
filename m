Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 315D2A5DF8
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfIBXG4 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:06:56 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43576 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbfIBXGy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:06:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0XvlM9zt1+jvZJPdOPEDpA6KU3hF66W/o5HOzzvKZ7A=; b=JG1QbLy1h/u8LScl3/Ym1n18np
        rpVHcCuraF7z5Oyzp+08TIRtq5eJQuUE0cQxGhT4A9MccQNHqP967bmVZuipCJPATpM/5DV/EKf/V
        UkHuZTtVMfHU8utCG9vTZujhJLvmkXRh3Y1wgEmk3SXRcyJwOrULr6kM76+cA606oqZon/fYZ2OWP
        95SVVKBzLjqJ34MTpSVgzVillzetMZjvkJ6YB7OqcZbAdXGRY+LHsJjsZY6I25n/7m3juwCr0Bz1k
        8BQeMB/8AAVZtW3aFEbs5UNHIj0bQxXSJFrhc+t5DiXxc6Gh/+9r0Pm8gy/glJn4N+5G/MsBguFLm
        MeX956iw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPP-0004la-40; Tue, 03 Sep 2019 00:06:51 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 04/30] netfilter: add GPL-2.0 SPDX ID's to a couple of headers.
Date:   Tue,  3 Sep 2019 00:06:24 +0100
Message-Id: <20190902230650.14621-5-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190902230650.14621-1-jeremy@azazel.net>
References: <20190902230650.14621-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Two headers are missing SPDX licence identifiers.  They contain
copyright notices indicating that the code is GPL.  Add GPL-2.0
identifiers.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/linux/netfilter_ipv4.h | 3 ++-
 include/linux/netfilter_ipv6.h | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/netfilter_ipv4.h b/include/linux/netfilter_ipv4.h
index 082e2c41b7ff..cab891485752 100644
--- a/include/linux/netfilter_ipv4.h
+++ b/include/linux/netfilter_ipv4.h
@@ -1,4 +1,5 @@
-/* IPv4-specific defines for netfilter. 
+/* SPDX-License-Identifier: GPL-2.0 */
+/* IPv4-specific defines for netfilter.
  * (C)1998 Rusty Russell -- This code is GPL.
  */
 #ifndef __LINUX_IP_NETFILTER_H
diff --git a/include/linux/netfilter_ipv6.h b/include/linux/netfilter_ipv6.h
index 7beb681e1ce5..c2f669581d88 100644
--- a/include/linux/netfilter_ipv6.h
+++ b/include/linux/netfilter_ipv6.h
@@ -1,4 +1,5 @@
-/* IPv6-specific defines for netfilter. 
+/* SPDX-License-Identifier: GPL-2.0 */
+/* IPv6-specific defines for netfilter.
  * (C)1998 Rusty Russell -- This code is GPL.
  * (C)1999 David Jeffery
  *   this header was blatantly ripped from netfilter_ipv4.h 
-- 
2.23.0.rc1

