Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D81C330001
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Mar 2021 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbhCGJ5N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Mar 2021 04:57:13 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:56695 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231325AbhCGJ4j (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Mar 2021 04:56:39 -0500
X-Greylist: delayed 302 seconds by postgrey-1.27 at vger.kernel.org; Sun, 07 Mar 2021 04:56:39 EST
Received: from blood-stain-child.wan.ruderich.org (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000000114.000000006044A229.000068C7; Sun, 07 Mar 2021 10:51:37 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     simon@ruderich.org, netfilter-devel@vger.kernel.org
Subject: [PATCH 2/3] doc: remove duplicate tables in synproxy example
Date:   Sun,  7 Mar 2021 10:51:35 +0100
Message-Id: <777bd19f84d96590e4000a821146874d92462142.1615108958.git.simon@ruderich.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <cover.1615108958.git.simon@ruderich.org>
References: <cover.1615108958.git.simon@ruderich.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mime-Autoconverted: from 8bit to 7bit by courier 1.0
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The "outcome ruleset" is the same as the two tables in the example.
Don't duplicate this information which just wastes space in the
documentation and can confuse the reader (it took me a while to realize
the tables are the same).

In addition, use the same table name for both tables to make it clear
that they can be the same. They will be merged in the resulting ruleset.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 doc/statements.txt | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index aac7c7d6..7bb538a9 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -567,28 +567,13 @@ drop incorrect cookies. Flags combinations not expected during  3WHS will not
 match and continue (e.g. SYN+FIN, SYN+ACK). Finally, drop invalid packets, this
 will be out-of-flow packets that were not matched by SYNPROXY.
 
-    table ip foo {
+    table ip x {
             chain z {
                     type filter hook input priority filter; policy accept;
                     ct state { invalid, untracked } synproxy mss 1460 wscale 9 timestamp sack-perm
                     ct state invalid drop
             }
     }
-
-The outcome ruleset of the steps above should be similar to the one below.
-
-	table ip x {
-		chain y {
-			type filter hook prerouting priority raw; policy accept;
-	                tcp flags syn notrack
-		}
-
-		chain z {
-			type filter hook input priority filter; policy accept;
-	                ct state { invalid, untracked } synproxy mss 1460 wscale 9 timestamp sack-perm
-		        ct state invalid drop
-	        }
-	}
 ---------------------------------------
 
 FLOW STATEMENT
-- 
2.30.1

