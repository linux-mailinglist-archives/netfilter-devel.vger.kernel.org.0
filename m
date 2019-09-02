Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E5E29A5E21
	for <lists+netfilter-devel@lfdr.de>; Tue,  3 Sep 2019 01:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfIBXcN (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Sep 2019 19:32:13 -0400
Received: from kadath.azazel.net ([81.187.231.250]:43972 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfIBXcN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Sep 2019 19:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6O0S1DiAMTmiSxTA2VSpUqS/fNTtLmJvSWv30Wm2woE=; b=Q+muwk2sbuqJXayr+AFTewieYv
        ZCxD9K1n3BoSu7Nc+N02c8SRcVcFs+lLUrJfTB0XOEpTIF+X3s+PWMXoS16hpGpwUUPAp6QUP3GcF
        QzxpwnPNhKVJMpIiZGTyKL3jQh5xtubTGOm35a9O0RqsPsRYWuIT3IcSM2cv0bHGG5Kfvy8uMbRGZ
        lIOAGSkmo87nV0mvwgJaG4nAiA5f5I+4cStMCeT3r3IJ4k27IipB00npgE4xTs/J0QBgfB+t2iAK1
        pcmoSeAu7u7/F15ySV8CNUXJ/yHB9EDmDtErRnPnTnYA27iBIxKuEMTdTZvWkoWqT7Usol8SnLSxi
        /vYsxVAA==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i4vPQ-0004la-6m; Tue, 03 Sep 2019 00:06:52 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v2 11/30] netfilter: fix inclusions of <linux/netfilter/nf_nat.h>.
Date:   Tue,  3 Sep 2019 00:06:31 +0100
Message-Id: <20190902230650.14621-12-jeremy@azazel.net>
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

Three files include linux/netfilter/nf_nat.h, which doesn't exist,
instead of uapi/linux/netfilter/nf_nat.h.  Fix them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 include/net/netfilter/nf_nat.h | 5 ++++-
 net/netfilter/nf_nat_core.c    | 6 +++---
 net/sched/act_ct.c             | 2 +-
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/net/netfilter/nf_nat.h b/include/net/netfilter/nf_nat.h
index eec208fb9c23..c3ac2751952d 100644
--- a/include/net/netfilter/nf_nat.h
+++ b/include/net/netfilter/nf_nat.h
@@ -2,8 +2,11 @@
 #ifndef _NF_NAT_H
 #define _NF_NAT_H
 #include <linux/netfilter_ipv4.h>
-#include <linux/netfilter/nf_nat.h>
+#include <linux/netfilter/nf_conntrack_pptp.h>
+#include <net/netfilter/nf_conntrack.h>
+#include <net/netfilter/nf_conntrack_extend.h>
 #include <net/netfilter/nf_conntrack_tuple.h>
+#include <uapi/linux/netfilter/nf_nat.h>
 
 enum nf_nat_manip_type {
 	NF_NAT_MANIP_SRC,
diff --git a/net/netfilter/nf_nat_core.c b/net/netfilter/nf_nat_core.c
index 3f6023ed4966..bfc555fcbc72 100644
--- a/net/netfilter/nf_nat_core.c
+++ b/net/netfilter/nf_nat_core.c
@@ -18,12 +18,12 @@
 
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_core.h>
-#include <net/netfilter/nf_nat.h>
-#include <net/netfilter/nf_nat_helper.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/nf_conntrack_seqadj.h>
 #include <net/netfilter/nf_conntrack_zones.h>
-#include <linux/netfilter/nf_nat.h>
+#include <net/netfilter/nf_nat.h>
+#include <net/netfilter/nf_nat_helper.h>
+#include <uapi/linux/netfilter/nf_nat.h>
 
 #include "nf_internals.h"
 
diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index 33a1a7406e87..5a3c5c5885ef 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -24,12 +24,12 @@
 #include <uapi/linux/tc_act/tc_ct.h>
 #include <net/tc_act/tc_ct.h>
 
-#include <linux/netfilter/nf_nat.h>
 #include <net/netfilter/nf_conntrack.h>
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_zones.h>
 #include <net/netfilter/nf_conntrack_helper.h>
 #include <net/netfilter/ipv6/nf_defrag_ipv6.h>
+#include <uapi/linux/netfilter/nf_nat.h>
 
 static struct tc_action_ops act_ct_ops;
 static unsigned int ct_net_id;
-- 
2.23.0.rc1

