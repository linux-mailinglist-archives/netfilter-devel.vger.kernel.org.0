Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485B3552454
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 Jun 2022 20:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239909AbiFTS6S (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 20 Jun 2022 14:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiFTS6R (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 20 Jun 2022 14:58:17 -0400
Received: from vulcan.natalenko.name (vulcan.natalenko.name [IPv6:2001:19f0:6c00:8846:5400:ff:fe0c:dfa0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9AD10DE
        for <netfilter-devel@vger.kernel.org>; Mon, 20 Jun 2022 11:58:15 -0700 (PDT)
Received: from localhost (unknown [83.148.33.151])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vulcan.natalenko.name (Postfix) with ESMTPSA id 382D1F4F758;
        Mon, 20 Jun 2022 20:58:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=natalenko.name;
        s=dkim-20170712; t=1655751489;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=50KQXQrYGixw6cuzqBruy6RRnic0+aalmXbgeUxVvpw=;
        b=KHedDCuEhV2KK70AiPrHMhudApxj4SfCUQtAl//ZYuXU2IgSP2awN0JdEh+y9Oy3b7h8GW
        CcYLTtx/AbFukTI+43gLkV+fAA4ESEVCZLy9AZivvi8dzkQKWU87TX8GzrZHR2l44ZT8Rz
        hD17uipMTn/Zn5/7YZf2BgiK6CT55TI=
From:   Oleksandr Natalenko <oleksandr@natalenko.name>
To:     netfilter-devel@vger.kernel.org
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        Loganaden Velvindron <logan@cyberstorm.mu>
Subject: [PATCH] src: proto: support DF, LE, VA for DSCP
Date:   Mon, 20 Jun 2022 20:58:07 +0200
Message-Id: <20220620185807.968658-1-oleksandr@natalenko.name>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add a couple of aliases for well-known DSCP values.

As per RFC 4594, add "df" as an alias of "cs0" with 0x00 value.

As per RFC 5865, add "va" for VOICE-ADMIT with 0x2c value.

As per RFC 8622, add "le" for Lower-Effort with 0x01 value.

tc-cake(8) in diffserv8 mode would benefit from having "le" alias since
it corresponds to "Tin 0".

Signed-off-by: Oleksandr Natalenko <oleksandr@natalenko.name>
---
 src/proto.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/proto.c b/src/proto.c
index a013a00d..84555b9e 100644
--- a/src/proto.c
+++ b/src/proto.c
@@ -684,7 +684,9 @@ static const struct symbol_table dscp_type_tbl = {
 		SYMBOL("cs5",	0x28),
 		SYMBOL("cs6",	0x30),
 		SYMBOL("cs7",	0x38),
+		SYMBOL("df",	0x00),
 		SYMBOL("be",	0x00),
+		SYMBOL("le",	0x01),
 		SYMBOL("af11",	0x0a),
 		SYMBOL("af12",	0x0c),
 		SYMBOL("af13",	0x0e),
@@ -697,6 +699,7 @@ static const struct symbol_table dscp_type_tbl = {
 		SYMBOL("af41",	0x22),
 		SYMBOL("af42",	0x24),
 		SYMBOL("af43",	0x26),
+		SYMBOL("va",	0x2c),
 		SYMBOL("ef",	0x2e),
 		SYMBOL_LIST_END
 	},
-- 
2.36.1

