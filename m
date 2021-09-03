Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7C7E3FFBF4
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Sep 2021 10:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348210AbhICIaV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Sep 2021 04:30:21 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57414 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348150AbhICIaV (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:30:21 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 1C1506008B
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Sep 2021 10:28:19 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] include: add NFT_CTX_OUTPUT_NUMERIC_TIME to NFT_CTX_OUTPUT_NUMERIC_ALL
Date:   Fri,  3 Sep 2021 10:29:16 +0200
Message-Id: <20210903082916.7630-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Therefore, -n honors numeric time in seconds.

Fixes: f8f32deda31d ("meta: Introduce new conditions 'time', 'day' and 'hour'")
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 include/nftables/libnftables.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/nftables/libnftables.h b/include/nftables/libnftables.h
index 8e7151a324b0..957b5fbee243 100644
--- a/include/nftables/libnftables.h
+++ b/include/nftables/libnftables.h
@@ -55,7 +55,8 @@ enum {
 	NFT_CTX_OUTPUT_NUMERIC_TIME	= (1 << 10),
 	NFT_CTX_OUTPUT_NUMERIC_ALL	= (NFT_CTX_OUTPUT_NUMERIC_PROTO |
 					   NFT_CTX_OUTPUT_NUMERIC_PRIO |
-					   NFT_CTX_OUTPUT_NUMERIC_SYMBOL),
+					   NFT_CTX_OUTPUT_NUMERIC_SYMBOL |
+					   NFT_CTX_OUTPUT_NUMERIC_TIME),
 	NFT_CTX_OUTPUT_TERSE		= (1 << 11),
 };
 
-- 
2.20.1

