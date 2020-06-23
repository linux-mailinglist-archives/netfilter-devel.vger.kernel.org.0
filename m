Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27E8B205293
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732557AbgFWMey (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 08:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732565AbgFWMet (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:34:49 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D51CC061573
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2020 05:34:46 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 14:34:44 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [libnf_ct resend PATCH 6/8] Fix buffer overflow on invalid icmp type in setters
Date:   Tue, 23 Jun 2020 14:34:01 +0200
Message-Id: <20200623123403.31676-7-dxld@darkboxed.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200623123403.31676-1-dxld@darkboxed.org>
References: <20200623123403.31676-1-dxld@darkboxed.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-score: -0.0
X-Spam-bar: /
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

When type is out of range for the invmap_icmp{,v6} array we leave rtype at
zero which will map to type=255 just like other error cases in this
function.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 src/conntrack/grp_setter.c |  8 +++++---
 src/conntrack/setter.c     | 11 +++++++----
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/conntrack/grp_setter.c b/src/conntrack/grp_setter.c
index fccf578..dfbdc91 100644
--- a/src/conntrack/grp_setter.c
+++ b/src/conntrack/grp_setter.c
@@ -85,18 +85,20 @@ static void set_attr_grp_repl_port(struct nf_conntrack *ct, const void *value)
 
 static void set_attr_grp_icmp(struct nf_conntrack *ct, const void *value)
 {
-	uint8_t rtype;
+	uint8_t rtype = 0;
 	const struct nfct_attr_grp_icmp *this = value;
 
 	ct->head.orig.l4dst.icmp.type = this->type;
 
 	switch(ct->head.orig.l3protonum) {
 		case AF_INET:
-			rtype = invmap_icmp[this->type];
+			if(this->type < asizeof(invmap_icmp))
+				rtype = invmap_icmp[this->type];
 			break;
 
 		case AF_INET6:
-			rtype = invmap_icmpv6[this->type - 128];
+			if(this->type - 128 < asizeof(invmap_icmp))
+				rtype = invmap_icmpv6[this->type - 128];
 			break;
 
 		default:
diff --git a/src/conntrack/setter.c b/src/conntrack/setter.c
index 0157de4..ed65ba0 100644
--- a/src/conntrack/setter.c
+++ b/src/conntrack/setter.c
@@ -124,17 +124,20 @@ set_attr_repl_zone(struct nf_conntrack *ct, const void *value, size_t len)
 static void
 set_attr_icmp_type(struct nf_conntrack *ct, const void *value, size_t len)
 {
-	uint8_t rtype;
+        uint8_t type = *((uint8_t *) value);
+	uint8_t rtype = 0;
 
-	ct->head.orig.l4dst.icmp.type = *((uint8_t *) value);
+	ct->head.orig.l4dst.icmp.type = type;
 
 	switch(ct->head.orig.l3protonum) {
 		case AF_INET:
-			rtype = invmap_icmp[*((uint8_t *) value)];
+                        if(type < asizeof(invmap_icmp))
+                                rtype = invmap_icmp[type];
 			break;
 
 		case AF_INET6:
-			rtype = invmap_icmpv6[*((uint8_t *) value) - 128];
+                        if(type - 128 < asizeof(invmap_icmpv6))
+                                rtype = invmap_icmpv6[type - 128];
 			break;
 
 		default:
-- 
2.20.1

