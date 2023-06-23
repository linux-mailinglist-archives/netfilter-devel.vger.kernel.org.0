Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526D73BA8B
	for <lists+netfilter-devel@lfdr.de>; Fri, 23 Jun 2023 16:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbjFWOqB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 23 Jun 2023 10:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232385AbjFWOpr (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 23 Jun 2023 10:45:47 -0400
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC713E
        for <netfilter-devel@vger.kernel.org>; Fri, 23 Jun 2023 07:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FXTjzUuMqI4BR1Puh9+r61YeNlDWdnG3Ak07UOPU1tg=; b=pocAG3iRDo6TvWwIJlqpbxsENP
        3Z4FktCOYhR0UlMhczRz6rjHH6j3NgJ+ifzLLS6jl6ws0fAbGICpiynZT3PJy0fvaBxJM7/J6Ewti
        InNcEW+Ez9+YCaHn1A+Q5ei2CCPVX1nSEZMDc+iXEGzm9qV4TwrndKzE8oPoGvm+TtpqpOZ399IZd
        qvrjMkqJHCTIXcgGquipgojYzWIRqa3pYb2oioA81uus1junAmzH8SfX1y1hwo26ssZVIOCrVU3YP
        gUhYLTQSuO1ORxEbyk53+4ZRA9Cu/JvbgN+/jNRrHKWODtJ2S2CPnZJPs3NYBwY9QD/f7gp8Eblvr
        cO12mO6g==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1qCi2S-0002Mx-OD; Fri, 23 Jun 2023 16:45:28 +0200
From:   Phil Sutter <phil@nwl.cc>
To:     Florian Westphal <fw@strlen.de>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>,
        Pablo Neira Ayuso <pablo@netfilter.org>
Subject: [ulogd2 PATCH] Makefile: Create LZMA-compressed dist-files
Date:   Fri, 23 Jun 2023 16:45:20 +0200
Message-Id: <20230623144520.970-1-phil@nwl.cc>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Use a more modern alternative to bzip2.

Suggested-by: Jan Engelhardt <jengelh@inai.de>
Suggested-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Phil Sutter <phil@nwl.cc>
---
Sorry for this delayed change (more than half a year past the same
change in all other projects). I just discovered there's ulogd and
ulogd2.
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 70eed9dc17451..3c9249e3cac56 100644
--- a/configure.ac
+++ b/configure.ac
@@ -2,7 +2,7 @@ dnl Process this file with autoconf to produce a configure script.
 AC_INIT([ulogd], [2.0.8])
 AC_PREREQ([2.50])
 AC_CONFIG_AUX_DIR([build-aux])
-AM_INIT_AUTOMAKE([-Wall foreign tar-pax no-dist-gzip dist-bzip2 1.10b subdir-objects])
+AM_INIT_AUTOMAKE([-Wall foreign tar-pax no-dist-gzip dist-xz 1.10b subdir-objects])
 AC_CONFIG_HEADERS([config.h])
 AC_CONFIG_MACRO_DIR([m4])
 
-- 
2.40.0

