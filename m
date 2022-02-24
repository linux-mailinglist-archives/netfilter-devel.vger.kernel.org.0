Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26F54C3615
	for <lists+netfilter-devel@lfdr.de>; Thu, 24 Feb 2022 20:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbiBXTql (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 24 Feb 2022 14:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiBXTql (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 24 Feb 2022 14:46:41 -0500
Received: from smtp.gentoo.org (smtp.gentoo.org [IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60789227581
        for <netfilter-devel@vger.kernel.org>; Thu, 24 Feb 2022 11:46:10 -0800 (PST)
From:   Sam James <sam@gentoo.org>
To:     netfilter-devel@vger.kernel.org
Cc:     Sam James <sam@gentoo.org>
Subject: [PATCH 1/2] libnftables.map: export new nft_ctx_{get,set}_optimize API
Date:   Thu, 24 Feb 2022 19:45:42 +0000
Message-Id: <20220224194543.59581-1-sam@gentoo.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Without this, we're not explicitly saying this is part of the public
API.

This new API was added in 1.0.2 and is used by e.g. the main
nft binary. Noticed when fixing the version-script option
(separate patch) which picked up this problem when .map
was missing symbols (related to when symbol visibility
options get set).

Signed-off-by: Sam James <sam@gentoo.org>
---
 src/libnftables.map | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/libnftables.map b/src/libnftables.map
index a511dd78..f8cf05dc 100644
--- a/src/libnftables.map
+++ b/src/libnftables.map
@@ -32,4 +32,6 @@ LIBNFTABLES_2 {
 LIBNFTABLES_3 {
   nft_set_optimize;
   nft_get_optimize;
+  nft_ctx_set_optimize;
+  nft_ctx_get_optimize;
 } LIBNFTABLES_2;
-- 
2.35.1

