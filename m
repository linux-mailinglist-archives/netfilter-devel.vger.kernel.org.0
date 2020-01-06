Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0A1713120C
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 13:20:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgAFMU0 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jan 2020 07:20:26 -0500
Received: from correo.us.es ([193.147.175.20]:43670 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726173AbgAFMU0 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:20:26 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3D05EF2DF2
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jan 2020 13:20:24 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2F3B2DA712
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jan 2020 13:20:24 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2406BDA702; Mon,  6 Jan 2020 13:20:24 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1E0B1DA702;
        Mon,  6 Jan 2020 13:20:22 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 Jan 2020 13:20:22 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 02C3A41E4800;
        Mon,  6 Jan 2020 13:20:21 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH 1/7] nft: do not check for existing chain from parser
Date:   Mon,  6 Jan 2020 13:20:12 +0100
Message-Id: <20200106122018.14090-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200106122018.14090-1-pablo@netfilter.org>
References: <20200106122018.14090-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Follow up patches split the parser from the cache calculation.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/tests/shell/testcases/ip6tables/0004-return-codes_0 | 2 +-
 iptables/tests/shell/testcases/iptables/0004-return-codes_0  | 2 +-
 iptables/xtables.c                                           | 5 -----
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/iptables/tests/shell/testcases/ip6tables/0004-return-codes_0 b/iptables/tests/shell/testcases/ip6tables/0004-return-codes_0
index f023b7915498..3124cfd86317 100755
--- a/iptables/tests/shell/testcases/ip6tables/0004-return-codes_0
+++ b/iptables/tests/shell/testcases/ip6tables/0004-return-codes_0
@@ -31,7 +31,7 @@ cmd 1 ip6tables -A noexist -j ACCEPT
 cmd 0 ip6tables -C INPUT -j ACCEPT
 cmd 1 ip6tables -C FORWARD -j ACCEPT
 cmd 1 ip6tables -C nonexist -j ACCEPT
-cmd 2 ip6tables -C INPUT -j foobar
+cmd 1 ip6tables -C INPUT -j foobar
 cmd 2 ip6tables -C INPUT -m foobar -j ACCEPT
 cmd 3 ip6tables -t foobar -C INPUT -j ACCEPT
 
diff --git a/iptables/tests/shell/testcases/iptables/0004-return-codes_0 b/iptables/tests/shell/testcases/iptables/0004-return-codes_0
index ce02e0bcb128..136eab83a679 100755
--- a/iptables/tests/shell/testcases/iptables/0004-return-codes_0
+++ b/iptables/tests/shell/testcases/iptables/0004-return-codes_0
@@ -75,7 +75,7 @@ cmd 2 "$ENOMTH" iptables -C INPUT -m foobar -j ACCEPT
 # messages of those don't match, but iptables-nft ones are actually nicer.
 #cmd 2 "$ENOTGT" iptables -C INPUT -j foobar
 #cmd 3 "$ENOTBL" iptables -t foobar -C INPUT -j ACCEPT
-cmd 2 "" iptables -C INPUT -j foobar
+cmd 1 "" iptables -C INPUT -j foobar
 cmd 3 "" iptables -t foobar -C INPUT -j ACCEPT
 
 exit $global_rc
diff --git a/iptables/xtables.c b/iptables/xtables.c
index 8f9dc628d002..260fb97b3b11 100644
--- a/iptables/xtables.c
+++ b/iptables/xtables.c
@@ -1031,11 +1031,6 @@ void do_parse(struct nft_handle *h, int argc, char *argv[],
 					   opt2char(OPT_VIANAMEIN),
 					   p->chain);
 		}
-
-		if (!p->xlate && !cs->target && strlen(cs->jumpto) > 0 &&
-		    !nft_chain_exists(h, p->table, cs->jumpto))
-			xtables_error(PARAMETER_PROBLEM,
-				      "Chain '%s' does not exist", cs->jumpto);
 	}
 }
 
-- 
2.11.0

