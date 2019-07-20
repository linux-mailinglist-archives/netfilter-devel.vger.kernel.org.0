Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F306F001
	for <lists+netfilter-devel@lfdr.de>; Sat, 20 Jul 2019 18:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfGTQag (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 20 Jul 2019 12:30:36 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:40874 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbfGTQag (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 20 Jul 2019 12:30:36 -0400
Received: from localhost ([::1]:53964 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hosFm-0005RD-NY; Sat, 20 Jul 2019 18:30:34 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH 05/12] xtables-save: Fix table compatibility check
Date:   Sat, 20 Jul 2019 18:30:19 +0200
Message-Id: <20190720163026.15410-6-phil@nwl.cc>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190720163026.15410-1-phil@nwl.cc>
References: <20190720163026.15410-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The builtin table check guarding the 'is incompatible' warning was
wrong: The idea was to print the warning only for incompatible tables
which are builtin, not for others. Yet the code would print the warning
only for non-builtin ones.

Also reorder the checks: nft_table_builtin_find() is fast and therefore
a quick way to bail for uninteresting tables. The compatibility check is
needed for the remaining tables, only.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-save.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/iptables/xtables-save.c b/iptables/xtables-save.c
index 0cf11f998cc77..811ec6330a4cb 100644
--- a/iptables/xtables-save.c
+++ b/iptables/xtables-save.c
@@ -67,11 +67,12 @@ __do_output(struct nft_handle *h, const char *tablename, bool counters)
 {
 	struct nftnl_chain_list *chain_list;
 
+	if (!nft_table_builtin_find(h, tablename))
+		return 0;
 
 	if (!nft_is_table_compatible(h, tablename)) {
-		if (!nft_table_builtin_find(h, tablename))
-			printf("# Table `%s' is incompatible, use 'nft' tool.\n",
-			       tablename);
+		printf("# Table `%s' is incompatible, use 'nft' tool.\n",
+		       tablename);
 		return 0;
 	}
 
-- 
2.22.0

