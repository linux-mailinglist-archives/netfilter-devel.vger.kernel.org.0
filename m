Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6448123EF69
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Aug 2020 16:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgHGOvU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Aug 2020 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgHGOvK (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Aug 2020 10:51:10 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82304C061756
        for <netfilter-devel@vger.kernel.org>; Fri,  7 Aug 2020 07:51:08 -0700 (PDT)
Received: from localhost ([::1]:60268 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1k43i5-0007Cg-D7; Fri, 07 Aug 2020 16:51:05 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] xtables-monitor: Fix ip6tables rule printing
Date:   Fri,  7 Aug 2020 16:51:00 +0200
Message-Id: <20200807145100.21340-1-phil@nwl.cc>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When printing an ip6tables rule event, false family ops are used as they
are initially looked up for AF_INET and reused no matter the current
rule's family. In practice, this means that nft_rule_print_save() calls
the wrong rule_to_cs, save_rule and clear_cs callbacks. Therefore, if a
rule specifies a source or destination address, the address is not
printed.

Fix this by performing a family lookup each time rule_cb is called.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/xtables-monitor.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/iptables/xtables-monitor.c b/iptables/xtables-monitor.c
index 57def83e2eea0..4008cc00d4694 100644
--- a/iptables/xtables-monitor.c
+++ b/iptables/xtables-monitor.c
@@ -93,6 +93,8 @@ static int rule_cb(const struct nlmsghdr *nlh, void *data)
 	if (arg->nfproto && arg->nfproto != family)
 		goto err_free;
 
+	arg->h->ops = nft_family_ops_lookup(family);
+
 	if (arg->is_event)
 		printf(" EVENT: ");
 	switch (family) {
-- 
2.27.0

