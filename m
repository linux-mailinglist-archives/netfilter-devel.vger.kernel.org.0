Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AB9547F43
	for <lists+netfilter-devel@lfdr.de>; Mon, 17 Jun 2019 12:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbfFQKGw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 17 Jun 2019 06:06:52 -0400
Received: from Chamillionaire.breakpoint.cc ([193.142.43.52]:43140 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727927AbfFQKGw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 17 Jun 2019 06:06:52 -0400
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.89)
        (envelope-from <fw@breakpoint.cc>)
        id 1hcoXJ-0004Az-KM; Mon, 17 Jun 2019 12:06:49 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH nft v2] datatype: fix print of raw numerical symbol values
Date:   Mon, 17 Jun 2019 11:55:42 +0200
Message-Id: <20190617095542.5702-1-fw@strlen.de>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The two rules:
arp operation 1-2 accept
arp operation 256-512 accept

are both shown as 256-512:

        chain in_public {
                arp operation 256-512 accept
                arp operation 256-512 accept
                meta mark "1"
                tcp flags 2,4
        }

This is because range expression enforces numeric output,
yet nft_print doesn't respect byte order.

Behave as if we had no symbol in the first place and call
the base type print function instead.

This means we now respect format specifier as well:
	chain in_public {
                arp operation 1-2 accept
                arp operation 256-512 accept
                meta mark 0x00000001
                tcp flags 0x2,0x4
	}

Without fix, added test case will fail:
'add rule arp test-arp input arp operation 1-2': 'arp operation 1-2' mismatches 'arp operation 256-512'

v2: in case of -n, also elide quotation marks, just as if we would not
have found a symbolic name.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/datatype.c                    | 14 +++-----------
 tests/py/arp/arp.t                |  1 +
 tests/py/arp/arp.t.payload        |  6 ++++++
 tests/py/arp/arp.t.payload.netdev |  8 ++++++++
 4 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/src/datatype.c b/src/datatype.c
index 519f79d70b9a..bd4c3d72c761 100644
--- a/src/datatype.c
+++ b/src/datatype.c
@@ -191,19 +191,11 @@ void symbolic_constant_print(const struct symbol_table *tbl,
 			break;
 	}
 
-	if (s->identifier == NULL)
+	if (s->identifier == NULL ||
+	    nft_output_numeric_symbol(octx))
 		return expr_basetype(expr)->print(expr, octx);
 
-	if (quotes)
-		nft_print(octx, "\"");
-
-	if (nft_output_numeric_symbol(octx))
-		nft_print(octx, "%" PRIu64 "", val);
-	else
-		nft_print(octx, "%s", s->identifier);
-
-	if (quotes)
-		nft_print(octx, "\"");
+	nft_print(octx, quotes ? "\"%s\"" : "%s", s->identifier);
 }
 
 static void switch_byteorder(void *data, unsigned int len)
diff --git a/tests/py/arp/arp.t b/tests/py/arp/arp.t
index 86bab5232eaf..2540c0a77419 100644
--- a/tests/py/arp/arp.t
+++ b/tests/py/arp/arp.t
@@ -38,6 +38,7 @@ arp plen != {33-55};ok
 
 arp operation {nak, inreply, inrequest, rreply, rrequest, reply, request};ok
 arp operation != {nak, inreply, inrequest, rreply, rrequest, reply, request};ok
+arp operation 1-2;ok
 arp operation request;ok
 arp operation reply;ok
 arp operation rrequest;ok
diff --git a/tests/py/arp/arp.t.payload b/tests/py/arp/arp.t.payload
index d36bef183396..52c993294810 100644
--- a/tests/py/arp/arp.t.payload
+++ b/tests/py/arp/arp.t.payload
@@ -188,6 +188,12 @@ arp test-arp input
   [ payload load 2b @ network header + 6 => reg 1 ]
   [ lookup reg 1 set __set%d 0x1 ]
 
+# arp operation 1-2
+arp test-arp input
+  [ payload load 2b @ network header + 6 => reg 1 ]
+  [ cmp gte reg 1 0x00000100 ]
+  [ cmp lte reg 1 0x00000200 ]
+
 # arp operation request
 arp test-arp input
   [ payload load 2b @ network header + 6 => reg 1 ]
diff --git a/tests/py/arp/arp.t.payload.netdev b/tests/py/arp/arp.t.payload.netdev
index 0146cf500ee2..667691fff2f6 100644
--- a/tests/py/arp/arp.t.payload.netdev
+++ b/tests/py/arp/arp.t.payload.netdev
@@ -246,6 +246,14 @@ netdev test-netdev ingress
   [ payload load 2b @ network header + 6 => reg 1 ]
   [ lookup reg 1 set __set%d 0x1 ]
 
+# arp operation 1-2
+netdev test-netdev ingress
+  [ meta load protocol => reg 1 ]
+  [ cmp eq reg 1 0x00000608 ]
+  [ payload load 2b @ network header + 6 => reg 1 ]
+  [ cmp gte reg 1 0x00000100 ]
+  [ cmp lte reg 1 0x00000200 ]
+
 # arp operation request
 netdev test-netdev ingress 
   [ meta load protocol => reg 1 ]
-- 
2.21.0

