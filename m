Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F70782092
	for <lists+netfilter-devel@lfdr.de>; Mon, 21 Aug 2023 00:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbjHTWH1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 20 Aug 2023 18:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbjHTWH0 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 20 Aug 2023 18:07:26 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DD9379D
        for <netfilter-devel@vger.kernel.org>; Sun, 20 Aug 2023 15:07:24 -0700 (PDT)
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     jeremy@azazel.net, fw@strlen.de
Subject: [PATCH nft] INSTALL: provide examples to install python bindings
Date:   Mon, 21 Aug 2023 00:07:20 +0200
Message-Id: <20230820220720.49615-1-pablo@netfilter.org>
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

Provide examples to install python bindings with legacy setup.py and pip
with .toml file.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
Florian noticed that `make install` does install python bindings anymore
when running tests/py. Provide a bit more information on how to manually
install python bindings in the INSTALL file.

 INSTALL | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/INSTALL b/INSTALL
index 53021e5aafc3..6b026e2c20c1 100644
--- a/INSTALL
+++ b/INSTALL
@@ -86,8 +86,13 @@ Installation instructions for nftables
 
  CPython bindings are available for nftables under the py/ folder.
 
- A pyproject.toml config file and legacy setup.py script are provided to install
- it.
+ A legacy setup.py script are provided to install:
+
+	python setup.py install
+
+ Alternatively, a pyproject.toml config file is also provided install:
+
+	python -m pip install .
 
  Source code
  ===========
-- 
2.30.2

