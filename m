Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0391F0D91
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Jun 2020 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgFGSEw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Jun 2020 14:04:52 -0400
Received: from correo.us.es ([193.147.175.20]:39174 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726714AbgFGSEw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Jun 2020 14:04:52 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 5F49411D163
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:51 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 524DEDA72F
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:51 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 47FE8DA722; Sun,  7 Jun 2020 20:04:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,URIBL_BLOCKED,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 1F37ADA73D
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:49 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 07 Jun 2020 20:04:49 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from localhost.localdomain (unknown [90.77.255.23])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 0260C41E4800
        for <netfilter-devel@vger.kernel.org>; Sun,  7 Jun 2020 20:04:48 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 2/2] meta: fix asan runtime error in tc handle
Date:   Sun,  7 Jun 2020 20:04:44 +0200
Message-Id: <20200607180444.17736-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200607180444.17736-1-pablo@netfilter.org>
References: <20200607180444.17736-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

 meta.c:92:17: runtime error: left shift of 34661 by 16 places cannot be represented in type 'int'

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/meta.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/meta.c b/src/meta.c
index acc348eb264d..d92d0d323b9b 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -73,7 +73,7 @@ static struct error_record *tchandle_type_parse(struct parse_ctx *ctx,
 	else if (strcmp(sym->identifier, "none") == 0)
 		handle = TC_H_UNSPEC;
 	else if (strchr(sym->identifier, ':')) {
-		uint16_t tmp;
+		uint32_t tmp;
 		char *colon;
 
 		str = xstrdup(sym->identifier);
-- 
2.20.1

