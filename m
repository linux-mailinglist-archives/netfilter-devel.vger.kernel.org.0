Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1A65F6996
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Oct 2022 16:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbiJFO1H (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 6 Oct 2022 10:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbiJFO1H (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 6 Oct 2022 10:27:07 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79888A599E
        for <netfilter-devel@vger.kernel.org>; Thu,  6 Oct 2022 07:27:01 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: [PATCH conntrack-tools] build: conntrack-tools requires libnetfilter_conntrack >= 1.0.9
Date:   Thu,  6 Oct 2022 16:26:57 +0200
Message-Id: <20221006142657.236241-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Compilation breaks with 1.0.8 and lower versions, bump dependencies.

Reported-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 3034991b48ef..f26189ae4b1b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -53,7 +53,7 @@ AC_CHECK_HEADER([rpc/rpc_msg.h], [AC_SUBST([LIBTIRPC_CFLAGS],'')], [PKG_CHECK_MO
 
 PKG_CHECK_MODULES([LIBNFNETLINK], [libnfnetlink >= 1.0.1])
 PKG_CHECK_MODULES([LIBMNL], [libmnl >= 1.0.3])
-PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.8])
+PKG_CHECK_MODULES([LIBNETFILTER_CONNTRACK], [libnetfilter_conntrack >= 1.0.9])
 AS_IF([test "x$enable_cttimeout" = "xyes"], [
 	PKG_CHECK_MODULES([LIBNETFILTER_CTTIMEOUT], [libnetfilter_cttimeout >= 1.0.0])
 ])
-- 
2.30.2

