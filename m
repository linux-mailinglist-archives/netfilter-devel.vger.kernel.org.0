Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A59E63CACD
	for <lists+netfilter-devel@lfdr.de>; Tue, 29 Nov 2022 22:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiK2V6H (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 29 Nov 2022 16:58:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236987AbiK2V5r (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 29 Nov 2022 16:57:47 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BF563CEE
        for <netfilter-devel@vger.kernel.org>; Tue, 29 Nov 2022 13:57:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zgNYzdjj32yueE4gnK03LoU+h3kmqBliZfhO1c8YME4=; b=jh9NzD6vpxWfhNW2z2E8nbj0Ay
        MR8amjZ0U5ajoeGruIS4EKRug1U/2esNNBQSuhSU90KJWww4cnwNRUKUwks9CwJDJbCPN0rDAKjs1
        0F4B9hEaTu747zEie3kCxsUPt/xO16LD0DTvkIfa73c/eiLbasgTD5Vd2FDWnwFVVdLHKnqlObPay
        4o2xXfk5ChZLGxv+/Db4C33ZTMrkCA7QkiFK0+11KpIo+Jqy2KuTH+gcnpv3dH+KTQkMpySB931fb
        W1Vq4Bx2KT3P+phjhXuVcD7raOe3yMK8xd+w55WODzOdLr97SJG3+JwG9QM/vd7f7pxnsFONNxXND
        EAVpnjhw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1p08SM-00DjQp-K1
        for netfilter-devel@vger.kernel.org; Tue, 29 Nov 2022 21:47:58 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH ulogd2 v2 v2 31/34] output: pgsql: remove variable-length arrays
Date:   Tue, 29 Nov 2022 21:47:46 +0000
Message-Id: <20221129214749.247878-32-jeremy@azazel.net>
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

VLA's are deprecated.

Group all the SQL macros at the top of the file and format them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/pgsql/ulogd_output_PGSQL.c | 95 ++++++++++++++++++++-----------
 1 file changed, 62 insertions(+), 33 deletions(-)

diff --git a/output/pgsql/ulogd_output_PGSQL.c b/output/pgsql/ulogd_output_PGSQL.c
index 70bfbee7f565..b125674b7364 100644
--- a/output/pgsql/ulogd_output_PGSQL.c
+++ b/output/pgsql/ulogd_output_PGSQL.c
@@ -79,20 +79,46 @@ static struct config_keyset pgsql_kset = {
 #define schema_ce(x)	((x)->ces[DB_CE_NUM + 5])
 #define connstr_ce(x)	((x)->ces[DB_CE_NUM + 6])
 
-#define PGSQL_HAVE_NAMESPACE_TEMPLATE 			\
-	"SELECT nspname FROM pg_namespace n WHERE n.nspname='%s'"
+#define PGSQL_HAVE_NAMESPACE_TEMPLATE                         \
+	"SELECT nspname "                                     \
+	"FROM pg_namespace n "                                \
+	"WHERE n.nspname = '%s'"
+
+#define PGSQL_GETCOLUMN_TEMPLATE                              \
+	"SELECT a.attname "                                   \
+	"FROM pg_class c, pg_attribute a "                    \
+	"WHERE c.relname = '%s' "                             \
+	"AND a.attnum > 0 "                                   \
+	"AND a.attrelid = c.oid "                             \
+	"ORDER BY a.attnum"
+
+#define PGSQL_GETCOLUMN_TEMPLATE_SCHEMA                       \
+	"SELECT a.attname "                                   \
+	"FROM pg_attribute a, pg_class c "                    \
+	"LEFT JOIN pg_namespace n ON c.relnamespace = n.oid " \
+	"WHERE c.relname = '%s' "                             \
+	"AND n.nspname = '%s' "                               \
+	"AND a.attnum > 0 "                                   \
+	"AND a.attrelid = c.oid "                             \
+	"AND a.attisdropped = FALSE "                         \
+	"ORDER BY a.attnum"
 
 /* Determine if server support schemas */
 static int pgsql_namespace(struct ulogd_pluginstance *upi)
 {
 	struct pgsql_instance *pi = (struct pgsql_instance *) upi->private;
-	char pgbuf[strlen(PGSQL_HAVE_NAMESPACE_TEMPLATE) +
-		   strlen(schema_ce(upi->config_kset).u.string) + 1];
 	PGresult *pgres;
+	char *pgbuf;
+	int rv = -1;
 
 	if (!pi->dbh)
 		return -1;
 
+	pgbuf = malloc(sizeof(PGSQL_HAVE_NAMESPACE_TEMPLATE) +
+		       strlen(schema_ce(upi->config_kset).u.string));
+	if (!pgbuf)
+		return -1;
+
 	sprintf(pgbuf, PGSQL_HAVE_NAMESPACE_TEMPLATE,
 		schema_ce(upi->config_kset).u.string);
 	ulogd_log(ULOGD_DEBUG, "%s\n", pgbuf);
@@ -100,7 +126,7 @@ static int pgsql_namespace(struct ulogd_pluginstance *upi)
 	pgres = PQexec(pi->dbh, pgbuf);
 	if (!pgres) {
 		ulogd_log(ULOGD_DEBUG, "\n result false");
-		return -1;
+		goto err_free_buf;
 	}
 
 	if (PQresultStatus(pgres) == PGRES_TUPLES_OK) {
@@ -108,51 +134,50 @@ static int pgsql_namespace(struct ulogd_pluginstance *upi)
 			ulogd_log(ULOGD_DEBUG, "using schema %s\n",
 				  schema_ce(upi->config_kset).u.string);
 			pi->db_inst.schema = schema_ce(upi->config_kset).u.string;
-		} else {
+			rv = 0;
+		} else
 			ulogd_log(ULOGD_ERROR, "schema %s not found: %s\n",
-				 schema_ce(upi->config_kset).u.string, PQerrorMessage(pi->dbh));
-			PQclear(pgres);
-			return -1;
-		}
+				  schema_ce(upi->config_kset).u.string,
+				  PQerrorMessage(pi->dbh));
 	} else {
 		pi->db_inst.schema = NULL;
+		rv = 0;
 	}
 
 	PQclear(pgres);
 
