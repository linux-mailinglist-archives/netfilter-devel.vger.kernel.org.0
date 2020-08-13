Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1B3243DF8
	for <lists+netfilter-devel@lfdr.de>; Thu, 13 Aug 2020 19:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgHMRGZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 13 Aug 2020 13:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRGX (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:06:23 -0400
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [IPv6:2a0a:51c0:0:12e:520::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B6CCC061757
        for <netfilter-devel@vger.kernel.org>; Thu, 13 Aug 2020 10:06:23 -0700 (PDT)
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
        (envelope-from <fw@breakpoint.cc>)
        id 1k6GgH-0002nx-NO; Thu, 13 Aug 2020 19:06:21 +0200
From:   Florian Westphal <fw@strlen.de>
To:     <netfilter-devel@vger.kernel.org>
Cc:     Florian Westphal <fw@strlen.de>
Subject: [PATCH lnf-conntrack] conntrack: dccp print function should use dccp state
Date:   Thu, 13 Aug 2020 19:06:17 +0200
Message-Id: <20200813170617.22916-1-fw@strlen.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Found while reading code, compile tested only.

Signed-off-by: Florian Westphal <fw@strlen.de>
---
 src/conntrack/snprintf_default.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/conntrack/snprintf_default.c b/src/conntrack/snprintf_default.c
index 06466b115870..e48f06e5db59 100644
--- a/src/conntrack/snprintf_default.c
+++ b/src/conntrack/snprintf_default.c
@@ -62,8 +62,8 @@ static int __snprintf_protoinfo_dccp(char *buf,
 {
 	return snprintf(buf, len, "%s ",
 			ct->protoinfo.dccp.state < DCCP_CONNTRACK_MAX ?
-			sctp_states[ct->protoinfo.dccp.state] :
-			sctp_states[DCCP_CONNTRACK_NONE]);
+			dccp_states[ct->protoinfo.dccp.state] :
+			dccp_states[DCCP_CONNTRACK_NONE]);
 }
 
 static int __snprintf_address_ipv4(char *buf,
-- 
2.26.2

