Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E167B1430F
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 May 2019 01:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbfEEXdR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 5 May 2019 19:33:17 -0400
Received: from mail.us.es ([193.147.175.20]:34080 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbfEEXdQ (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 5 May 2019 19:33:16 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 107A711ED89
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 01:33:15 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F2414DA708
        for <netfilter-devel@vger.kernel.org>; Mon,  6 May 2019 01:33:14 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E7A6BDA704; Mon,  6 May 2019 01:33:14 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id F2487DA70B;
        Mon,  6 May 2019 01:33:12 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 May 2019 01:33:12 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id BF3D44265A31;
        Mon,  6 May 2019 01:33:12 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     davem@davemloft.net, netdev@vger.kernel.org
Subject: [PATCH 02/12] netfilter: nf_tables: fix implicit include of module.h
Date:   Mon,  6 May 2019 01:32:55 +0200
Message-Id: <20190505233305.13650-3-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190505233305.13650-1-pablo@netfilter.org>
References: <20190505233305.13650-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Paul Gortmaker <paul.gortmaker@windriver.com>

This file clearly uses modular infrastructure but does not call
out the inclusion of <linux/module.h> explicitly.  We add that
include explicitly here, so we can tidy up some header usage
elsewhere w/o causing build breakage.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 net/netfilter/nf_tables_set_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/netfilter/nf_tables_set_core.c b/net/netfilter/nf_tables_set_core.c
index 814789644bd3..a9fce8d10051 100644
--- a/net/netfilter/nf_tables_set_core.c
+++ b/net/netfilter/nf_tables_set_core.c
@@ -1,4 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/module.h>
 #include <net/netfilter/nf_tables_core.h>
 
 static int __init nf_tables_set_module_init(void)
-- 
2.11.0

