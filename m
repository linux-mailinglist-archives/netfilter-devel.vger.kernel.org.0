Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EBDE440A72
	for <lists+netfilter-devel@lfdr.de>; Sat, 30 Oct 2021 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhJ3RNm (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 30 Oct 2021 13:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230232AbhJ3RNm (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 30 Oct 2021 13:13:42 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:fb7d:d6d6:e0:4cff:fe83:e514])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9867CC061570
        for <netfilter-devel@vger.kernel.org>; Sat, 30 Oct 2021 10:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kEz+B4wJFCikgqCrwaOq7Rm5jqNbSBJpO/0rIku/vn8=; b=YvbwHHtVmgg7a8kjK+jggYy3j2
        trsadzO/V3GnPVwNIP0bChrQx9NF1xWOhE8TvS8UWDpNG3Ovkcv/BisRRz/CK7N/YAVVmzWIqj2rO
        YmeEpSUsO3Ude1kqDcDOsJzCVhhe6N8nT6ZypNbNJLjyHagIaHt8CwGxWg+24v/1oRGBVD124IAbb
        U5MHffQ8ISPEXiuMKr8K3lCKcJXLq+Z/PUj4fRHIkrdYzjAyE4d6FSZKDfgbapnUQ+v+jYCXNYPXl
        GnTWyNMPHQGGHuTn8Ts8uLeYjjDt23Qe0X9SQU13hoYrsG1bMdKhzbdoP71o/aef4haNTn16V9onb
        UaooPMMg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae] helo=ulthar.scientificgames.com)
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mgrTA-00AFgT-Ok
        for netfilter-devel@vger.kernel.org; Sat, 30 Oct 2021 17:44:36 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH 21/26] output: SQLITE3: catch errors creating SQL statement
Date:   Sat, 30 Oct 2021 17:44:27 +0100
Message-Id: <20211030164432.1140896-22-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211030164432.1140896-1-jeremy@azazel.net>
References: <20211030164432.1140896-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/sqlite3/ulogd_output_SQLITE3.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/output/sqlite3/ulogd_output_SQLITE3.c b/output/sqlite3/ulogd_output_SQLITE3.c
index 053d7a3b0238..f2ee03b8c446 100644
--- a/output/sqlite3/ulogd_output_SQLITE3.c
+++ b/output/sqlite3/ulogd_output_SQLITE3.c
@@ -104,11 +104,14 @@ add_row(struct ulogd_pluginstance *pi)
 		ret = sqlite3_finalize(priv->p_stmt);
 		priv->p_stmt = NULL;
 
-		if (ret == SQLITE_SCHEMA)
-			sqlite3_createstmt(pi);
-		else {
+		if (ret != SQLITE_SCHEMA) {
 			ulogd_log(ULOGD_ERROR, "SQLITE3: step: %s\n",
-					  sqlite3_errmsg(priv->dbh));
+				  sqlite3_errmsg(priv->dbh));
+			goto err_reset;
+		}
+		if (sqlite3_createstmt(pi) < 0) {
+			ulogd_log(ULOGD_ERROR,
+				  "SQLITE3: Could not create statement.\n");
 			goto err_reset;
 		}
 	}
@@ -253,8 +256,8 @@ sqlite3_createstmt(struct ulogd_pluginstance *pi)
 	sqlite3_prepare(priv->dbh, priv->stmt, -1, &priv->p_stmt, 0);
 	if (priv->p_stmt == NULL) {
 		ulogd_log(ULOGD_ERROR, "SQLITE3: prepare: %s\n",
-				  sqlite3_errmsg(priv->dbh));
-		return 1;
+			  sqlite3_errmsg(priv->dbh));
+		return -1;
 	}
 
 	DEBUGP("statement prepared.\n");
@@ -388,7 +391,10 @@ sqlite3_start(struct ulogd_pluginstance *pi)
 	}
 
 	/* create and prepare the actual insert statement */
-	sqlite3_createstmt(pi);
+	if (sqlite3_createstmt(pi) < 0) {
+		ulogd_log(ULOGD_ERROR, "SQLITE3: Could not create statement.\n");
+		return -1;
+	}
 
 	return 0;
 }
-- 
2.33.0

