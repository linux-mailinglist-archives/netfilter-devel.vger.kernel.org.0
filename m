Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD2C181750
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Mar 2020 13:00:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgCKMAJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Mar 2020 08:00:09 -0400
Received: from mailout2.hostsharing.net ([83.223.78.233]:37513 "EHLO
        mailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgCKMAJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:00:09 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (not verified))
        by mailout2.hostsharing.net (Postfix) with ESMTPS id 519C7100898B3;
        Wed, 11 Mar 2020 13:00:07 +0100 (CET)
Received: from localhost (unknown [87.130.102.138])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 13A1E6005A67;
        Wed, 11 Mar 2020 13:00:07 +0100 (CET)
X-Mailbox-Line: From 661bb976e6cc40fa391ad72dce86dae6a5898400 Mon Sep 17 00:00:00 2001
Message-Id: <661bb976e6cc40fa391ad72dce86dae6a5898400.1583927267.git.lukas@wunner.de>
In-Reply-To: <cover.1583927267.git.lukas@wunner.de>
References: <cover.1583927267.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Wed, 11 Mar 2020 12:59:01 +0100
Subject: [PATCH nf-next 1/3] netfilter: Rename ingress hook include file
To:     "Pablo Neira Ayuso" <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, Martin Mares <mj@ucw.cz>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Thomas Graf <tgraf@suug.ch>,
        Alexei Starovoitov <ast@kernel.org>
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Prepare for addition of a netfilter egress hook by renaming
<linux/netfilter_ingress.h> to <linux/netfilter_netdev.h>.

The egress hook also necessitates a refactoring of the include file,
but that is done in a separate commit to ease reviewing.

No functional change intended.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: Daniel Borkmann <daniel@iogearbox.net>
---
 include/linux/{netfilter_ingress.h => netfilter_netdev.h} | 0
 net/core/dev.c                                            | 2 +-
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{netfilter_ingress.h => netfilter_netdev.h} (100%)

diff --git a/include/linux/netfilter_ingress.h b/include/linux/netfilter_netdev.h
similarity index 100%
rename from include/linux/netfilter_ingress.h
rename to include/linux/netfilter_netdev.h
diff --git a/net/core/dev.c b/net/core/dev.c
index e10bd680dc03..b378b669a8ab 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -135,7 +135,7 @@
 #include <linux/if_macvlan.h>
 #include <linux/errqueue.h>
 #include <linux/hrtimer.h>
-#include <linux/netfilter_ingress.h>
+#include <linux/netfilter_netdev.h>
 #include <linux/crash_dump.h>
 #include <linux/sctp.h>
 #include <net/udp_tunnel.h>
-- 
2.25.0

