Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAAB63CACF
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Nov 2022 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiK2V6I (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Nov 2022 16:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237026AbiK2V5u (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:57:50 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E88716C733
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 13:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=I4JFRC9OM/P3q5tvU9PM+Tj6WfEoXwnDWKkCHUB1D7k=; b=CxC30RasMfGJO8I03+VWdI/Y1k
        oQNOHG49+0yxKOTLIY69gYuqfKS6bjlTHEExionk+3C3JV7DVY8W5bVDtNYeEJFsfEDopSQMSG/9j
        VPyYqBB8HuuY92XL9Xl1Pz4jmP8SmK3vnjfD35VmR1m9jibMCmv1PhpYJgdjvw7h8A2W21hpQqtIw
        cD/G/TorxkJ8oe3yojxwS4mTDoDzSE/kJArGbvS6i2S/hJuS17Y58A7TZZFpaRF209FcazFbF0gDk
        vcJreSrd2zbdbwGvOdDVlOMGkH3gI953jfvfu6zR95scN6SdsTcQ80amPj433vdEuXe3a5zQOtgGm
        nDcm4Ecg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1p08SK-00DjQp-RG
        for netfilter-devel@vger.kernel.org; Tue, 29 Nov 2022 21:47:56 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH ulogd2 v2 v2 19/34] db: improve calculation of sql statement length
Date:   Tue, 29 Nov 2022 21:47:34 +0000
Message-Id: <20221129214749.247878-20-jeremy@azazel.net>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221129214749.247878-1-jeremy@azazel.net>
References: <20221129214749.247878-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Currently, we calculate the space required from a prefix which doesn't
correspond to anything we use, space for each key, although the SQL
statement may not contain the keys, and a fixed amount for each value.
However, we can use snprintf to tighten up the estimate by using
`snprintf(NULL, 0, ...)` to tell us how much room we actually need for
the parts we know in advance.

Rename a couple of variables and replace `strlen` with `sizeof` where
appropriate.

Sort included headers.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 util/db.c | 149 ++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 105 insertions(+), 44 deletions(-)

diff --git a/util/db.c b/util/db.c
index afa86a3f137b..ce1273638ae0 100644
--- a/util/db.c
+++ b/util/db.c
@@ -24,15 +24,16 @@
  *
  */
 
-#include <unistd.h>
-#include <stdlib.h>
-#include <string.h>
 #include <errno.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <time.h>
 #include <inttypes.h>
 #include <pthread.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <time.h>
+#include <unistd.h>
+#include <arpa/inet.h>
+#include <netinet/in.h>
 
 #include <ulogd/ulogd.h>
 #include <ulogd/db.h>
@@ -47,6 +48,10 @@ static void _stop_db(struct ulogd_pluginstance *upi);
 
 static char *_format_key(char *key);
 static int _create_sql_stmt(struct ulogd_pluginstance *upi);
+static unsigned int _calc_sql_stmt_size(const char *procedure,
+					const char *schema, const char *table,
+					struct ulogd_key *keys,
+					unsigned int num_keys);
 static void _bind_sql_stmt(struct ulogd_pluginstance *upi,
 			   char *stmt);
 
@@ -410,33 +415,23 @@ _format_key(char *key)
 	return key;
 }
 
-#define SQL_INSERTTEMPL   "SELECT P(Y)"
-#define SQL_VALSIZE	100
-
 /* create the static part of our insert statement */
 static int
 _create_sql_stmt(struct ulogd_pluginstance *upi)
 {
 	struct db_instance *di = (struct db_instance *) upi->private;
+	char *procedure = procedure_ce(upi->config_kset).u.string;
+	char *table = table_ce(upi->config_kset).u.string;
 	unsigned int size;
 	unsigned int i;
-	char *table = table_ce(upi->config_kset).u.string;
-	char *procedure = procedure_ce(upi->config_kset).u.string;
+	char *stmtp;
 
 	if (di->stmt)
 		free(di->stmt);
 
-	/* caclulate the size for the insert statement */
-	size = strlen(SQL_INSERTTEMPL) + strlen(table);
-
-	for (i = 0; i < upi->input.num_keys; i++) {
-		if (upi->input.keys[i].flags & ULOGD_KEYF_INACTIVE)
-			continue;
-		/* we need space for the key and a comma, as well as
-		 * enough space for the values */
-		size += strlen(upi->input.keys[i].name) + 1 + SQL_VALSIZE;
-	}
-	size += strlen(procedure);
+	/* calculate the size for the insert statement */
+	size = _calc_sql_stmt_size(procedure, di->schema, table,
+				   upi->input.keys, upi->input.num_keys);
 
 	ulogd_log(ULOGD_DEBUG, "allocating %u bytes for statement\n", size);
 
@@ -447,22 +442,22 @@ _create_sql_stmt(struct ulogd_pluginstance *upi)
 	}
 	di->ring.length = size + 1;
 
