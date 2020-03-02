Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F070A1766B1
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Mar 2020 23:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgCBWTS (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Mar 2020 17:19:18 -0500
Received: from kadath.azazel.net ([81.187.231.250]:41474 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726785AbgCBWTS (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Mar 2020 17:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+MRjDIMCPnUd9MF472aAGXhHCTyDnj3i+U40/yjk+e8=; b=RS+RY34Ore6pnc0Xei4BgamBQi
        YfuP6EB5BPvMx8Z1pHFLRglDhhtozJvIWyWdPA2AaeZ0LXmJZxYrTN2e0Hys8QL5lorQftsyQM6L4
        JhL9SyWwLgpgN6EY9uvbZ4PmpZbv8MjizP2EBRUfFli0/XJNTofGcAOWIHzEsjKwORAl0Br7eMIvD
        dt/KUPcLmWKVfGOCVBUG4V7HPzYOaugQ3UEfZRt2FOPRUa/BYTVGkS+Dr2lSa9i6ZGdeG7YMe0OsP
        jfZVi/UciRfUgwXCKri6NTX5JOm5PldWnMqg76Hj7ygHmXTDseXT9IEjBCwVEgn8+6nFceg+8xkCY
        7I9oT0tw==;
Received: from [2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] (helo=ulthar.dreamlands)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1j8tPA-0000Sg-DV; Mon, 02 Mar 2020 22:19:16 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Florian Westphal <fw@strlen.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH nft v2 02/18] evaluate: simplify calculation of payload size.
Date:   Mon,  2 Mar 2020 22:19:00 +0000
Message-Id: <20200302221916.1005019-3-jeremy@azazel.net>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200302221916.1005019-1-jeremy@azazel.net>
References: <20200302221916.1005019-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use div_round_up and one statement.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/evaluate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/evaluate.c b/src/evaluate.c
index fda30fd8001e..e2eff2353657 100644
--- a/src/evaluate.c
+++ b/src/evaluate.c
@@ -2236,8 +2236,8 @@ static int stmt_evaluate_payload(struct eval_ctx *ctx, struct stmt *stmt)
 
 	shift_imm = expr_offset_shift(payload, payload->payload.offset,
 				      &extra_len);
-	payload_byte_size = round_up(payload->len, BITS_PER_BYTE) / BITS_PER_BYTE;
-	payload_byte_size += (extra_len / BITS_PER_BYTE);
+	payload_byte_size = div_round_up(payload->len + extra_len,
+					 BITS_PER_BYTE);
 
 	if (need_csum && payload_byte_size & 1) {
 		payload_byte_size++;
-- 
2.25.1

