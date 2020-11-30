Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0702C84A8
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Nov 2020 14:07:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbgK3NGD (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Nov 2020 08:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgK3NGC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Nov 2020 08:06:02 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C6DC0613D3
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Nov 2020 05:05:22 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id E801359BD6199; Mon, 30 Nov 2020 14:05:20 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id E502D59BD6195;
        Mon, 30 Nov 2020 14:05:19 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_queue 2/2] Update .gitignore
Date:   Mon, 30 Nov 2020 14:05:19 +0100
Message-Id: <20201130130519.20880-2-jengelh@inai.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130130519.20880-1-jengelh@inai.de>
References: <20201130130519.20880-1-jengelh@inai.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 .gitignore | 4 ++++
 1 file changed, 4 insertions(+)

diff --git .gitignore .gitignore
index a0fc139..525628e 100644
--- .gitignore
+++ .gitignore
@@ -2,6 +2,7 @@
 .libs/
 Makefile
 Makefile.in
+.dirstamp
 *.o
 *.la
 *.lo
@@ -12,6 +13,9 @@ Makefile.in
 /config.*
 /configure
 /libtool
+/stamp-h1
 
 /doxygen.cfg
 /libnetfilter_queue.pc
+
+/examples/nf-queue
-- 
2.29.2

