Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C3F3F10F108
	for <lists+netfilter-devel@lfdr.de>; Mon,  2 Dec 2019 20:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727963AbfLBTwK (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 2 Dec 2019 14:52:10 -0500
Received: from a3.inai.de ([88.198.85.195]:39572 "EHLO a3.inai.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727586AbfLBTwK (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 2 Dec 2019 14:52:10 -0500
Received: by a3.inai.de (Postfix, from userid 65534)
        id 0D8935985090B; Mon,  2 Dec 2019 20:52:09 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on a3.inai.de
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.2
Received: from a4.inai.de (a4.inai.de [IPv6:2a01:4f8:10b:45d8::f8])
        by a3.inai.de (Postfix) with ESMTP id C05F959842AE8;
        Mon,  2 Dec 2019 20:52:04 +0100 (CET)
From:   Jan Engelhardt <jengelh@inai.de>
To:     netfilter-devel@vger.kernel.org
Cc:     jengelh@inai.de
Subject: [PATCH] build: remove stray @ sign in manpage
Date:   Mon,  2 Dec 2019 20:52:04 +0100
Message-Id: <20191202195204.23316-1-jengelh@inai.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Because the sed command was not matching the trailing @, it
was left in the manpage, leading to

NAME
       ebtables-legacy (2.0.11@) - Ethernet bridge frame table administration (legacy)

Signed-off-by: Jan Engelhardt <jengelh@inai.de>
---
 Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile.am b/Makefile.am
index b879941..6181003 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -64,6 +64,6 @@ ebtables-legacy-save: ebtables-save.in ${top_builddir}/config.status
 	${AM_V_GEN}sed -e 's![@]sbindir@!${sbindir}!g' <$< >$@
 
 ebtables-legacy.8: ebtables-legacy.8.in ${top_builddir}/config.status
-	${AM_V_GEN}sed -e 's![@]PACKAGE_VERSION!${PACKAGE_VERSION}!g' \
+	${AM_V_GEN}sed -e 's![@]PACKAGE_VERSION@!${PACKAGE_VERSION}!g' \
 		-e 's![@]PACKAGE_DATE@!${PROGDATE}!g' \
 		-e 's![@]LOCKFILE@!${LOCKFILE}!g' <$< >$@
-- 
2.24.0

