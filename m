Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55ED2401825
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Sep 2021 10:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbhIFIlI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Sep 2021 04:41:08 -0400
Received: from mail.netfilter.org ([217.70.188.207]:39142 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhIFIlH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Sep 2021 04:41:07 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 742C260011
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Sep 2021 10:38:57 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] doc: Missing NFT_CTX_OUTPUT_NUMERIC_SYMBOL in libnftables documentation
Date:   Mon,  6 Sep 2021 10:39:58 +0200
Message-Id: <20210906083958.1976-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add NFT_CTX_OUTPUT_NUMERIC_SYMBOL to libnftables.adoc to keep it in sync
with the nftables/libnftables.h header.

Fixes: 685a06447ee4 ("doc: libnftables.adoc misc cleanups")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/libnftables.adoc | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/libnftables.adoc b/doc/libnftables.adoc
index ce4a361b84cc..3abb95957505 100644
--- a/doc/libnftables.adoc
+++ b/doc/libnftables.adoc
@@ -93,6 +93,7 @@ enum {
         NFT_CTX_OUTPUT_NUMERIC_TIME   = (1 << 10),
         NFT_CTX_OUTPUT_NUMERIC_ALL    = (NFT_CTX_OUTPUT_NUMERIC_PROTO |
                                          NFT_CTX_OUTPUT_NUMERIC_PRIO  |
+                                         NFT_CTX_OUTPUT_NUMERIC_SYMBOL |
                                          NFT_CTX_OUTPUT_NUMERIC_TIME),
         NFT_CTX_OUTPUT_TERSE          = (1 << 11),
 };
-- 
2.20.1

