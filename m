Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CAD2C8476
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Nov 2020 13:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgK3Myh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Nov 2020 07:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgK3Myg (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Nov 2020 07:54:36 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B045EC061A51
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Nov 2020 04:53:46 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 79C9B59784B61; Mon, 30 Nov 2020 13:53:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 54E8759784B50;
        Mon, 30 Nov 2020 13:53:43 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     fw@strlen.de
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH libnetfilter_log] build: choose right automake variables
Date:   Mon, 30 Nov 2020 13:53:43 +0100
Message-Id: <20201130125343.17469-1-jengelh@inai.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

-D is a preprocessor flag, needs to go into _CPPFLAGS;
-l is a library selection, needs to go into _LDADD/_LIBADD.
NETFILTER_CONNTRACK_CFLAGS was missing, too.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 utils/Makefile.am | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git utils/Makefile.am utils/Makefile.am
index a848b10..4afd91b 100644
--- utils/Makefile.am
+++ utils/Makefile.am
@@ -7,11 +7,11 @@ nfulnl_test_LDADD = ../src/libnetfilter_log.la
 nfulnl_test_LDFLAGS = -dynamic
 
 nf_log_SOURCES = nf-log.c
-nf_log_LDADD = ../src/libnetfilter_log.la
-nf_log_LDFLAGS = -dynamic -lmnl
+nf_log_LDADD = ../src/libnetfilter_log.la -lmnl
+nf_log_LDFLAGS = -dynamic
 if BUILD_NFCT
 nf_log_LDFLAGS += $(LIBNETFILTER_CONNTRACK_LIBS)
-nf_log_CFLAGS = -DBUILD_NFCT
+nf_log_CPPFLAGS = ${AM_CPPFLAGS} ${LIBNETFILTER_CONNTRACK_CFLAGS} -DBUILD_NFCT
 endif
 
 if BUILD_IPULOG
-- 
2.29.2

