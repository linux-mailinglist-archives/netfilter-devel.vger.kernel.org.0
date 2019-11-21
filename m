Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8222F105156
	for <lists+netfilter-devel@lfdr.de>; Thu, 21 Nov 2019 12:25:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726197AbfKULZE (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 21 Nov 2019 06:25:04 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:40976 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbfKULZE (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 21 Nov 2019 06:25:04 -0500
Received: from localhost ([::1]:54066 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1iXka7-0001Lf-GK; Thu, 21 Nov 2019 12:25:03 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [libnftnl PATCH] utils: Define __visible even if not supported by compiler
Date:   Thu, 21 Nov 2019 12:24:56 +0100
Message-Id: <20191121112456.28274-1-phil@nwl.cc>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Since __visible is now used directly, provide a fallback empty
definition if HAVE_VISIBILITY_HIDDEN is not defined.

Fixes: 7349a70634fa0 ("Deprecate untyped data setters")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 include/utils.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/utils.h b/include/utils.h
index 91fbebb1956fd..8af5a8e973fa8 100644
--- a/include/utils.h
+++ b/include/utils.h
@@ -12,6 +12,7 @@
 #	define __visible	__attribute__((visibility("default")))
 #	define EXPORT_SYMBOL(x)	typeof(x) (x) __visible;
 #else
+#	define __visible
 #	define EXPORT_SYMBOL
 #endif
 
-- 
2.24.0

