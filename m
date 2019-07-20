Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4916F6F002
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 18:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfGTQal (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 12:30:41 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40880 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbfGTQal (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:30:41 -0400
Received: from localhost ([::1]:53970 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hosFs-0005Rc-1L; Sat, 20 Jul 2019 18:30:40 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 09/12] xtables-save: Make COMMIT line optional
Date:   Sat, 20 Jul 2019 18:30:23 +0200
Message-Id: <20190720163026.15410-10-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720163026.15410-1-phil@nwl.cc>
References: <20190720163026.15410-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Change xtables_save_main to support optional printing of COMMIT line as
it is not used in arp- or ebtables.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-save.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/iptables/xtables-save.c b/iptables/xtables-save.c
index b4d14b5bcd016..249b396091af4 100644
--- a/iptables/xtables-save.c
+++ b/iptables/xtables-save.c
@@ -67,6 +67,7 @@ static bool ebt_legacy_counter_format;
 
 struct do_output_data {
 	bool counters;
+	bool commit;
 };
 
 static int
@@ -98,7 +99,8 @@ __do_output(struct nft_handle *h, const char *tablename, void *data)
 	 * thereby preventing dependency conflicts */
 	nft_chain_save(h, chain_list);
 	nft_rule_save(h, tablename, d->counters ? 0 : FMT_NOCOUNTS);
-	printf("COMMIT\n");
+	if (d->commit)
+		printf("COMMIT\n");
 
 	now = time(NULL);
 	printf("# Completed on %s", ctime(&now));
@@ -219,6 +221,7 @@ xtables_save_main(int family, int argc, char *argv[],
 		init_extensions4();
 #endif
 		tables = xtables_ipv4;
+		d.commit = true;
 		break;
 	case NFPROTO_ARP:
 		tables = xtables_arp;
-- 
2.22.0

