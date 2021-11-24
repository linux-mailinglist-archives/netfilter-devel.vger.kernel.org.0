Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E432245D055
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 23:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351786AbhKXWtB (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 17:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245389AbhKXWtB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:49:01 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36345C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Nov 2021 14:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=czn9kCCeuSMZKvzrm+yXw4O0UC7YcfuC5W+X8RFYqH8=; b=mmFWCoCb5+LkAXs0n0C4zn7E+r
        AwB7jAxkhRTbXjgaIaps4Tq44NHwLOfot6FT/ikVwQIcds67vNDjXvF9QeKr96E36JNiiLvLNjrB7
        anEgIBYcvaMpEjJYibZLT2fCc8gwor5Kxp8sHue/JX0qWALSutq3QOpg6OPJ72pVJ5ayfrQ+iyOsD
        Qx1aabQc87XpYtj6pKRqqBN4zJBYct0dDbIpnM2YLmK08YCQ9cIBnGY4otYdQI+PZdofVG/60MY3z
        JZNzwijPW/IkvcduG7idTXI0jsS9tDKhO0hpMZ2LvAWvvURAMSOXB7MnOomyJrGxiYgAftslfd8MC
        BGyLV/+w==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mq0hA-00563U-5s
        for netfilter-devel@vger.kernel.org; Wed, 24 Nov 2021 22:24:52 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 25/32] db: improve mapping of input-keys to DB columns
Date:   Wed, 24 Nov 2021 22:24:31 +0000
Message-Id: <20211124222444.2597311-37-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211124222444.2597311-1-jeremy@azazel.net>
References: <20211124222444.2597311-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Currently, we copy the key-name to a buffer, iterate over it to replace
the full-stops with underscores, using `strchr` from the start of the
buffer on each iteration, then append the buffer to the SQL statement.

Apart from the inefficiency, `strncpy` is used to do the copies, which
leads gcc to complain:

  ../../util/db.c:118:25: warning: `strncpy` output may be truncated copying 31 bytes from a string of length 31

Furthermore, the buffer is one character too short and so there is the
possibility of overruns.

Instead, append the key-name directly to the statement using `sprintf`,
and run `strchr` from the last underscore on each iteration.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 util/db.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/util/db.c b/util/db.c
index 2dbe0db2fbfe..339e39ef4797 100644
--- a/util/db.c
+++ b/util/db.c
@@ -96,8 +96,6 @@ static int sql_createstmt(struct ulogd_pluginstance *upi)
 	    (procedure[strlen("INSERT")] == '\0' ||
 			procedure[strlen("INSERT")] == ' ')) {
 		char *stmt_val = mi->stmt;
-		char buf[ULOGD_MAX_KEYLEN];
-		char *underscore;
 
 		if(procedure[6] == '\0') {
 			/* procedure == "INSERT" */
@@ -112,13 +110,18 @@ static int sql_createstmt(struct ulogd_pluginstance *upi)
 			stmt_val += sprintf(stmt_val, "%s (", procedure);
 
 		for (i = 0; i < upi->input.num_keys; i++) {
+			char *underscore;
+
 			if (upi->input.keys[i].flags & ULOGD_KEYF_INACTIVE)
 				continue;
 
-			strncpy(buf, upi->input.keys[i].name, ULOGD_MAX_KEYLEN);	
-			while ((underscore = strchr(buf, '.')))
+			underscore = stmt_val;
+
+			stmt_val += sprintf(stmt_val, "%s,",
+					    upi->input.keys[i].name);
+
+			while ((underscore = strchr(underscore, '.')))
 				*underscore = '_';
-			stmt_val += sprintf(stmt_val, "%s,", buf);
 		}
 		*(stmt_val - 1) = ')';
 
-- 
2.33.0

