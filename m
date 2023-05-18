Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54551707C9C
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 May 2023 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjERJSU (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 May 2023 05:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjERJST (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 May 2023 05:18:19 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 46009211B
        for <netfilter-devel@vger.kernel.org>; Thu, 18 May 2023 02:18:10 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH conntrackd 2/3] network: Fix -Wstrict-prototypes
Date:   Thu, 18 May 2023 11:18:02 +0200
Message-Id: <20230518091803.90494-4-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230518091803.90494-1-pablo@netfilter.org>
References: <20230518091803.90494-1-pablo@netfilter.org>
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

From: Sam James <sam@gentoo.org>

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1637
Signed-off-by: Sam James <sam@gentoo.org>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
posted via https://bugzilla.netfilter.org/show_bug.cgi?id=1637

 src/network.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/network.c b/src/network.c
index 13db37c96bb0..2560d97bab06 100644
--- a/src/network.c
+++ b/src/network.c
@@ -113,7 +113,7 @@ void nethdr_track_update_seq(uint32_t seq)
 	STATE_SYNC(last_seq_recv) = seq;
 }
 
-int nethdr_track_is_seq_set()
+int nethdr_track_is_seq_set(void)
 {
 	return local_seq_set;
 }
-- 
2.30.2

