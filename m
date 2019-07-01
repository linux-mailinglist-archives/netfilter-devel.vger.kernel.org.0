Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 343C25C265
	for <lists+netfilter-devel@lfdr.de>; Mon,  1 Jul 2019 19:58:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbfGAR61 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 1 Jul 2019 13:58:27 -0400
Received: from mail.us.es ([193.147.175.20]:43964 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbfGAR60 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 1 Jul 2019 13:58:26 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 0760D11F024
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:25 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id ECAE0DA732
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:24 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id E2336DA708; Mon,  1 Jul 2019 19:58:24 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id B71A5DA732
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:22 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Mon, 01 Jul 2019 19:58:22 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id 952C34265A31
        for <netfilter-devel@vger.kernel.org>; Mon,  1 Jul 2019 19:58:22 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/3] parser_bison: do not enforce semicolon from ct helper block
Date:   Mon,  1 Jul 2019 19:58:17 +0200
Message-Id: <20190701175819.5558-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use the statement separator rule, since newline is also valid.

Fixes: c7c94802679c ("src: add ct timeout support")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 4f2e34752fa9..153ef326ffe7 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -3516,7 +3516,7 @@ timeout_state		:	STRING	COLON	NUM
 			}
 			;
 
-ct_timeout_config	:	PROTOCOL	ct_l4protoname	SEMICOLON
+ct_timeout_config	:	PROTOCOL	ct_l4protoname	stmt_separator
 			{
 				struct ct_timeout *ct;
 				int l4proto = $2;
-- 
2.11.0

