Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7980234EAE0
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Mar 2021 16:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbhC3OrV (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Mar 2021 10:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231622AbhC3Oq7 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Mar 2021 10:46:59 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B166EC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Mar 2021 07:46:58 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 65534)
        id 2A45B59E37A73; Tue, 30 Mar 2021 16:46:54 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id A712659E37A70
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Mar 2021 16:46:53 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Subject: [PATCH] files: move example files away from /etc
Date:   Tue, 30 Mar 2021 16:46:53 +0200
Message-Id: <20210330144653.25119-1-jengelh@inai.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

As per file-hierarchy(5), /etc is for "system-specific configuration", not
"vendor-supplied default configuration files".

Moreover, the comments in all-in-one.nft say it is an example, and so,
not a vendor config either.

Move it out of /etc.

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
For nftables.git.

 files/nftables/Makefile.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git files/nftables/Makefile.am files/nftables/Makefile.am
index fc8b94ea..ee88dd89 100644
--- files/nftables/Makefile.am
+++ files/nftables/Makefile.am
@@ -1,5 +1,4 @@
-pkgsysconfdir = ${sysconfdir}/nftables
-dist_pkgsysconf_DATA =	all-in-one.nft		\
+dist_pkgdata_DATA =	all-in-one.nft		\
 			arp-filter.nft		\
 			bridge-filter.nft	\
 			inet-filter.nft		\
-- 
2.30.2

