Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 764FC5C13E
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 18:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbfGAQjA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 12:39:00 -0400
Received: from mail.us.es ([193.147.175.20]:43694 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729264AbfGAQjA (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:39:00 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 1EA22FFB6D
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 18:38:57 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 10AC591E1
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 18:38:57 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 0629ADA4CA; Mon,  1 Jul 2019 18:38:57 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id EC534DA801;
        Mon,  1 Jul 2019 18:38:54 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Jul 2019 18:38:54 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id B9C9C4265A31;
        Mon,  1 Jul 2019 18:38:54 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     nevola@gmail.com, phil@nwl.cc
Subject: [PATCH nft 1/2] monitor: fix double cache update with --echo
Date:   Mon,  1 Jul 2019 18:38:50 +0200
Message-Id: <20190701163851.11200-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The evaluation step already updates the cache for each command in this
batch. There is no need to update the cache again from the echo path,
otherwise the cache is populated twice with the same object.

Fixes: b99c4d072d99 ("Implement --echo option")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
This fixes a crash when combining -f and -e, the follow up patch
introduces a test for such combination.

 src/monitor.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/monitor.c b/src/monitor.c
index a68d960bfd4e..5b25c9d4854e 100644
--- a/src/monitor.c
+++ b/src/monitor.c
@@ -900,7 +900,6 @@ int netlink_echo_callback(const struct nlmsghdr *nlh, void *data)
 		.ctx = ctx,
 		.loc = &netlink_location,
 		.monitor_flags = 0xffffffff,
-		.cache_needed = true,
 	};
 
 	if (!nft_output_echo(&echo_monh.ctx->nft->output))
-- 
2.11.0

