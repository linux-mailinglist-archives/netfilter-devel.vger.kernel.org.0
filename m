Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2E0AF27E
	for <lists+netfilter-devel@lfdr.de>; Tue, 10 Sep 2019 23:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbfIJVNJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 10 Sep 2019 17:13:09 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:44990 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfIJVNJ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 10 Sep 2019 17:13:09 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1i7nRj-0000X4-DA; Tue, 10 Sep 2019 23:13:07 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Arturo Borrero Gonzalez <arturo@netfilter.org>
Subject: [PATCH ebtables-nft] ebtables: fix over-eager -o checks on custom chains
Date:   Tue, 10 Sep 2019 23:10:59 +0200
Message-Id: <20190910211059.9872-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Arturo reports ebtables-nft reports an error when -o is
used in custom chains:

-A MYCHAIN -o someif
makes ebtables-nft exit with an error:
"Use -o only in OUTPUT, FORWARD and POSTROUTING chains."

Problem is that all the "-o" checks expect <= NF_BR_POST_ROUTING
to mean "builtin", so -1 mistakenly leads to the checks being active.

Reported-by: Arturo Borrero Gonzalez <arturo@netfilter.org>
Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1347
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 iptables/xtables-eb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/iptables/xtables-eb.c b/iptables/xtables-eb.c
index 121ecbecd0b6..3b03daef28eb 100644
--- a/iptables/xtables-eb.c
+++ b/iptables/xtables-eb.c
@@ -197,7 +197,8 @@ int ebt_get_current_chain(const char *chain)
 	else if (strcmp(chain, "POSTROUTING") == 0)
 		return NF_BR_POST_ROUTING;
 
-	return -1;
+	/* placeholder for user defined chain */
+	return NF_BR_NUMHOOKS;
 }
 
 /*
@@ -1223,7 +1224,7 @@ print_zero:
 	cs.eb.ethproto = htons(cs.eb.ethproto);
 
 	if (command == 'P') {
-		if (selected_chain < 0) {
+		if (selected_chain >= NF_BR_NUMHOOKS) {
 			ret = ebt_set_user_chain_policy(h, *table, chain, policy);
 		} else {
 			if (strcmp(policy, "RETURN") == 0) {
-- 
2.21.0

