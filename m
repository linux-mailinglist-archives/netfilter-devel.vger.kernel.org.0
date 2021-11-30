Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A869463204
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Nov 2021 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236568AbhK3LSO (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Nov 2021 06:18:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbhK3LSM (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:18:12 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FAEC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Nov 2021 03:14:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=bmER+1Hae1bUUjm5c2uJGCDLC9LwXZvjPZrUDf/xde0=; b=ipTcRkJnDmBa2ZU1xhHaWnzXkV
        1tTZ45BrrEWwUrGFCA4hWXQW6+3VbwotTRm4XLw4IKNXPD8qcgBysLvXCzSY5UsezN0fcbxdVZmOx
        4hOk6bHzS7jKMO0CEq3GiIk8VgCBmMFObCJkfurLLA5IjeDdr/NixO0RfqlAXWJ94O5vDlX0MkMVs
        4aOHGIiJv0uymN9CDrwLI8w7eZgqx08vUHqM5Dx3OzHnGXEeFtnTyOBJ+s2/hTfQNfpBPTF8ENszp
        MI3vrC81mUQVStvoxdcbId2+SvWP17aNYTezTKW1+t3NPQ9UJUdiPxojU+AGogQky+IVwc361tERI
        GJ7kLUpA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1ms0ns-00Awwr-8R
        for netfilter-devel@vger.kernel.org; Tue, 30 Nov 2021 10:56:04 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 14/32] output: DBI: fix configuration of DB connection
Date:   Tue, 30 Nov 2021 10:55:42 +0000
Message-Id: <20211130105600.3103609-15-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211130105600.3103609-1-jeremy@azazel.net>
References: <20211130105600.3103609-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

In `open_db_dbi`, we test whether various config-settings are defined
by comparing their string values to `NULL`.  However, the `u.string`
member of `struct config_entry` is an array, not a pointer, so it is
never `NULL`.  Instead, check whether the string is empty.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/dbi/ulogd_output_DBI.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/output/dbi/ulogd_output_DBI.c b/output/dbi/ulogd_output_DBI.c
index 57e3058036d9..5eee6b593b5b 100644
--- a/output/dbi/ulogd_output_DBI.c
+++ b/output/dbi/ulogd_output_DBI.c
@@ -175,10 +175,10 @@ static int close_db_dbi(struct ulogd_pluginstance *upi)
 static int open_db_dbi(struct ulogd_pluginstance *upi)
 {
 	struct dbi_instance *pi = (struct dbi_instance *) upi->private;
-	char *server = host_ce(upi->config_kset).u.string;
-	char *user = user_ce(upi->config_kset).u.string;
-	char *pass = pass_ce(upi->config_kset).u.string;
-	char *db = db_ce(upi->config_kset).u.string;
+	char *server = host_ce  (upi->config_kset).u.string;
+	char *user   = user_ce  (upi->config_kset).u.string;
+	char *pass   = pass_ce  (upi->config_kset).u.string;
+	char *db     = db_ce    (upi->config_kset).u.string;
 	char *dbtype = dbtype_ce(upi->config_kset).u.string;
 	dbi_driver driver;
 	int ret;
@@ -203,13 +203,13 @@ static int open_db_dbi(struct ulogd_pluginstance *upi)
 		return -1;
 	}
 
-	if (server)
+	if (server[0])
 		dbi_conn_set_option(pi->dbh, "host", server);
-	if (user)
+	if (user[0])
 		dbi_conn_set_option(pi->dbh, "username", user);
-	if (pass)
+	if (pass[0])
 		dbi_conn_set_option(pi->dbh, "password", pass);
-	if (db)
+	if (db[0])
 		dbi_conn_set_option(pi->dbh, "dbname", db);
 
 	ret = dbi_conn_connect(pi->dbh);
-- 
2.33.0

