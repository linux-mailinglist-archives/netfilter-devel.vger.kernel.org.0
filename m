Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD15E7346
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 15:05:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729627AbfJ1OFI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 10:05:08 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:39892 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfJ1OFI (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:05:08 -0400
Received: from localhost ([::1]:52982 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iP5dq-0000ud-ED; Mon, 28 Oct 2019 15:05:06 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 08/10] xtables-arp: Drop some unused variables
Date:   Mon, 28 Oct 2019 15:04:29 +0100
Message-Id: <20191028140431.13882-9-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028140431.13882-1-phil@nwl.cc>
References: <20191028140431.13882-1-phil@nwl.cc>
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
index e4614b57a437f..11ca7f869730e 100644
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
@@ -135,17 +129,6 @@ static int inverse_for_options[NUMBER_OF_OPT] =
 /* -c */ 0,
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

