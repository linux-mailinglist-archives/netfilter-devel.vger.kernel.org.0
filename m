Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C019330000
	for <lists+netfilter-devel@lfdr.de>; Sun,  7 Mar 2021 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbhCGJ5N (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 7 Mar 2021 04:57:13 -0500
Received: from zucker.schokokeks.org ([178.63.68.96]:35343 "EHLO
        zucker.schokokeks.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhCGJ4k (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 7 Mar 2021 04:56:40 -0500
Received: from blood-stain-child.wan.ruderich.org (localhost [::1])
  (AUTH: PLAIN simon@ruderich.org, TLS: TLSv1.3,256bits,TLS_AES_256_GCM_SHA384)
  by zucker.schokokeks.org with ESMTPSA
  id 0000000000000118.000000006044A22A.000068D3; Sun, 07 Mar 2021 10:51:37 +0100
From:   Simon Ruderich <simon@ruderich.org>
To:     simon@ruderich.org, netfilter-devel@vger.kernel.org
Subject: [PATCH 3/3] doc: move drop rule on a separate line in blackhole example
Date:   Sun,  7 Mar 2021 10:51:36 +0100
Message-Id: <0637994cfd40621a20b624efa7d190c916e5edd0.1615108958.git.simon@ruderich.org>
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

At first I overlooked the "drop". Putting it on a separate line makes it
more visible and also details the separate steps of this rule.

Signed-off-by: Simon Ruderich <simon@ruderich.org>
---
 doc/statements.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/statements.txt b/doc/statements.txt
index 7bb538a9..0973e5ef 100644
--- a/doc/statements.txt
+++ b/doc/statements.txt
@@ -712,7 +712,8 @@ nft add rule ip filter input ip saddr @blackhole counter drop
 # requests occurred per second and ip address.
 nft add rule ip filter input tcp flags syn tcp dport ssh \
     add @flood { ip saddr limit rate over 10/second } \
-    add @blackhole { ip saddr } drop
+    add @blackhole { ip saddr } \
+    drop
 
 # inspect state of the sets.
 nft list set ip filter flood
-- 
2.30.1

