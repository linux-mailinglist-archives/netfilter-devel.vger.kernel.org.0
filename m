Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8222927A3
	for <lists+netfilter-devel@lfdr.de>; Mon, 19 Oct 2020 14:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbgJSMuU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 19 Oct 2020 08:50:20 -0400
Received: from correo.us.es ([193.147.175.20]:35078 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726561AbgJSMuU (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 19 Oct 2020 08:50:20 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id CFF4B154E91
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Oct 2020 14:50:18 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id C1572DA73F
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Oct 2020 14:50:18 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id B6CEDDA73D; Mon, 19 Oct 2020 14:50:18 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WELCOMELIST,USER_IN_WHITELIST autolearn=disabled
        version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 6BDA6DA78C
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Oct 2020 14:50:16 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 19 Oct 2020 14:50:16 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPSA id 581474301DE4
        for <netfilter-devel@vger.kernel.org>; Mon, 19 Oct 2020 14:50:16 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] rule: larger number of error locations
Date:   Mon, 19 Oct 2020 14:50:11 +0200
Message-Id: <20201019125012.14373-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Statically store up to 32 locations per command, if the number of
locations is larger than 32, then skip rather than hit assertion.

Revisit this later to dynamically store location per command using a
hashtable.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/rule.h | 2 +-
 src/rule.c     | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/rule.h b/include/rule.h
index ffe8daab6f1c..10e71047fb07 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -666,7 +666,7 @@ struct monitor {
 struct monitor *monitor_alloc(uint32_t format, uint32_t type, const char *event);
 void monitor_free(struct monitor *m);
 
-#define NFT_NLATTR_LOC_MAX 8
+#define NFT_NLATTR_LOC_MAX 32
 
 /**
  * struct cmd - command statement
diff --git a/src/rule.c b/src/rule.c
index 4719fd6158f2..e57009b23c8e 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1475,7 +1475,9 @@ struct cmd *cmd_alloc(enum cmd_ops op, enum cmd_obj obj,
 
 void cmd_add_loc(struct cmd *cmd, uint16_t offset, struct location *loc)
 {
-	assert(cmd->num_attrs < NFT_NLATTR_LOC_MAX);
+	if (cmd->num_attrs > NFT_NLATTR_LOC_MAX)
+		return;
+
 	cmd->attr[cmd->num_attrs].offset = offset;
 	cmd->attr[cmd->num_attrs].location = loc;
 	cmd->num_attrs++;
-- 
2.20.1

