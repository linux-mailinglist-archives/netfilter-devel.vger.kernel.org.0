Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9AE2273BF
	for <lists+netfilter-devel@lfdr.de>; Tue, 21 Jul 2020 02:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgGUAY1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jul 2020 20:24:27 -0400
Received: from correo.us.es ([193.147.175.20]:38624 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726567AbgGUAY1 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jul 2020 20:24:27 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id A793FC4800
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:24:26 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 9AD84DA722
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:24:26 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 90752DA73D; Tue, 21 Jul 2020 02:24:26 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 831ADDA722
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:24:24 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Tue, 21 Jul 2020 02:24:24 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 689224265A32
        for <netfilter-devel@vger.kernel.org>; Tue, 21 Jul 2020 02:24:24 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] rule: missing map command expansion
Date:   Tue, 21 Jul 2020 02:24:21 +0200
Message-Id: <20200721002421.5811-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Maps also need to be split in two commands for proper error reporting.

Fixes: c9eae091983a ("src: add CMD_OBJ_SETELEMS")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/rule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/rule.c b/src/rule.c
index 6b71dfee0d09..dadb26f85567 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -1519,6 +1519,7 @@ void nft_cmd_expand(struct cmd *cmd)
 		list_splice(&new_cmds, &cmd->list);
 		break;
 	case CMD_OBJ_SET:
+	case CMD_OBJ_MAP:
 		set = cmd->set;
 		memset(&h, 0, sizeof(h));
 		handle_merge(&h, &set->handle);
-- 
2.20.1