-	return 0;
-}
-
-#define PGSQL_GETCOLUMN_TEMPLATE 			\
-	"SELECT  a.attname FROM pg_class c, pg_attribute a WHERE c.relname ='%s' AND a.attnum>0 AND a.attrelid=c.oid ORDER BY a.attnum"
+err_free_buf:
+	free(pgbuf);
 
-#define PGSQL_GETCOLUMN_TEMPLATE_SCHEMA 		\
-	"SELECT a.attname FROM pg_attribute a, pg_class c LEFT JOIN pg_namespace n ON c.relnamespace=n.oid WHERE c.relname ='%s' AND n.nspname='%s' AND a.attnum>0 AND a.attrelid=c.oid AND a.attisdropped=FALSE ORDER BY a.attnum"
+	return rv;
+}
 
 /* find out which columns the table has */
 static int get_columns_pgsql(struct ulogd_pluginstance *upi)
 {
 	struct pgsql_instance *pi = (struct pgsql_instance *) upi->private;
-	char pgbuf[strlen(PGSQL_GETCOLUMN_TEMPLATE_SCHEMA)
-		   + strlen(table_ce(upi->config_kset).u.string)
-		   + strlen(pi->db_inst.schema) + 2];
 	PGresult *pgres;
-	int rv;
+	char *pgbuf;
+	int rv = -1;
 
 	if (!pi->dbh) {
 		ulogd_log(ULOGD_ERROR, "no database handle\n");
 		return -1;
 	}
 
-	if (pi->db_inst.schema) {
-		snprintf(pgbuf, sizeof(pgbuf)-1,
-			 PGSQL_GETCOLUMN_TEMPLATE_SCHEMA,
-			 table_ce(upi->config_kset).u.string,
-			 pi->db_inst.schema);
-	} else {
-		snprintf(pgbuf, sizeof(pgbuf)-1, PGSQL_GETCOLUMN_TEMPLATE,
-			 table_ce(upi->config_kset).u.string);
-	}
+	pgbuf = malloc(sizeof(PGSQL_GETCOLUMN_TEMPLATE_SCHEMA) +
+		       strlen(table_ce(upi->config_kset).u.string) +
+		       strlen(pi->db_inst.schema));
+	if (!pgbuf)
+		return -1;
+
+	if (pi->db_inst.schema)
+		sprintf(pgbuf, PGSQL_GETCOLUMN_TEMPLATE_SCHEMA,
+			table_ce(upi->config_kset).u.string,
+			pi->db_inst.schema);
+	else
+		sprintf(pgbuf, PGSQL_GETCOLUMN_TEMPLATE,
+			table_ce(upi->config_kset).u.string);
 
 	ulogd_log(ULOGD_DEBUG, "%s\n", pgbuf);
 
@@ -160,14 +185,13 @@ static int get_columns_pgsql(struct ulogd_pluginstance *upi)
 	if (!pgres) {
 		ulogd_log(ULOGD_DEBUG, "result false (%s)",
 			  PQerrorMessage(pi->dbh));
-		return -1;
+		goto err_free_buf;
 	}
 
 	if (PQresultStatus(pgres) != PGRES_TUPLES_OK) {
 		ulogd_log(ULOGD_DEBUG, "pres_command_not_ok (%s)",
 			  PQerrorMessage(pi->dbh));
-		PQclear(pgres);
-		return -1;
+		goto err_clear_res;
 	}
 
 	rv = ulogd_db_alloc_input_keys(upi, PQntuples(pgres), pgres);
@@ -176,7 +200,12 @@ static int get_columns_pgsql(struct ulogd_pluginstance *upi)
 	if (!rv && upi->input.keys[0].name[0] == '.')
 		upi->input.keys[0].flags |= ULOGD_KEYF_INACTIVE;
 
+err_clear_res:
 	PQclear(pgres);
+
+err_free_buf:
+	free(pgbuf);
+
 	return rv;
 }
 
-- 
2.35.1

