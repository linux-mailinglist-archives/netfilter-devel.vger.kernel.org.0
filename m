Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A860523D6
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Jun 2019 08:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729375AbfFYG6h (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 25 Jun 2019 02:58:37 -0400
Received: from a3.inai.de ([88.198.85.195]:40158 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729654AbfFYG6h (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 25 Jun 2019 02:58:37 -0400
Received: by a3.inai.de (Postfix, from userid 65534)
        id F0FA33BAC08A; Tue, 25 Jun 2019 08:58:35 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=5.0 tests=AWL,BAYES_00,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.1
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:222:6c9::f8])
        by a3.inai.de (Postfix) with ESMTP id 21C5F2AFD3F6;
        Tue, 25 Jun 2019 08:58:35 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH 3/3] build: avoid unnecessary call to xargs
Date:   Tue, 25 Jun 2019 08:58:35 +0200
Message-Id: <20190625065835.31188-3-jengelh@inai.de>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190625065835.31188-1-jengelh@inai.de>
References: <20190625065835.31188-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 py/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/py/Makefile.am b/py/Makefile.am
index 5f4e1f6..215ecd9 100644
--- a/py/Makefile.am
+++ b/py/Makefile.am
@@ -22,7 +22,7 @@ clean-local:
 		$(PYTHON_BIN) setup.py clean \
 		--build-base $(abs_builddir)
 	rm -rf scripts-* lib* build dist bdist.* nftables.egg-info
-	find . -name \*.pyc -print0 | xargs -0 rm -f
+	find . -name \*.pyc -delete
 
 distclean-local:
 	rm -f version
-- 
2.21.0