-	if (strncasecmp(procedure,"INSERT", strlen("INSERT")) == 0 &&
-	    (procedure[strlen("INSERT")] == '\0' ||
-			procedure[strlen("INSERT")] == ' ')) {
-		char *stmt_val = di->stmt;
+	stmtp = di->stmt;
+
+	if (strncasecmp(procedure, "INSERT", sizeof("INSERT") - 1) == 0 &&
+	    (procedure[sizeof("INSERT") - 1] == '\0' ||
+	     procedure[sizeof("INSERT") - 1] == ' ')) {
 
-		if(procedure[6] == '\0') {
+		if(procedure[sizeof("INSERT") - 1] == '\0') {
 			/* procedure == "INSERT" */
 			if (di->schema)
-				stmt_val += sprintf(stmt_val,
-						    "insert into %s.%s (",
-						    di->schema, table);
+				stmtp += sprintf(stmtp, "insert into %s.%s (",
+						di->schema, table);
 			else
-				stmt_val += sprintf(stmt_val,
-						    "insert into %s (", table);
+				stmtp += sprintf(stmtp, "insert into %s (",
+						table);
 		} else
-			stmt_val += sprintf(stmt_val, "%s (", procedure);
+			stmtp += sprintf(stmtp, "%s (", procedure);
 
 		for (i = 0; i < upi->input.num_keys; i++) {
 			char *underscore;
@@ -470,30 +465,96 @@ _create_sql_stmt(struct ulogd_pluginstance *upi)
 			if (upi->input.keys[i].flags & ULOGD_KEYF_INACTIVE)
 				continue;
 
-			underscore = stmt_val;
+			underscore = stmtp;
 
-			stmt_val += sprintf(stmt_val, "%s,",
-					    upi->input.keys[i].name);
+			stmtp += sprintf(stmtp, "%s,",
+					upi->input.keys[i].name);
 
 			while ((underscore = strchr(underscore, '.')))
 				*underscore = '_';
 		}
-		*(stmt_val - 1) = ')';
+		stmtp --;
 
-		sprintf(stmt_val, " values (");
-	} else if (strncasecmp(procedure,"CALL", strlen("CALL")) == 0) {
-		sprintf(di->stmt, "CALL %s(", procedure);
-	} else {
-		sprintf(di->stmt, "SELECT %s(", procedure);
-	}
+		stmtp += sprintf(stmtp, ") values (");
+
+	} else if (strncasecmp(procedure, "CALL", sizeof("CALL") - 1) == 0)
+		stmtp += sprintf(stmtp, "CALL %s(", procedure);
+	else
+		stmtp += sprintf(stmtp, "SELECT %s(", procedure);
 
-	di->stmt_offset = strlen(di->stmt);
+	di->stmt_offset = stmtp - di->stmt;
 
 	ulogd_log(ULOGD_DEBUG, "stmt='%s'\n", di->stmt);
 
 	return 0;
 }
 
+#define SQL_VALSIZE 100
+
+static unsigned int
+_calc_sql_stmt_size(const char *procedure,
+		    const char *schema, const char *table,
+		    struct ulogd_key *keys, unsigned int num_keys)
+{
+	unsigned int i, size = 0;
+	bool include_keys;
+
+	/* Fixed size bit */
+
+	if (strncasecmp(procedure, "INSERT", sizeof("INSERT") - 1) == 0 &&
+	    (procedure[sizeof("INSERT") - 1] == '\0' ||
+	     procedure[sizeof("INSERT") - 1] == ' ')) {
+
+		/* insert into t (k0, k1, ...) values (v0, v1, ...) */
+
+		if(procedure[sizeof("INSERT") - 1] == '\0') {
+			/* procedure == "INSERT" */
+			if (schema)
+				size += snprintf(NULL, 0,
+						 "insert into %s.%s (",
+						 schema, table);
+			else
+				size += snprintf(NULL, 0,
+						 "insert into %s (", table);
+		} else
+			size += snprintf(NULL, 0, "%s (", procedure);
+
+		size += snprintf(NULL, 0, ") values (");
+
+		include_keys = true;
+
+	} else {
+
+		/* `call p(v0, v1, ...)` or `select p(v0, v1, ...)` */
+
+		if (strncasecmp(procedure, "CALL", sizeof("CALL") - 1) == 0)
+			size += snprintf(NULL, 0, "CALL %s(", procedure);
+		else
+			size += snprintf(NULL, 0, "SELECT %s(", procedure);
+
+		include_keys = false;
+
+	}
+
+	/* Per-field bits.
+	 *
+	 * We need space for the value and a comma or the closing parenthesis.
+	 * We may also need space for the key and a comma.
+	 */
+
+	for (i = 0; i < num_keys; i++) {
+		if (keys[i].flags & ULOGD_KEYF_INACTIVE)
+			continue;
+		if (include_keys)
+			size += strlen(keys[i].name) + 1;
+		size += SQL_VALSIZE + 1;
+	}
+
+	size++; /* Allow for the final NUL */
+
+	return size;
+}
+
 static void
 _bind_sql_stmt(struct ulogd_pluginstance *upi, char *start)
 {
-- 
2.35.1

