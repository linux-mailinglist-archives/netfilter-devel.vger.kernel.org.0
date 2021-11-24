Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BFB245D044
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 23:45:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345819AbhKXWs1 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 17:48:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345477AbhKXWs1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:48:27 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E5DC061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Nov 2021 14:45:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=O3F2qM0cpdAn4I5/l4MW1gDhk2alS4YlJVZ/5rVPSUE=; b=iSQjLSqIPNk0affcDrwLxFJNpz
        zlktZ+14EB4LG6tObLfeoBEDNh3LYSsCuMYI/zWiAhku4zF2jPzKkIt7W7dmTpeFimXVBPmN+l9Nf
        3v0j73FPACAYx1C0aC/x3BsLXoKX+mtFXFrhsSRkZ+mpPOEZ32pA6/lrEuJpwYRoW4AduY4IJEZq3
        wpGCG23tPuyMcNEw4Wtz8un3DaBzysyuceVKHYoGaJd49rtRKWhGwAIEad56zsqLGhiXFV9hzRtgm
        IGv0In2BE8ztJgDCUkbdMyFRnjxViS/vBFJs7Z8cr+bj5XzD0FgzKiBqAdFx3qc+gYMZLT8Nobz3u
        Zwwht8Vg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mq0hA-00563U-Jd
        for netfilter-devel@vger.kernel.org; Wed, 24 Nov 2021 22:24:52 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 27/30] output: JSON: fix possible leak in error-handling.
Date:   Wed, 24 Nov 2021 22:24:36 +0000
Message-Id: <20211124222444.2597311-42-jeremy@azazel.net>
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

The `realloc` extending the buffer containing the JSON to allow us to
insert a final new-line may fail.  Therefore, we need to assign the
return-value to a temporary variable or we will not able to free the
existing buffer on error.

Use the correct type for `buflen`.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/ulogd_output_JSON.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/output/ulogd_output_JSON.c b/output/ulogd_output_JSON.c
index d949df6bb530..6af872c64391 100644
--- a/output/ulogd_output_JSON.c
+++ b/output/ulogd_output_JSON.c
@@ -275,8 +275,8 @@ static int json_interp(struct ulogd_pluginstance *upi)
 {
 	struct json_priv *opi = (struct json_priv *) &upi->private;
 	unsigned int i;
-	char *buf;
-	int buflen;
+	char *buf, *tmp;
+	size_t buflen;
 	json_t *msg;
 
 	msg = json_object();
@@ -338,8 +338,6 @@ static int json_interp(struct ulogd_pluginstance *upi)
 		json_object_set_new(msg, "dvc", json_string(dvc));
 	}
 
-
-
 	for (i = 0; i < upi->input.num_keys; i++) {
 		struct ulogd_key *key = upi->input.keys[i].u.source;
 		char *field_name;
@@ -392,7 +390,6 @@ static int json_interp(struct ulogd_pluginstance *upi)
 		}
 	}
 
-
 	buf = json_dumps(msg, 0);
 	json_decref(msg);
 	if (buf == NULL) {
@@ -400,11 +397,13 @@ static int json_interp(struct ulogd_pluginstance *upi)
 		return ULOGD_IRET_ERR;
 	}
 	buflen = strlen(buf);
-	buf = realloc(buf, sizeof(char)*(buflen+2));
-	if (buf == NULL) {
+	tmp = realloc(buf, buflen + sizeof("\n"));
+	if (tmp == NULL) {
+		free(buf);
 		ulogd_log(ULOGD_ERROR, "Could not create message\n");
 		return ULOGD_IRET_ERR;
 	}
+	buf = tmp;
 	strncat(buf, "\n", 1);
 	buflen++;
 
-- 
2.33.0

