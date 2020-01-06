Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A0F13120F
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Jan 2020 13:20:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgAFMUh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Jan 2020 07:20:37 -0500
Received: from correo.us.es ([193.147.175.20]:43696 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgAFMUh (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Jan 2020 07:20:37 -0500
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 3377BF2DFC
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jan 2020 13:20:35 +0100 (CET)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 2006ADA710
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Jan 2020 13:20:35 +0100 (CET)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 6D020DA738; Mon,  6 Jan 2020 13:20:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 717CBDA713;
        Mon,  6 Jan 2020 13:20:25 +0100 (CET)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 06 Jan 2020 13:20:25 +0100 (CET)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 4B78A41E4800;
        Mon,  6 Jan 2020 13:20:25 +0100 (CET)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH 7/7] nft: missing nft_fini() call in bridge family
Date:   Mon,  6 Jan 2020 13:20:18 +0100
Message-Id: <20200106122018.14090-8-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200106122018.14090-1-pablo@netfilter.org>
References: <20200106122018.14090-1-pablo@netfilter.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 iptables/xtables-eb-standalone.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/iptables/xtables-eb-standalone.c b/iptables/xtables-eb-standalone.c
index a9081c78c3bc..ff74ddbb3733 100644
--- a/iptables/xtables-eb-standalone.c
+++ b/iptables/xtables-eb-standalone.c
@@ -53,6 +53,8 @@ int xtables_eb_main(int argc, char *argv[])
 	if (ret)
 		ret = nft_bridge_commit(&h);
 
+	nft_fini(&h);
+
 	if (!ret)
 		fprintf(stderr, "ebtables: %s\n", nft_strerror(errno));
 
-- 
2.11.0

