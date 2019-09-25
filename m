Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD42BE71B
	for <lists+netfilter-devel@lfdr.de>; Wed, 25 Sep 2019 23:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbfIYV1h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 25 Sep 2019 17:27:37 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:45878 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbfIYV1h (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 25 Sep 2019 17:27:37 -0400
Received: from localhost ([::1]:58968 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iDEoy-0005HB-Br; Wed, 25 Sep 2019 23:27:36 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH v2 04/24] nft: Fix for add and delete of same rule in single batch
Date:   Wed, 25 Sep 2019 23:25:45 +0200
Message-Id: <20190925212605.1005-5-phil@nwl.cc>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190925212605.1005-1-phil@nwl.cc>
References: <20190925212605.1005-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Another corner-case found when extending restore ordering test: If a
delete command in a dump referenced a rule added earlier within the same
dump, kernel would reject the resulting NFT_MSG_DELRULE command.

Catch this by assigning the rule to delete a RULE_ID value if it doesn't
have a handle yet. Since __nft_rule_del() does not duplicate the
nftnl_rule object when creating the NFT_COMPAT_RULE_DELETE command, this
RULE_ID value is added to both NEWRULE and DELRULE commands - exactly
what is needed to establish the reference.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 iptables/nft.c                                 |  3 +++
 .../ipt-restore/0003-restore-ordering_0        | 18 +++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/iptables/nft.c b/iptables/nft.c
index 90bb0c63c025a..255e51b4d2275 100644
--- a/iptables/nft.c
+++ b/iptables/nft.c
@@ -2199,6 +2199,9 @@ static int __nft_rule_del(struct nft_handle *h, struct nftnl_rule *r)
 
 	nftnl_rule_list_del(r);
 
+	if (!nftnl_rule_get_u64(r, NFTNL_RULE_HANDLE))
+		nftnl_rule_set_u32(r, NFTNL_RULE_ID, ++h->rule_id);
+
 	obj = batch_rule_add(h, NFT_COMPAT_RULE_DELETE, r);
 	if (!obj) {
 		nftnl_rule_free(r);
diff --git a/iptables/tests/shell/testcases/ipt-restore/0003-restore-ordering_0 b/iptables/tests/shell/testcases/ipt-restore/0003-restore-ordering_0
index 51f2422e15259..3f1d229e915ff 100755
--- a/iptables/tests/shell/testcases/ipt-restore/0003-restore-ordering_0
+++ b/iptables/tests/shell/testcases/ipt-restore/0003-restore-ordering_0
@@ -14,7 +14,7 @@ ipt_show() {
 
 $XT_MULTI iptables-restore <<EOF
 *filter
--A FORWARD -m comment --comment "appended rule" -j ACCEPT
+-A FORWARD -m comment --comment "rule 4" -j ACCEPT
 -I FORWARD 1 -m comment --comment "rule 1" -j ACCEPT
 -I FORWARD 2 -m comment --comment "rule 2" -j ACCEPT
 -I FORWARD 3 -m comment --comment "rule 3" -j ACCEPT
@@ -24,7 +24,7 @@ EOF
 EXPECT='-A FORWARD -m comment --comment "rule 1" -j ACCEPT
 -A FORWARD -m comment --comment "rule 2" -j ACCEPT
 -A FORWARD -m comment --comment "rule 3" -j ACCEPT
--A FORWARD -m comment --comment "appended rule" -j ACCEPT'
+-A FORWARD -m comment --comment "rule 4" -j ACCEPT'
 
 diff -u -Z <(echo -e "$EXPECT") <(ipt_show)
 
@@ -32,11 +32,14 @@ diff -u -Z <(echo -e "$EXPECT") <(ipt_show)
 
 $XT_MULTI iptables-restore --noflush <<EOF
 *filter
+-A FORWARD -m comment --comment "rule 5" -j ACCEPT
 -I FORWARD 1 -m comment --comment "rule 0.5" -j ACCEPT
 -I FORWARD 3 -m comment --comment "rule 1.5" -j ACCEPT
 -I FORWARD 5 -m comment --comment "rule 2.5" -j ACCEPT
 -I FORWARD 7 -m comment --comment "rule 3.5" -j ACCEPT
--I FORWARD 9 -m comment --comment "appended rule 2" -j ACCEPT
+-I FORWARD 9 -m comment --comment "rule 4.5" -j ACCEPT
+-I FORWARD 11 -m comment --comment "rule 5.5" -j ACCEPT
+-A FORWARD -m comment --comment "rule 6" -j ACCEPT
 COMMIT
 EOF
 
@@ -47,8 +50,11 @@ EXPECT='-A FORWARD -m comment --comment "rule 0.5" -j ACCEPT
 -A FORWARD -m comment --comment "rule 2.5" -j ACCEPT
 -A FORWARD -m comment --comment "rule 3" -j ACCEPT
 -A FORWARD -m comment --comment "rule 3.5" -j ACCEPT
--A FORWARD -m comment --comment "appended rule" -j ACCEPT
--A FORWARD -m comment --comment "appended rule 2" -j ACCEPT'
+-A FORWARD -m comment --comment "rule 4" -j ACCEPT
+-A FORWARD -m comment --comment "rule 4.5" -j ACCEPT
+-A FORWARD -m comment --comment "rule 5" -j ACCEPT
+-A FORWARD -m comment --comment "rule 5.5" -j ACCEPT
+-A FORWARD -m comment --comment "rule 6" -j ACCEPT'
 
 diff -u -Z <(echo -e "$EXPECT") <(ipt_show)
 
@@ -78,6 +84,8 @@ diff -u -Z <(echo -e "$EXPECT") <(ipt_show)
 
 $XT_MULTI iptables-restore --noflush <<EOF
 *filter
+-A FORWARD -m comment --comment "appended rule 4" -j ACCEPT
+-D FORWARD 7
 -D FORWARD -m comment --comment "appended rule 1" -j ACCEPT
 -D FORWARD 3
 -I FORWARD 3 -m comment --comment "manually replaced rule 2" -j ACCEPT
-- 
2.23.0

