Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A75A4BF14B
	for <lists+netfilter-devel@lfdr.de>; Tue, 22 Feb 2022 06:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbiBVF0c (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 22 Feb 2022 00:26:32 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiBVF0B (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 22 Feb 2022 00:26:01 -0500
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98F2107D17
        for <netfilter-devel@vger.kernel.org>; Mon, 21 Feb 2022 21:25:35 -0800 (PST)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 0C4C558725FCC; Tue, 22 Feb 2022 05:46:44 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id 8B9CF5872649A;
        Tue, 22 Feb 2022 05:46:43 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     pablo@netfilter.org
Cc:     netfilter-devel@vger.kernel.org
Subject: [PATCH] build: add missing AM_CPPFLAGS to examples/
Date:   Tue, 22 Feb 2022 05:46:43 +0100
Message-Id: <20220222044643.25214-1-jengelh@inai.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

examples$ make V=1
depbase=`echo nft-buffer.o | sed 's|[^/]*$|.deps/&|;s|\.o$||'`;\
gcc -DHAVE_CONFIG_H -I. -I..     -g -O2 -MT nft-buffer.o -MD -MP -MF $depbase.Tpo -c -o nft-buffer.o nft-buffer.c &&\
mv -f $depbase.Tpo $depbase.Po
nft-buffer.c:3:10: fatal error: nftables/libnftables.h: No such file or directory

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 nftables 1.0.2 would not build successfully by default.

 examples/Makefile.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/examples/Makefile.am b/examples/Makefile.am
index c972170d..d7234ce4 100644
--- a/examples/Makefile.am
+++ b/examples/Makefile.am
@@ -1,3 +1,4 @@
+AM_CPPFLAGS = -I$(top_srcdir)/include
 noinst_PROGRAMS	= nft-buffer		\
 		  nft-json-file
 
-- 
2.35.1

