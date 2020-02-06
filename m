Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76A92153C62
	for <lists+netfilter-devel@lfdr.de>; Thu,  6 Feb 2020 01:58:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727565AbgBFA66 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 5 Feb 2020 19:58:58 -0500
Received: from orbyte.nwl.cc ([151.80.46.58]:47692 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727149AbgBFA66 (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 5 Feb 2020 19:58:58 -0500
Received: from localhost ([::1]:60782 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1izVVQ-0000lU-IR; Thu, 06 Feb 2020 01:58:56 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org
Subject: [nft PATCH 1/4] tests: json_echo: Fix for Python3
Date:   Thu,  6 Feb 2020 01:58:48 +0100
Message-Id: <20200206005851.28962-2-phil@nwl.cc>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206005851.28962-1-phil@nwl.cc>
References: <20200206005851.28962-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The keys() method returns an object which does not support indexing, so
convert it to a list prior to doing so.

Fixes: a35e3a0cdc63a ("tests: json_echo: convert to py3")
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/json_echo/run-test.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/json_echo/run-test.py b/tests/json_echo/run-test.py
index a636d5f247702..fa7d69ab75645 100755
--- a/tests/json_echo/run-test.py
+++ b/tests/json_echo/run-test.py
@@ -119,7 +119,7 @@ def get_handle(output, search):
             else:
                 data = item
 
-            k = search.keys()[0]
+            k = list(search.keys())[0]
 
             if not k in data:
                 continue
-- 
2.24.1

