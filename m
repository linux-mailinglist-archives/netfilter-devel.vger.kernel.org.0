Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE56CD807
	for <lists+netfilter-devel@lfdr.de>; Sun,  6 Oct 2019 20:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729999AbfJFR4I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 6 Oct 2019 13:56:08 -0400
Received: from correo.us.es ([193.147.175.20]:56128 "EHLO mail.us.es"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729800AbfJFR4H (ORCPT <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 6 Oct 2019 13:56:07 -0400
Received: from antivirus1-rhel7.int (unknown [192.168.2.11])
        by mail.us.es (Postfix) with ESMTP id 553DB81409
        for <netfilter-devel@vger.kernel.org>; Sun,  6 Oct 2019 19:47:01 +0200 (CEST)
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 47696B7FF6
        for <netfilter-devel@vger.kernel.org>; Sun,  6 Oct 2019 19:47:01 +0200 (CEST)
Received: by antivirus1-rhel7.int (Postfix, from userid 99)
        id 3CF96BAACC; Sun,  6 Oct 2019 19:47:01 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on antivirus1-rhel7.int
X-Spam-Level: 
X-Spam-Status: No, score=-108.2 required=7.5 tests=ALL_TRUSTED,BAYES_50,
        SMTPAUTH_US2,USER_IN_WHITELIST autolearn=disabled version=3.4.1
Received: from antivirus1-rhel7.int (localhost [127.0.0.1])
        by antivirus1-rhel7.int (Postfix) with ESMTP id 0DDD14D746;
        Sun,  6 Oct 2019 19:46:59 +0200 (CEST)
Received: from 192.168.1.97 (192.168.1.97)
 by antivirus1-rhel7.int (F-Secure/fsigk_smtp/550/antivirus1-rhel7.int);
 Sun, 06 Oct 2019 19:46:59 +0200 (CEST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/antivirus1-rhel7.int)
Received: from salvia.here (sys.soleta.eu [212.170.55.40])
        (Authenticated sender: pneira@us.es)
        by entrada.int (Postfix) with ESMTPA id CD0F94251480;
        Sun,  6 Oct 2019 19:46:58 +0200 (CEST)
X-SMTPAUTHUS: auth mail.us.es
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     duncan_roe@optusnet.com.au, ffmancera@riseup.net
Subject: [PATCH] libmnl: doxygen: remove EXPORT_SYMBOL from the output
Date:   Sun,  6 Oct 2019 19:46:58 +0200
Message-Id: <20191006174658.14069-1-pablo@netfilter.org>
X-Mailer: git-send-email 2.11.0
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Add input filter to remove the internal EXPORT_SYMBOL macro that turns
on the compiler visibility attribute.

Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
---
 doxygen.cfg.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doxygen.cfg.in b/doxygen.cfg.in
index ee8fdfae97ce..31f01028aff6 100644
--- a/doxygen.cfg.in
+++ b/doxygen.cfg.in
@@ -77,7 +77,7 @@ EXAMPLE_PATH           =
 EXAMPLE_PATTERNS       = 
 EXAMPLE_RECURSIVE      = NO
 IMAGE_PATH             = 
-INPUT_FILTER           = 
+INPUT_FILTER           = "sed 's/EXPORT_SYMBOL//g'"
 FILTER_PATTERNS        = 
 FILTER_SOURCE_FILES    = NO
 SOURCE_BROWSER         = YES
-- 
2.11.0

