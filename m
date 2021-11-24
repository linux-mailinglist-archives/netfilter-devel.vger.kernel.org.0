Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF4045D042
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 23:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345927AbhKXWsZ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 17:48:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345819AbhKXWsY (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:48:24 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67703C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Nov 2021 14:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=+b4yDbbw/e5HmIFFYcG2P3kX+BkDio/UWbearAILdNM=; b=MtofCcRE63LNY5keMFCPFZ1LD4
        Jdb8Dg5i95ghJTes8FbvMKrb8yFabdj3c8TZ44C57bh26uM5mgNGL9jybmk/oLwVVzbXKkrOFqUQs
        7TnH2+uM6IFYn7UymJpi6/Ne0ND2QleVOtVn/+OcwaJGj/VmxWTKhc6dIhUwFRlSviQE7h5LR9chv
        V82P+ujJ1Kt1d8a5A8Jw/Hc+/1qJU799jxtWxBAuY+v+/sq176+DMpGEwmle5+EabsCUaDQRYrlBE
        0Cv9WomywM0AVHli04lbp4rz32gvA4hZJ7CxuwjG8FkDIjoTLcSkAVqA5mNOcyOGruIZevcTDdHdJ
        9I2sO3dw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mq0h7-00563U-Rj
        for netfilter-devel@vger.kernel.org; Wed, 24 Nov 2021 22:24:49 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 15/30] output: PGSQL: improve mapping of DB columns to input-keys
Date:   Wed, 24 Nov 2021 22:24:12 +0000
Message-Id: <20211124222444.2597311-18-jeremy@azazel.net>
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

Hitherto, we copied the column-name to a buffer, iterated over it to
replace the underscores with full-stops, using `strchr` from the start
of the buffer on each iteration, then copied the buffer to the
input-key's `name` field.

Apart from the inefficiency, `strncpy` was used to do the copies, which
led gcc to complain:

  ulogd_output_PGSQL.c:204:17: warning: `strncpy` output may be truncated copying 31 bytes from a string of length 31

Furthermore, the buffer was not initialized, which meant that there was
also a possible buffer overrun if the column-name was too long, since
`strncpy` would not append a NUL.

Instead, we now copy the column-name directly to the input-key using
`snprintf`, and run `strchr` from the last underscore on each iteration.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/pgsql/ulogd_output_PGSQL.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/output/pgsql/ulogd_output_PGSQL.c b/output/pgsql/ulogd_output_PGSQL.c
index f5a2823a7e1d..71d94031ac4e 100644
--- a/output/pgsql/ulogd_output_PGSQL.c
+++ b/output/pgsql/ulogd_output_PGSQL.c
@@ -190,18 +190,18 @@ static int get_columns_pgsql(struct ulogd_pluginstance *upi)
 	}
 
 	for (i = 0; i < PQntuples(pi->pgres); i++) {
-		char buf[ULOGD_MAX_KEYLEN+1];
 		char *underscore;
 
+		snprintf(upi->input.keys[i].name,
+			 sizeof(upi->input.keys[i].name),
+			 "%s", PQgetvalue(pi->pgres, i, 0));
+
 		/* replace all underscores with dots */
-		strncpy(buf, PQgetvalue(pi->pgres, i, 0), ULOGD_MAX_KEYLEN);
-		while ((underscore = strchr(buf, '_')))
+		for (underscore = upi->input.keys[i].name;
+		     (underscore = strchr(underscore, '_')); )
 			*underscore = '.';
 
-		DEBUGP("field '%s' found: ", buf);
-
-		/* add it to list of input keys */
-		strncpy(upi->input.keys[i].name, buf, ULOGD_MAX_KEYLEN);
+		DEBUGP("field '%s' found\n", upi->input.keys[i].name);
 	}
 
 	/* ID (starting by '.') is a sequence */
-- 
2.33.0

