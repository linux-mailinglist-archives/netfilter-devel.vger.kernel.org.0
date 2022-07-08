Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F414056B84F
	for <lists+netfilter-devel@lfdr.de>; Fri,  8 Jul 2022 13:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237748AbiGHLSd (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 8 Jul 2022 07:18:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237836AbiGHLS3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:18:29 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BBFF8DEFF
        for <netfilter-devel@vger.kernel.org>; Fri,  8 Jul 2022 04:18:28 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     mikhail.sennikovskii@ionos.com
Subject: [PATCH conntrack-tools 2/3] conntrack: use IPPROTO_RAW
Date:   Fri,  8 Jul 2022 13:18:20 +0200
Message-Id: <20220708111821.37783-2-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220708111821.37783-1-pablo@netfilter.org>
References: <20220708111821.37783-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

IPPROTO_MPTCP defeats the purpose of IPPROTO_MAX to check for the
maximum layer 4 protocol supported in the IP header.

Use IPPROTO_RAW (255) instead.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/conntrack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/conntrack.c b/src/conntrack.c
index 33f60239580f..4afccde4b027 100644
--- a/src/conntrack.c
+++ b/src/conntrack.c
@@ -840,7 +840,7 @@ static int parse_proto_num(const char *str)
 	long val;
 
 	val = strtol(str, &endptr, 0);
-	if (val >= IPPROTO_MAX ||
+	if (val > IPPROTO_RAW ||
 	    val < 0 ||
 	    endptr == str ||
 	    *endptr != '\0')
-- 
2.30.2

