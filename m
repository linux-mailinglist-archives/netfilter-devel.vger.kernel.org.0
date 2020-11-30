Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 312912C8503
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Nov 2020 14:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgK3NWe (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Nov 2020 08:22:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgK3NWc (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:22:32 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F64EC0613D2
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Nov 2020 05:21:52 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id B969A59BD62E7; Mon, 30 Nov 2020 14:21:50 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id AA29859BD62B7;
        Mon, 30 Nov 2020 14:21:49 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_conntrack 2/2] Update .gitignore
Date:   Mon, 30 Nov 2020 14:21:49 +0100
Message-Id: <20201130132149.32227-2-jengelh@inai.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130132149.32227-1-jengelh@inai.de>
References: <20201130132149.32227-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 .gitignore | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git .gitignore .gitignore
index e90dec6..d919db1 100644
--- .gitignore
+++ .gitignore
@@ -16,3 +16,16 @@ Makefile.in
 
 /doxygen.cfg
 /*.pc
+
+/examples/nfct-mnl-create
+/examples/nfct-mnl-del
+/examples/nfct-mnl-dump
+/examples/nfct-mnl-dump-labels
+/examples/nfct-mnl-event
+/examples/nfct-mnl-flush
+/examples/nfct-mnl-get
+/examples/nfct-mnl-set-label
+/examples/nfexp-mnl-dump
+/examples/nfexp-mnl-event
+/tests/test_connlabel
+/utils/expect_create_nat
-- 
2.29.2

