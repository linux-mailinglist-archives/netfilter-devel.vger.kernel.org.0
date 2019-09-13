Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACE9B1964
	for <lists+netfilter-devel@lfdr.de>; Fri, 13 Sep 2019 10:13:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387404AbfIMIN0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 13 Sep 2019 04:13:26 -0400
Received: from kadath.azazel.net ([81.187.231.250]:60586 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbfIMINY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 13 Sep 2019 04:13:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=IdP60rXAX0YhKibh/aTY/A9QZSt5PlSpaBjrlJJrhQA=; b=Rce2MRzDrnZMrTUq5KKW1fkTif
        6KrdPMNsS1Tv1/AgqviSNOY/FllqG0RELV3WJHIsTE0nBTF4YgdtjulTl3zZqprkebzXR8F+mxSmX
        cIxRKQaM6HF6KSy7p7jx+1hdiO4mZoisHra6mDZFpOxRjQaKW7Ih1T8o7wf1Snubqa/PNCWpLqefc
        yj5ea6XGdbCupZF8qqnreXFaEbfMwnOOa3vVNo2mZJUhYBw0HsOztbmJV8gez72HJeho1i4tovgcn
        qtkhUtoEnOKjp0YtqzIfhyIcibfNPqFREcb6lzsVQJgPtzzf/J99EFHFBHbxAK8S8UaJbgj1s7WLf
        GmzuW31A==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i8ghk-0005yL-Oe; Fri, 13 Sep 2019 09:13:20 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nf-next v3 06/18] netfilter: remove nf_conntrack_icmpv6.h header.
Date:   Fri, 13 Sep 2019 09:13:06 +0100
Message-Id: <20190913081318.16071-7-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190913081318.16071-1-jeremy@azazel.net>
References: <20190913081318.16071-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

nf_conntrack_icmpv6.h contains two object macros which duplicate macros
in linux/icmpv6.h.  The latter definitions are also visible wherever it
is included, so remove it.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 .../net/netfilter/ipv6/nf_conntrack_icmpv6.h  | 21 -------------------
 include/net/netfilter/nf_conntrack.h          |  1 -
 net/netfilter/nf_conntrack_proto_icmpv6.c     |  1 -
 3 files changed, 23 deletions(-)
 delete mode 100644 include/net/netfilter/ipv6/nf_conntrack_icmpv6.h

diff --git a/include/net/netfilter/ipv6/nf_conntrack_icmpv6.h b/include/net/netfilter/ipv6/nf_conntrack_icmpv6.h
deleted file mode 100644
index c86895bc5eb6..000000000000
--- a/include/net/netfilter/ipv6/nf_conntrack_icmpv6.h
+++ /dev/null
@@ -1,21 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * ICMPv6 tracking.
- *
- * 21 Apl 2004: Yasuyuki Kozakai @USAGI <yasuyuki.kozakai@toshiba.co.jp>
- *	- separated from nf_conntrack_icmp.h
- *
- * Derived from include/linux/netfiter_ipv4/ip_conntrack_icmp.h
- */
-
-#ifndef _NF_CONNTRACK_ICMPV6_H
-#define _NF_CONNTRACK_ICMPV6_H
-
-#ifndef ICMPV6_NI_QUERY
-#define ICMPV6_NI_QUERY 139
-#endif
-#ifndef ICMPV6_NI_REPLY
-#define ICMPV6_NI_REPLY 140
-#endif
-
-#endif /* _NF_CONNTRACK_ICMPV6_H */
diff --git a/include/net/netfilter/nf_conntrack.h b/include/net/netfilter/nf_conntrack.h
index 2cc304efe7f9..22275f42f0bb 100644
--- a/include/net/netfilter/nf_conntrack.h
+++ b/include/net/netfilter/nf_conntrack.h
@@ -23,7 +23,6 @@
 #include <linux/netfilter/nf_conntrack_dccp.h>
 #include <linux/netfilter/nf_conntrack_sctp.h>
 #include <linux/netfilter/nf_conntrack_proto_gre.h>
-#include <net/netfilter/ipv6/nf_conntrack_icmpv6.h>
 
 #include <net/netfilter/nf_conntrack_tuple.h>
 
diff --git a/net/netfilter/nf_conntrack_proto_icmpv6.c b/net/netfilter/nf_conntrack_proto_icmpv6.c
index 7e317e6698ba..6f9144e1f1c1 100644
--- a/net/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/netfilter/nf_conntrack_proto_icmpv6.c
@@ -22,7 +22,6 @@
 #include <net/netfilter/nf_conntrack_core.h>
 #include <net/netfilter/nf_conntrack_timeout.h>
 #include <net/netfilter/nf_conntrack_zones.h>
-#include <net/netfilter/ipv6/nf_conntrack_icmpv6.h>
 #include <net/netfilter/nf_log.h>
 
 static const unsigned int nf_ct_icmpv6_timeout = 30*HZ;
-- 
2.23.0

