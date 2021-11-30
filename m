Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8B4463209
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Nov 2021 12:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236342AbhK3LSW (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Nov 2021 06:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbhK3LSW (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:18:22 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140AEC061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Nov 2021 03:15:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=kVb7PIHvxGcpiVFTyFAN3ndXM30ZwDzJyS2qjEHGJ+4=; b=sGL9WGtSC3de767RveBeHo+K8Q
        oYt81CoaKEvH6YSMoCb76tTk/eXUFUG4kMQGLsuEP3yA65NoZO4SLMisvGsPANzvau8tghU/u0IAy
        dL2Rm/WhFRdN/5Njj75Vbmul0XOuDOBz46wYQbOA3I369V0jFXKOtaebqWc8Uxig0fWAzOZalsBPM
        gY016Ttf23gGHq5/QhK/ni3qAvjko9gE27qCHoKYJZJhKjvwupD0kypjHp5VO/9HGW6Z/L5ZjAoVd
        bUog3P09dT6TVqsHS3YufFW1rXl+9ibkB1+eKIWujgRy4lr4ynkq6smX8hIi44cfidokSzu1d10re
        kB9MhfTw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1ms0nt-00Awwr-2Z
        for netfilter-devel@vger.kernel.org; Tue, 30 Nov 2021 10:56:05 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 22/32] output: SQLITE3: improve mapping of fields to DB columns
Date:   Tue, 30 Nov 2021 10:55:50 +0000
Message-Id: <20211130105600.3103609-23-jeremy@azazel.net>
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

Currently, we derive a field-name by replacing all the underscores in a
DB column-name with full-stops and use the field-name to find the
matching input-key.  However, every time we create a new insert SQL
statement, we derive the column-names by copying the field-names to a
buffer, replacing all the full-stops with underscores, and then
appending the buffer containing the column-name to the one containing
the statments.

Apart from the inefficiency, `strncpy` is used to do the copies, which
leads gcc to complain:

  ulogd_output_SQLITE3.c:234:17: warning: `strncpy` output may be truncated copying 31 bytes from a string of length 31

Instead, leave the underscores in the field-name, but copy it once to a
buffer in which the underscores are replaced and use this to find the
input-key.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/sqlite3/ulogd_output_SQLITE3.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/output/sqlite3/ulogd_output_SQLITE3.c b/output/sqlite3/ulogd_output_SQLITE3.c
index e3040a8a2fac..c61694a51d47 100644
--- a/output/sqlite3/ulogd_output_SQLITE3.c
+++ b/output/sqlite3/ulogd_output_SQLITE3.c
@@ -214,8 +214,6 @@ sqlite3_createstmt(struct ulogd_pluginstance *pi)
 {
 	struct sqlite3_priv *priv = (void *)pi->private;
 	struct field *f;
-	char buf[ULOGD_MAX_KEYLEN + 1];
-	char *underscore;
 	char *stmt_pos;
 	int i, cols = 0;
 
@@ -231,13 +229,7 @@ sqlite3_createstmt(struct ulogd_pluginstance *pi)
 	stmt_pos += sprintf(stmt_pos, "insert into %s (", table_ce(pi));
 
 	tailq_for_each(f, priv->fields, link) {
-		strncpy(buf, f->name, ULOGD_MAX_KEYLEN);
-
-		while ((underscore = strchr(buf, '.')))
-			*underscore = '_';
-
-		stmt_pos += sprintf(stmt_pos, "%s,", buf);
-
+		stmt_pos += sprintf(stmt_pos, "%s,", f->name);
 		cols++;
 	}
 
@@ -271,10 +263,15 @@ sqlite3_createstmt(struct ulogd_pluginstance *pi)
 static struct ulogd_key *
 ulogd_find_key(struct ulogd_pluginstance *pi, const char *name)
 {
+	char buf[ULOGD_MAX_KEYLEN + 1] = "";
 	unsigned int i;
 
+	/* replace all underscores with dots */
+	for (i = 0; i < sizeof(buf) - 1 && name[i]; ++i)
+		buf[i] = name[i] != '_' ? name[i] : '.';
+
 	for (i = 0; i < pi->input.num_keys; i++) {
-		if (strcmp(pi->input.keys[i].name, name) == 0)
+		if (strcmp(pi->input.keys[i].name, buf) == 0)
 			return &pi->input.keys[i];
 	}
 
@@ -323,7 +320,6 @@ sqlite3_init_db(struct ulogd_pluginstance *pi)
 
 	for (col = 0; col < num_cols; col++) {
 		struct field *f;
-		char *underscore;
 
 		/* prepend it to the linked list */
 		if ((f = calloc(1, sizeof(struct field))) == NULL) {
@@ -333,11 +329,6 @@ sqlite3_init_db(struct ulogd_pluginstance *pi)
 		snprintf(f->name, sizeof(f->name),
 			 "%s", sqlite3_column_name(schema_stmt, col));
 
-		/* replace all underscores with dots */
-		for (underscore = f->name;
-		     (underscore = strchr(underscore, '_')) != NULL; )
-			*underscore = '.';
-
 		DEBUGP("field '%s' found\n", f->name);
 
 		if ((f->key = ulogd_find_key(pi, f->name)) == NULL) {
-- 
2.33.0

