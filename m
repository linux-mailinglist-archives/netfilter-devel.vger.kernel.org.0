Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5147375A9
	for <lists+netfilter-devel@lfdr.de>; Tue, 20 Jun 2023 22:08:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbjFTUIu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 20 Jun 2023 16:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjFTUIs (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 20 Jun 2023 16:08:48 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39833FE
        for <netfilter-devel@vger.kernel.org>; Tue, 20 Jun 2023 13:08:43 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qBhea-0004dx-NT; Tue, 20 Jun 2023 22:08:40 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft] src: avoid IPPROTO_MAX for array definitions
Date:   Tue, 20 Jun 2023 22:08:36 +0200
Message-Id: <20230620200836.22041-1-fw@strlen.de>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

ip header can only accomodate 8but value, but IPPROTO_MAX has been bumped
due to uapi reasons to support MPTCP (262, which is used to toggle on
multipath support in tcp).

This results in:
exthdr.c:349:11: warning: result of comparison of constant 263 with expression of type 'uint8_t' (aka 'unsigned char') is always true [-Wtautological-constant-out-of-range-compare]
if (type < array_size(exthdr_protocols))
            ~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~

redude array sizes back to what can be used on-wire.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 include/rule.h | 2 +-
 src/exthdr.c   | 5 ++---
 src/rule.c     | 2 +-
 3 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/rule.h b/include/rule.h
index b360e2614c78..5cb549c2e14e 100644
--- a/include/rule.h
+++ b/include/rule.h
@@ -786,7 +786,7 @@ struct timeout_protocol {
 	uint32_t *dflt_timeout;
 };
 
-extern struct timeout_protocol timeout_protocol[IPPROTO_MAX];
+extern struct timeout_protocol timeout_protocol[UINT8_MAX + 1];
 extern int timeout_str2num(uint16_t l4proto, struct timeout_state *ts);
 
 #endif /* NFTABLES_RULE_H */
diff --git a/src/exthdr.c b/src/exthdr.c
index d0274bea6ca0..f5527ddb4a3f 100644
--- a/src/exthdr.c
+++ b/src/exthdr.c
@@ -289,7 +289,7 @@ struct stmt *exthdr_stmt_alloc(const struct location *loc,
 	return stmt;
 }
 
-static const struct exthdr_desc *exthdr_protocols[IPPROTO_MAX] = {
+static const struct exthdr_desc *exthdr_protocols[UINT8_MAX + 1] = {
 	[IPPROTO_HOPOPTS]	= &exthdr_hbh,
 	[IPPROTO_ROUTING]	= &exthdr_rt,
 	[IPPROTO_FRAGMENT]	= &exthdr_frag,
@@ -346,8 +346,7 @@ void exthdr_init_raw(struct expr *expr, uint8_t type,
 	expr->exthdr.offset = offset;
 	expr->exthdr.desc = NULL;
 
-	if (type < array_size(exthdr_protocols))
-		expr->exthdr.desc = exthdr_protocols[type];
+	expr->exthdr.desc = exthdr_protocols[type];
 
 	if (expr->exthdr.desc == NULL)
 		goto out;
diff --git a/src/rule.c b/src/rule.c
index 3704600a87be..19d681bb74b3 100644
--- a/src/rule.c
+++ b/src/rule.c
@@ -76,7 +76,7 @@ static uint32_t udp_dflt_timeout[] = {
 	[NFTNL_CTTIMEOUT_UDP_REPLIED]		= 120,
 };
 
-struct timeout_protocol timeout_protocol[IPPROTO_MAX] = {
+struct timeout_protocol timeout_protocol[UINT8_MAX + 1] = {
 	[IPPROTO_TCP]	= {
 		.array_size	= NFTNL_CTTIMEOUT_TCP_MAX,
 		.state_to_name	= tcp_state_to_name,
-- 
2.39.3

