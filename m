Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3202C7DF45A
	for <lists+netfilter-devel@lfdr.de>; Thu,  2 Nov 2023 14:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376664AbjKBNyD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 2 Nov 2023 09:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376635AbjKBNyD (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 2 Nov 2023 09:54:03 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:237:300::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248A6134
        for <netfilter-devel@vger.kernel.org>; Thu,  2 Nov 2023 06:54:00 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1qyY90-0007tL-D1; Thu, 02 Nov 2023 14:53:58 +0100
From:   Florian Westphal <fw@strlen.de>
To:     netfilter-devel <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>,
        Brian Davidson <davidson.brian@gmail.com>
Subject: [PATCH nft] meta: fix hour decoding when timezone offset is negative
Date:   Thu,  2 Nov 2023 14:53:40 +0100
Message-ID: <20231102135344.153380-1-fw@strlen.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Brian Davidson says:

 meta hour rules don't display properly after being created when the
 hour is on or after 00:00 UTC. The netlink debug looks correct for
 seconds past midnight UTC, but displaying the rules looks like an
 overflow or a byte order problem. I am in UTC-0400, so today, 20:00
 and later exhibits the problem, while 19:00 and earlier hours are
 fine.

meta.c only ever worked when the delta to UTC is positive.
We need to add in case the second counter turns negative after
offset adjustment.

Fixes: f8f32deda31d ("meta: Introduce new conditions 'time', 'day' and 'hour'")
Reported-by: Brian Davidson <davidson.brian@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/meta.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/meta.c b/src/meta.c
index b578d5e24c06..7846aefe7f5d 100644
--- a/src/meta.c
+++ b/src/meta.c
@@ -495,9 +495,16 @@ static void hour_type_print(const struct expr *expr, struct output_ctx *octx)
 
 	/* Obtain current tm, so that we can add tm_gmtoff */
 	ts = time(NULL);
-	if (ts != ((time_t) -1) && localtime_r(&ts, &cur_tm))
-		seconds = (seconds + cur_tm.tm_gmtoff) % SECONDS_PER_DAY;
+	if (ts != ((time_t) -1) && localtime_r(&ts, &cur_tm)) {
+		int32_t adj = seconds + cur_tm.tm_gmtoff;
 
+		if (adj < 0)
+			adj += SECONDS_PER_DAY;
+		else if (adj >= SECONDS_PER_DAY)
+			adj -= SECONDS_PER_DAY;
+
+		seconds = adj;
+	}
 	minutes = seconds / 60;
 	seconds %= 60;
 	hours = minutes / 60;
-- 
2.41.0

