Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F6EE7576
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 16:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390030AbfJ1PtF (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 11:49:05 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40140 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731541AbfJ1PtF (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 11:49:05 -0400
Received: from localhost ([::1]:53230 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iP7GR-00027H-P0; Mon, 28 Oct 2019 16:49:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 08/10] xtables-arp: Drop some unused variables
Date:   Mon, 28 Oct 2019 16:48:16 +0100
Message-Id: <20191028154818.31257-9-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028154818.31257-1-phil@nwl.cc>
References: <20191028154818.31257-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-arp.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 8339b2cb6f38c..bbc1ceb6e8e38 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -53,10 +53,6 @@
 #include "nft-arp.h"
 #include <linux/netfilter_arp/arp_tables.h>
 
-typedef char arpt_chainlabel[32];
-
-#define OPTION_OFFSET 256
-
 #define NUMBER_OF_OPT	16
 static const char optflags[NUMBER_OF_OPT]
 = { 'n', 's', 'd', 2, 3, 7, 8, 4, 5, 6, 'j', 'v', 'i', 'o', '0', 'c'};
@@ -102,8 +98,6 @@ static struct option original_opts[] = {
 	{ 0 }
 };
 
-int RUNTIME_NF_ARP_NUMHOOKS = 3;
-
 #define opts xt_params->opts
 
 extern void xtables_exit_error(enum xtables_exittype status, const char *msg, ...) __attribute__((noreturn, format(printf,2,3)));
@@ -137,17 +131,6 @@ static int inverse_for_options[] =
 /* 6 */ ARPT_INV_ARPPRO,
 };
 
-/* Primitive headers... */
-/* defined in netinet/in.h */
-#if 0
-#ifndef IPPROTO_ESP
-#define IPPROTO_ESP 50
-#endif
-#ifndef IPPROTO_AH
-#define IPPROTO_AH 51
-#endif
-#endif
-
 /***********************************************/
 /* ARPTABLES SPECIFIC NEW FUNCTIONS ADDED HERE */
 /***********************************************/
-- 
2.23.0

