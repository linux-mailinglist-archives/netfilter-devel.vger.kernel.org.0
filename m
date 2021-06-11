Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5AE3A46A7
	for <lists+netfilter-devel@lfdr.de>; Fri, 11 Jun 2021 18:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbhFKQnP (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 11 Jun 2021 12:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbhFKQnO (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 11 Jun 2021 12:43:14 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFEEC061574
        for <netfilter-devel@vger.kernel.org>; Fri, 11 Jun 2021 09:41:16 -0700 (PDT)
Received: from localhost ([::1]:41330 helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1lrkDa-0005dX-PY; Fri, 11 Jun 2021 18:41:14 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 01/10] parser_bison: Fix for implicit declaration of isalnum
Date:   Fri, 11 Jun 2021 18:40:55 +0200
Message-Id: <20210611164104.8121-2-phil@nwl.cc>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611164104.8121-1-phil@nwl.cc>
References: <20210611164104.8121-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Have to include ctype.h to make it known.

Fixes: e76bb37940181 ("src: allow for variables in the log prefix string")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 src/parser_bison.y | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/parser_bison.y b/src/parser_bison.y
index 136ae105f5132..c0a9dc52963ea 100644
--- a/src/parser_bison.y
+++ b/src/parser_bison.y
@@ -10,6 +10,7 @@
 
 %{
 
+#include <ctype.h>
 #include <stddef.h>
 #include <stdio.h>
 #include <inttypes.h>
-- 
2.31.1

