Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE09B6465B0
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 01:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbiLHAJ3 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 7 Dec 2022 19:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbiLHAJ1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 7 Dec 2022 19:09:27 -0500
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA2C8BD2B
        for <netfilter-devel@vger.kernel.org>; Wed,  7 Dec 2022 16:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nwl.cc;
        s=mail2022; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3WQbzl72DNJI/w9YQ9Yak4Vu1ZAZHpsKiKm4ZppkO9k=; b=ceryzGv1fUTq1wnZATZFPHTJZ9
        fBCUjESRErQlh/A0Kzlp44bsMf+Dn6mtbNbQ6IM2AShYzUJoO0O1Ewbn+gMpbT5RkNwHaQv0J54b9
        pp7JYSbxb/KIGDvFR7rPOiaRiiQ34GmMhtOJMqVR9yLjnN9aePXEic3PlcS/qekwT+Hw597rESaNZ
        UElXNMjoQ1sU1jviKaC81VxitDsqBQr6p5SEWiFaWa1nXj7KdTa23O/rtHNpupdL6g0bbMpxeS18/
        mJR9WM/IvL0LJovWB0OAADzBw7tJ7+DpIl9dCGYwUrvGIU1SXVmXuwFGdQWSgb8wW8hmYV6NbmDFF
        qVykWb2Q==;
Received: from localhost ([::1] helo=xic)
        by orbyte.nwl.cc with esmtp (Exim 4.94.2)
        (envelope-from <phil@nwl.cc>)
        id 1p34Td-0005QE-8S; Thu, 08 Dec 2022 01:09:25 +0100
From:   Phil Sutter <phil@nwl.cc>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     netfilter-devel@vger.kernel.org, Jan Engelhardt <jengelh@inai.de>
Subject: [libnetfilter_log PATCH] Makefile: Create LZMA-compressed dist-files
Date:   Thu,  8 Dec 2022 01:09:16 +0100
Message-Id: <20221208000916.17185-1-phil@nwl.cc>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index c0da1b8830c2b..aeb89e5ebf440 100644
--- a/configure.ac
+++ b/configure.ac
@@ -6,7 +6,7 @@ AC_CANONICAL_HOST
 AC_CONFIG_MACRO_DIR([m4])
 
 AM_INIT_AUTOMAKE([-Wall foreign subdir-objects
-	tar-pax no-dist-gzip dist-bzip2 1.6])
+	tar-pax no-dist-gzip dist-xz 1.6])
 m4_ifdef([AM_PROG_AR], [AM_PROG_AR])
 
 dnl kernel style compile messages
-- 
2.38.0

