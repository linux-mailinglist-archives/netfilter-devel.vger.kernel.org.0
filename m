Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEB3481ED
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 14:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFQMZ2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 08:25:28 -0400
Received: from mail.us.es ([193.147.175.20]:46332 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbfFQMZ2 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 08:25:28 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3A84CC1D6C
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 14:25:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2A60ADA715
        for <netfilter-devel@vger.kernel.org>; Mon, 17 Jun 2019 14:25:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 2748CDA712; Mon, 17 Jun 2019 14:25:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 59E79DA710;
        Mon, 17 Jun 2019 14:25:23 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 17 Jun 2019 14:25:23 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 2711A4265A2F;
        Mon, 17 Jun 2019 14:25:23 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc, fw@strlen.de
Subject: [PATCH nft 2/5] tests: shell: cannot use handle for non-existing rule in kernel
Date:   Mon, 17 Jun 2019 14:25:15 +0200
Message-Id: <20190617122518.10486-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190617122518.10486-1-pablo@netfilter.org>
References: <20190617122518.10486-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This test invokes the 'replace rule ... handle 2' command. However,
there are no rules in the kernel, therefore it always fails.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 tests/shell/testcases/nft-f/0006action_object_0 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/shell/testcases/nft-f/0006action_object_0 b/tests/shell/testcases/nft-f/0006action_object_0
index ffa6c9bda973..fab3070f493f 100755
--- a/tests/shell/testcases/nft-f/0006action_object_0
+++ b/tests/shell/testcases/nft-f/0006action_object_0
@@ -16,7 +16,7 @@ generate1()
 	add set $family t s {type inet_service;}
 	add element $family t s {8080}
 	insert rule $family t c meta l4proto tcp tcp dport @s accept
-	replace rule $family t c handle 2 meta l4proto tcp tcp dport {9090, 8080}
+	add rule $family t c meta l4proto tcp tcp dport {9090, 8080}
 	add map $family t m {type inet_service:verdict;}
 	add element $family t m {10080:drop}
 	insert rule $family t c meta l4proto tcp tcp dport vmap @m
-- 
2.11.0

