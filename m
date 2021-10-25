Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8B4A43A62A
	for <lists+netfilter-devel@lfdr.de>; Mon, 25 Oct 2021 23:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233282AbhJYVxG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 25 Oct 2021 17:53:06 -0400
Received: from mail.netfilter.org ([217.70.188.207]:43554 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbhJYVxB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 25 Oct 2021 17:53:01 -0400
Received: from localhost.localdomain (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id CF8E363F27
        for <netfilter-devel@vger.kernel.org>; Mon, 25 Oct 2021 23:48:50 +0200 (CEST)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH nft 1/4] configure: default to libedit for cli
Date:   Mon, 25 Oct 2021 23:50:29 +0200
Message-Id: <20211025215032.1073625-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

readline support only compiles for libreadline5, set libedit as default
library.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 6069b871911e..96cb91c7c979 100644
--- a/configure.ac
+++ b/configure.ac
@@ -69,7 +69,7 @@ AM_CONDITIONAL([BUILD_MINIGMP], [test "x$with_mini_gmp" = xyes])
 
 AC_ARG_WITH([cli], [AS_HELP_STRING([--without-cli],
             [disable interactive CLI (libreadline, editline or linenoise support)])],
-            [], [with_cli=readline])
+            [], [with_cli=editline])
 
 AS_IF([test "x$with_cli" = xreadline], [
 AC_CHECK_LIB([readline], [readline], ,
-- 
2.30.2

