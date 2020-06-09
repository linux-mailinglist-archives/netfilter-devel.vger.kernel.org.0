Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63BAC1F336C
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Jun 2020 07:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727842AbgFIF30 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Jun 2020 01:29:26 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:50474 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgFIF2v (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:51 -0400
Received: from dimstar.local.net (n175-34-64-112.sun1.vic.optusnet.com.au [175.34.64.112])
        by mail110.syd.optusnet.com.au (Postfix) with SMTP id 560A410880C
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Jun 2020 15:28:48 +1000 (AEST)
Received: (qmail 10049 invoked by uid 501); 9 Jun 2020 05:28:44 -0000
From:   Duncan Roe <duncan_roe@optusnet.com.au>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue] configure:  Make --help show doxygen is off by default
Date:   Tue,  9 Jun 2020 15:28:44 +1000
Message-Id: <20200609052844.10007-1-duncan_roe@optusnet.com.au>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200608212550.28118-1-pablo@netfilter.org>
References: <20200608212550.28118-1-pablo@netfilter.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=X6os11be c=1 sm=1 tr=0
        a=keeXcwCgVCrAuxOn72dlvA==:117 a=keeXcwCgVCrAuxOn72dlvA==:17
        a=nTHF0DUjJn0A:10 a=RSmzAf-M6YYA:10 a=PO7r1zJSAAAA:8
        a=76LSlkVniBy9xZQeaY0A:9 a=pHzHmUro8NiASowvMSCR:22
        a=n87TN5wuljxrRezIQYnT:22
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Duncan Roe <duncan_roe@optusnet.com.au>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 96e18be..763dbd2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -37,7 +37,7 @@ AC_CONFIG_FILES([Makefile src/Makefile utils/Makefile examples/Makefile
 	include/linux/Makefile include/linux/netfilter/Makefile])
 
 AC_ARG_WITH([doxygen], [AS_HELP_STRING([--with-doxygen],
-	    [create doxygen documentation])],
+	    [create doxygen documentation [default=no]])],
 	    [], [with_doxygen=no])
 AS_IF([test "x$with_doxygen" = xyes], [
 	AC_CHECK_PROGS([DOXYGEN], [doxygen])
-- 
2.14.5

