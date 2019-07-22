Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8996FD84
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jul 2019 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbfGVKQn (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 22 Jul 2019 06:16:43 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45450 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726846AbfGVKQn (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 22 Jul 2019 06:16:43 -0400
Received: from localhost ([::1]:58540 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hpVN4-0000bN-3H; Mon, 22 Jul 2019 12:16:42 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 08/11] xtables-save: Make COMMIT line optional
Date:   Mon, 22 Jul 2019 12:16:25 +0200
Message-Id: <20190722101628.21195-9-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190722101628.21195-1-phil@nwl.cc>
References: <20190722101628.21195-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Explicit commits are not used by either arp- nor ebtables-save. In order
to share code between all the different *-save tools without inducing
changes to ruleset dump contents, allow for callers of do_output() to
turn COMMIT lines on or off.

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

