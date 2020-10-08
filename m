Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3C02874B9
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Oct 2020 15:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730228AbgJHNB2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Oct 2020 09:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730121AbgJHNB1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Oct 2020 09:01:27 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935BC061755
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Oct 2020 06:01:27 -0700 (PDT)
Received: from localhost ([::1]:37662 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.94)
        (envelope-from <phil@nwl.cc>)
        id 1kQVXw-0004lt-VV; Thu, 08 Oct 2020 15:01:25 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [iptables PATCH] libiptc: Avoid gcc-10 zero-length array warning
Date:   Thu,  8 Oct 2020 15:01:16 +0200
Message-Id: <20201008130116.25798-1-phil@nwl.cc>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Gcc-10 doesn't like the use of zero-length arrays as last struct member
to denote variable sized objects. The suggested alternative, namely to
use a flexible array member as defined by C99, is problematic as that
doesn't allow for said struct to be embedded into others. With the
relevant structs being part of kernel UAPI, this can't be precluded
though.

The call to memcpy() which triggers the warning copies data from one
struct xt_counters to another. Since this struct is flat and merely
contains two u64 fields, One can use direct assignment instead which
avoids the warning.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 libiptc/libiptc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libiptc/libiptc.c b/libiptc/libiptc.c
index 5888201525213..ceeb017b39400 100644
--- a/libiptc/libiptc.c
+++ b/libiptc/libiptc.c
@@ -1169,7 +1169,7 @@ static int iptcc_compile_chain(struct xtc_handle *h, STRUCT_REPLACE *repl, struc
 	else
 		foot->target.verdict = RETURN;
 	/* set policy-counters */
-	memcpy(&foot->e.counters, &c->counters, sizeof(STRUCT_COUNTERS));
+	foot->e.counters = c->counters;
 
 	return 0;
 }
-- 
2.28.0

