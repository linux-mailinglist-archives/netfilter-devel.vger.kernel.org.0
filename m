Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7553E734A
	for <lists+netfilter-devel@lfdr.de>; Mon, 28 Oct 2019 15:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729925AbfJ1OFS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 28 Oct 2019 10:05:18 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:39904 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbfJ1OFS (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 28 Oct 2019 10:05:18 -0400
Received: from localhost ([::1]:52994 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iP5e1-0000v2-22; Mon, 28 Oct 2019 15:05:17 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 07/10] xtables-arp: Integrate OPT_* defines into xshared.h
Date:   Mon, 28 Oct 2019 15:04:28 +0100
Message-Id: <20191028140431.13882-8-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191028140431.13882-1-phil@nwl.cc>
References: <20191028140431.13882-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

These defines are internal use only, so their actual value doesn't
matter as long as they're unique.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xshared.h     |  7 +++++++
 iptables/xtables-arp.c | 25 ++++---------------------
 2 files changed, 11 insertions(+), 21 deletions(-)

diff --git a/iptables/xshared.h b/iptables/xshared.h
index b0738b042e95a..490b19ade5106 100644
--- a/iptables/xshared.h
+++ b/iptables/xshared.h
@@ -29,6 +29,13 @@ enum {
 	OPT_VIANAMEOUT  = 1 << 8,
 	OPT_LINENUMBERS = 1 << 9,
 	OPT_COUNTERS    = 1 << 10,
+	/* below are for arptables only */
+	OPT_S_MAC	= 1 << 11,
+	OPT_D_MAC	= 1 << 12,
+	OPT_H_LENGTH	= 1 << 13,
+	OPT_OPCODE	= 1 << 14,
+	OPT_H_TYPE	= 1 << 15,
+	OPT_P_TYPE	= 1 << 16,
 };
 
 enum {
diff --git a/iptables/xtables-arp.c b/iptables/xtables-arp.c
index 4949ddd3d486c..e4614b57a437f 100644
--- a/iptables/xtables-arp.c
+++ b/iptables/xtables-arp.c
@@ -57,23 +57,6 @@ typedef char arpt_chainlabel[32];
 
 #define OPTION_OFFSET 256
 
-#define OPT_NONE	0x00000U
-#define OPT_NUMERIC	0x00001U
-#define OPT_S_IP	0x00002U
-#define OPT_D_IP	0x00004U
-#define OPT_S_MAC	0x00008U
-#define OPT_D_MAC	0x00010U
-#define OPT_H_LENGTH	0x00020U
-#define OPT_P_LENGTH	0x00040U
-#define OPT_OPCODE	0x00080U
-#define OPT_H_TYPE	0x00100U
-#define OPT_P_TYPE	0x00200U
-#define OPT_JUMP	0x00400U
-#define OPT_VERBOSE	0x00800U
-#define OPT_VIANAMEIN	0x01000U
-#define OPT_VIANAMEOUT	0x02000U
-#define OPT_LINENUMBERS 0x04000U
-#define OPT_COUNTERS	0x08000U
 #define NUMBER_OF_OPT	16
 static const char optflags[NUMBER_OF_OPT]
 = { 'n', 's', 'd', 2, 3, 7, 8, 4, 5, 6, 'j', 'v', 'i', 'o', '0', 'c'};
@@ -747,14 +730,14 @@ int do_commandarp(struct nft_handle *h, int argc, char *argv[], char **table,
 			break;
 		case 's':
 			check_inverse(optarg, &invert, &optind, argc);
-			set_option(&options, OPT_S_IP, &cs.arp.arp.invflags,
+			set_option(&options, OPT_SOURCE, &cs.arp.arp.invflags,
 				   invert);
 			shostnetworkmask = argv[optind-1];
 			break;
 
 		case 'd':
 			check_inverse(optarg, &invert, &optind, argc);
-			set_option(&options, OPT_D_IP, &cs.arp.arp.invflags,
+			set_option(&options, OPT_DESTINATION, &cs.arp.arp.invflags,
 				   invert);
 			dhostnetworkmask = argv[optind-1];
 			break;
@@ -965,9 +948,9 @@ int do_commandarp(struct nft_handle *h, int argc, char *argv[], char **table,
 			      "nothing appropriate following !");
 
 	if (command & (CMD_REPLACE | CMD_INSERT | CMD_DELETE | CMD_APPEND)) {
-		if (!(options & OPT_D_IP))
+		if (!(options & OPT_DESTINATION))
 			dhostnetworkmask = "0.0.0.0/0";
-		if (!(options & OPT_S_IP))
+		if (!(options & OPT_SOURCE))
 			shostnetworkmask = "0.0.0.0/0";
 	}
 
-- 
2.23.0

