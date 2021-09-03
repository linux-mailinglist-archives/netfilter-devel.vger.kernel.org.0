Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC5E3FFB99
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Sep 2021 10:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348135AbhICINR (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Sep 2021 04:13:17 -0400
Received: from mail.netfilter.org ([217.70.188.207]:57328 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348163AbhICINQ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Sep 2021 04:13:16 -0400
Received: from localhost.localdomain (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id 5A67B6008B
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Sep 2021 10:11:13 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft] datatype: time_print() ignores -T
Date:   Fri,  3 Sep 2021 10:12:11 +0200
Message-Id: <20210903081211.23884-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Honor NFT_CTX_OUTPUT_NUMERIC_TIME.

 # nft list ruleset
 table ip x {
        set y {
                type ipv4_addr
                flags timeout
                elements = { 1.1.1.1 timeout 5m expires 1m49s40ms }
        }
 }
 # sudo nft -T list ruleset
 table ip x {
        set y {
                type ipv4_addr
                flags timeout
                elements = { 1.1.1.1 timeout 300s expires 108s }
        }
 }

Closes: https://bugzilla.netfilter.org/show_bug.cgi?id=1561
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 src/datatype.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/datatype.c b/src/datatype.c
index 7267d60895d8..b849f70833c7 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -911,6 +911,11 @@ void time_print(uint64_t ms, struct output_ctx *octx)
 {
 	uint64_t days, hours, minutes, seconds;
 
+	if (nft_output_seconds(octx)) {
+		nft_print(octx, "%" PRIu64 "s", ms / 1000);
+		return;
+	}
+
 	days = ms / 86400000;
 	ms %= 86400000;
 
-- 
2.20.1

