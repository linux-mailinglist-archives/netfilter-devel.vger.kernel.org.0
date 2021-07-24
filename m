Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C4F53D4715
	for <lists+netfilter-devel@lfdr.de>; Sat, 24 Jul 2021 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234232AbhGXJrw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 24 Jul 2021 05:47:52 -0400
Received: from mail.netfilter.org ([217.70.188.207]:58438 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233651AbhGXJrv (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 24 Jul 2021 05:47:51 -0400
Received: from localhost.localdomain (unknown [78.30.39.111])
        by mail.netfilter.org (Postfix) with ESMTPSA id DA2276429D
        for <netfilter-devel@vger.kernel.org>; Sat, 24 Jul 2021 12:27:55 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/2] src: fix nft_ctx_clear_include_paths in libnftables.map
Date:   Sat, 24 Jul 2021 12:28:23 +0200
Message-Id: <20210724102824.28011-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

There a typo that prevents exposing the function as API.

Fixes: 16543a0136c0 ("libnftables: export public symbols only")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/libnftables.map | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/libnftables.map b/src/libnftables.map
index c0185349ede4..46d64a38e6e0 100644
--- a/src/libnftables.map
+++ b/src/libnftables.map
@@ -1,7 +1,7 @@
 LIBNFTABLES_1 {
 global:
   nft_ctx_add_include_path;
-  nft_ctx_clear_include_pat;
+  nft_ctx_clear_include_paths;
   nft_ctx_new;
   nft_ctx_buffer_output;
   nft_ctx_unbuffer_output;
-- 
2.20.1

