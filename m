Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FAC578628
	for <lists+netfilter-devel@lfdr.de>; Mon, 18 Jul 2022 17:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233634AbiGRPVS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 18 Jul 2022 11:21:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235306AbiGRPVS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 18 Jul 2022 11:21:18 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC17E25E86
        for <netfilter-devel@vger.kernel.org>; Mon, 18 Jul 2022 08:21:17 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] cache: report an error message if cache initialization fails
Date:   Mon, 18 Jul 2022 17:21:00 +0200
Message-Id: <20220718152100.591117-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

cache initialization failure (which should not ever happen) is not
reported to the user.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/cache.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/cache.c b/src/cache.c
index 2e1bcfcece57..da72dc909096 100644
--- a/src/cache.c
+++ b/src/cache.c
@@ -1180,7 +1180,11 @@ replay:
 			goto replay;
 		}
 
+		erec_queue(error(&netlink_location, "cache initialization failed: %s",
+				 strerror(errno)),
+			   msgs);
 		nft_cache_release(cache);
+
 		return -1;
 	}
 
-- 
2.30.2

