Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CCC388A65
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 May 2021 11:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344892AbhESJVc (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 May 2021 05:21:32 -0400
Received: from mail.netfilter.org ([217.70.188.207]:45060 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343616AbhESJVa (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 May 2021 05:21:30 -0400
Received: from localhost.localdomain (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id 7171264177
        for <netfilter-devel@vger.kernel.org>; Wed, 19 May 2021 11:19:15 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nftables] doc: document cgroupv2
Date:   Wed, 19 May 2021 11:20:07 +0200
Message-Id: <20210519092007.31984-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

This patch adds documentation for cgroupsv2 support.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doc/primary-expression.txt | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/doc/primary-expression.txt b/doc/primary-expression.txt
index c24e26368daf..f97778b9762b 100644
--- a/doc/primary-expression.txt
+++ b/doc/primary-expression.txt
@@ -196,10 +196,14 @@ SOCKET EXPRESSION
 ~~~~~~~~~~~~~~~~~
 [verse]
 *socket* {*transparent* | *mark* | *wildcard*}
+*socket* *cgroupv2* *level* 'NUM'
 
 Socket expression can be used to search for an existing open TCP/UDP socket and
 its attributes that can be associated with a packet. It looks for an established
-or non-zero bound listening socket (possibly with a non-local address).
+or non-zero bound listening socket (possibly with a non-local address). You can
+also use it to match on the socket cgroupv2 at a given ancestor level, e.g. if
+the socket belongs to cgroupv2 'a/b', ancestor level 1 checks for a matching on
+cgroup 'a' and ancestor level 2 checks for a matching on cgroup 'b'.
 
 .Available socket attributes
 [options="header"]
@@ -212,6 +216,9 @@ boolean (1 bit)
 |wildcard|
 Indicates whether the socket is wildcard-bound (e.g. 0.0.0.0 or ::0). |
 boolean (1 bit)
+|cgroupv2|
+cgroup version 2 for this socket (path from /sys/fs/cgroup)|
+cgroupv2
 |==================
 
 .Using socket expression
@@ -241,6 +248,14 @@ table inet x {
         tcp dport 8080 mark set socket mark
     }
 }
+
+# Count packets for cgroupv2 "user.slice" at level 1
+table inet x {
+    chain y {
+        type filter hook input priority filter; policy accept;
+        socket cgroupv2 level 1 "user.slice" counter
+    }
+}
 ----------------------
 
 OSF EXPRESSION
-- 
2.20.1

