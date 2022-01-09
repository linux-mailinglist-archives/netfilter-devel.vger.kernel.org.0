Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37C4E48891C
	for <lists+netfilter-devel@lfdr.de>; Sun,  9 Jan 2022 12:58:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbiAIL6p (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 9 Jan 2022 06:58:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233739AbiAIL6m (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 9 Jan 2022 06:58:42 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895D6C06173F
        for <netfilter-devel@vger.kernel.org>; Sun,  9 Jan 2022 03:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=n9qtLZLkg/A3RJxinnkJUS1UjQZZwoVEQ0HQuSPT6BE=; b=HqsMItsKWdQ4GEm9UzJKf3mKGs
        LU0oK8LYP5+Uh1PHkkinY3rkYwKGorijfDQ+8GtPLoCpx9bVCJQmrViXWvEJ4DYQhxtJ4Fn09IBp8
        /g4MADvivmJtAEKnCeEfajCquV266y2nXHY+YhZubqp8yGFj3ypm8UZBkZJ4706UeVzNtQLy+45Gn
        GMGnRyRF1BlkE/CR4XgaOAyJCIOP3PRE3cK9MiFr02YXPf/jH1ks8D4h1CEjtQFxjB21ZSHyAOT9k
        2SooMhFOp+fbIZLJKiYm2LCBtcDxy6E35t0Q9BPTut9yP0JCZp32zWO++N5afXBo4yc+7rZPjbogA
        51UL90ug==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=ulthar.dreamlands.azazel.net)
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1n6WqO-002BZm-TH
        for netfilter-devel@vger.kernel.org; Sun, 09 Jan 2022 11:58:40 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v2 08/10] build: if `--enable-pcap` is `yes`, abort if libpcap is not found
Date:   Sun,  9 Jan 2022 11:57:51 +0000
Message-Id: <20220109115753.1787915-9-jeremy@azazel.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109115753.1787915-1-jeremy@azazel.net>
References: <20220109115753.1787915-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

If libpcap support has been explicitly requested, abort if it is not
available.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 620cb34c8537..41eeb52b9121 100644
--- a/configure.ac
+++ b/configure.ac
@@ -213,6 +213,12 @@ AS_IF([test "x$enable_pcap" != "xno"], [
       AC_MSG_RESULT([no])
     ])
 
+    AS_IF([test "x$libpcap_LIBS" = "x"], [
+      AS_IF([test "x$enable_pcap" = "xyes"], [
+        AC_MSG_ERROR([libpcap not found])
+      ])
+    ])
+
   ])
 
 ])
-- 
2.34.1

