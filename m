Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A723B1930
	for <lists+netfilter-devel@lfdr.de>; Wed, 23 Jun 2021 13:43:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFWLqM (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 23 Jun 2021 07:46:12 -0400
Received: from mail.netfilter.org ([217.70.188.207]:60576 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbhFWLqM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 23 Jun 2021 07:46:12 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 3B56A6423C
        for <netfilter-devel@vger.kernel.org>; Wed, 23 Jun 2021 13:42:29 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] parser_bison: memleak in rate limit parser
Date:   Wed, 23 Jun 2021 13:43:50 +0200
Message-Id: <20210623114350.1401-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Direct leak of 13 byte(s) in 1 object(s) allocated from:
    #0 0x7fb49ad79810 in strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3a810)
    #1 0x7fb496b8f63a in xstrdup /home/pablo/nftables/src/utils.c:85
    #2 0x7fb496c9a79d in nft_lex /home/pablo/nftables/src/scanner.l:740
    [...]

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index e405c80af1ff..872d7cdb92ad 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -4553,6 +4553,7 @@ limit_config		:	RATE	limit_mode	NUM	SLASH	time_unit	limit_burst_pkts
 				uint64_t rate, unit;
 
 				erec = rate_parse(&@$, $4, &rate, &unit);
+				xfree($4);
 				if (erec != NULL) {
 					erec_queue(erec, state->msgs);
 					YYERROR;
-- 
2.20.1

