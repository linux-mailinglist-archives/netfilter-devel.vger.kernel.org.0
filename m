Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B37BA392F9
	for <lists+netfilter-devel@lfdr.de>; Fri,  7 Jun 2019 19:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbfFGRVw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 7 Jun 2019 13:21:52 -0400
Received: from orbyte.nwl.cc ([151.80.46.58]:35954 "EHLO orbyte.nwl.cc"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728998AbfFGRVw (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 7 Jun 2019 13:21:52 -0400
Received: from localhost ([::1]:49044 helo=tatos)
        by orbyte.nwl.cc with esmtp (Exim 4.91)
        (envelope-from <phil@nwl.cc>)
        id 1hZIYo-0006ub-Vt; Fri, 07 Jun 2019 19:21:51 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Eric Garver <e@erig.me>, netfilter-devel@vger.kernel.org
Subject: [nft PATCH v6 2/5] tests/json_echo: Drop needless workaround
Date:   Fri,  7 Jun 2019 19:21:18 +0200
Message-Id: <20190607172121.21752-3-phil@nwl.cc>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190607172121.21752-1-phil@nwl.cc>
References: <20190607172121.21752-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

With cache issues now resolved, there is no need for the multi add test
workaround anymore.

Signed-off-by: Phil Sutter <phil@nwl.cc>
---
 tests/json_echo/run-test.py | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tests/json_echo/run-test.py b/tests/json_echo/run-test.py
index dd7797fb6f041..a636d5f247702 100755
--- a/tests/json_echo/run-test.py
+++ b/tests/json_echo/run-test.py
@@ -271,12 +271,10 @@ add_quota["add"]["quota"]["name"] = "q"
 do_flush()
 
 print("doing multi add")
-# XXX: Add table separately, otherwise this triggers cache bug
-out = do_command(add_table)
-thandle = get_handle(out, add_table["add"])
-add_multi = [ add_chain, add_set, add_rule ]
+add_multi = [ add_table, add_chain, add_set, add_rule ]
 out = do_command(add_multi)
 
+thandle = get_handle(out, add_table["add"])
 chandle = get_handle(out, add_chain["add"])
 shandle = get_handle(out, add_set["add"])
 rhandle = get_handle(out, add_rule["add"])
-- 
2.21.0

