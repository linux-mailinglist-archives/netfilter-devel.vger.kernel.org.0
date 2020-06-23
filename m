Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A21F205294
	for <lists+netfilter-devel@lfdr.de>; Tue, 23 Jun 2020 14:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbgFWMez (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 23 Jun 2020 08:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732574AbgFWMet (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 23 Jun 2020 08:34:49 -0400
Received: from janet.servers.dxld.at (janet.servers.dxld.at [IPv6:2a01:4f8:201:89f4::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65163C061796
        for <netfilter-devel@vger.kernel.org>; Tue, 23 Jun 2020 05:34:47 -0700 (PDT)
Received: janet.servers.dxld.at; Tue, 23 Jun 2020 14:34:45 +0200
From:   =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
To:     netfilter-devel@vger.kernel.org
Cc:     =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>
Subject: [libnf_ct resend PATCH 8/8] Fix buffer overflows in __snprintf_protoinfo* like in *2str fns
Date:   Tue, 23 Jun 2020 14:34:03 +0200
Message-Id: <20200623123403.31676-9-dxld@darkboxed.org>
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

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
---
 src/conntrack/snprintf_default.c | 42 +++++++++++++++++++++++---------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/src/conntrack/snprintf_default.c b/src/conntrack/snprintf_default.c
index 8e3d41c..89eee8f 100644
--- a/src/conntrack/snprintf_default.c
+++ b/src/conntrack/snprintf_default.c
@@ -36,30 +36,48 @@ static int __snprintf_protoinfo(char *buf,
 				unsigned int len,
 				const struct nf_conntrack *ct)
 {
-	return snprintf(buf, len, "%s ",
-			ct->protoinfo.tcp.state < TCP_CONNTRACK_MAX ?
-			states[ct->protoinfo.tcp.state] :
-			states[TCP_CONNTRACK_NONE]);
+        const char *str = NULL;
+        uint8_t state = ct->protoinfo.tcp.state;
+
+        if(state < asizeof(states))
+                str = states[state];
+
+        if(str == NULL)
+                str = states[TCP_CONNTRACK_NONE];
+
+	return snprintf(buf, len, "%s ", str);
 }
 
 static int __snprintf_protoinfo_sctp(char *buf,
 				     unsigned int len,
 				     const struct nf_conntrack *ct)
 {
-	return snprintf(buf, len, "%s ",
-			ct->protoinfo.sctp.state < SCTP_CONNTRACK_MAX ?
-			sctp_states[ct->protoinfo.sctp.state] :
-			sctp_states[SCTP_CONNTRACK_NONE]);
+        const char *str = NULL;
+        uint8_t state = ct->protoinfo.sctp.state;
+
+        if(state < asizeof(sctp_states))
+                str = sctp_states[state];
+
+        if(str == NULL)
+                str = sctp_states[SCTP_CONNTRACK_NONE];
+
+	return snprintf(buf, len, "%s ", str);
 }
 
 static int __snprintf_protoinfo_dccp(char *buf,
 				     unsigned int len,
 				     const struct nf_conntrack *ct)
 {
-	return snprintf(buf, len, "%s ",
-			ct->protoinfo.dccp.state < DCCP_CONNTRACK_MAX ?
-			sctp_states[ct->protoinfo.dccp.state] :
-			sctp_states[DCCP_CONNTRACK_NONE]);
+        const char *str = NULL;
+        uint8_t state = ct->protoinfo.dccp.state;
+
+        if(state < asizeof(dccp_states))
+                str = dccp_states[state];
+
+        if(str == NULL)
+                str = dccp_states[SCTP_CONNTRACK_NONE];
+
+	return snprintf(buf, len, "%s ", str);
 }
 
 static int __snprintf_address_ipv4(char *buf,
-- 
2.20.1

