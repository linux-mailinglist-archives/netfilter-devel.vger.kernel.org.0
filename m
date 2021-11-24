Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B38645D032
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 23:44:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbhKXWrw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 17:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhKXWrw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:47:52 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2C4C061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Nov 2021 14:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=c4xUIge6moSsJz06dPbPa8cuDJ+Z3y2n20LGQJK0n2c=; b=YzuyCQl8HQbsljvMIsuYuXrD1/
        sos9BRFa9TUt7PaU/KOSVjzFtvK4V4W3QWitMQzM267w/Fm7lcNe6pNiAkoUL5awddC498eHv47xJ
        jx5fGAw5+RRDCe6hG803kViRGCJ2mzMd9gdS3cNJEDiJPzmlbZxo6NW4sxc2A0SGCn4KaAE1LGP5Z
        cIHK2bdokiB0rJjuWdukSliCVjNvE5pW+K3rHYeeatE9bEBIULUQUGuM7I0NGs6CrZ9boIB52Sm5p
        kVUbX6O2S0OukGTftwPn7wTtnv9uHYY+0MZmQfxNXFS7LEvXNuHr/+Q+9il2LYptBVy3c/YnyDUwJ
        egs7OB8Q==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mq0hA-00563U-Vp
        for netfilter-devel@vger.kernel.org; Wed, 24 Nov 2021 22:24:53 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 29/30] output: JSON: fix possible truncation of socket path
Date:   Wed, 24 Nov 2021 22:24:40 +0000
Message-Id: <20211124222444.2597311-46-jeremy@azazel.net>
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

Verify that the path is short enough, and replace `strncpy` with `strcpy`.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/ulogd_output_JSON.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/output/ulogd_output_JSON.c b/output/ulogd_output_JSON.c
index f60bd6ea51da..33428c96b84b 100644
--- a/output/ulogd_output_JSON.c
+++ b/output/ulogd_output_JSON.c
@@ -147,7 +147,8 @@ static void close_socket(struct json_priv *op) {
 static int _connect_socket_unix(struct ulogd_pluginstance *pi)
 {
 	struct json_priv *op = (struct json_priv *) &pi->private;
-	struct sockaddr_un u_addr;
+	struct sockaddr_un u_addr = { .sun_family = AF_UNIX };
+	const char *socket_path = file_ce(pi->config_kset).u.string;
 	int sfd;
 
 	close_socket(op);
@@ -155,14 +156,16 @@ static int _connect_socket_unix(struct ulogd_pluginstance *pi)
 	ulogd_log(ULOGD_DEBUG, "connecting to unix:%s\n",
 		  file_ce(pi->config_kset).u.string);
 
+	if (strlen(socket_path) >= sizeof(u_addr.sun_path))
+		return -1;
+
+	strcpy(u_addr.sun_path, socket_path);
+
 	sfd = socket(AF_UNIX, SOCK_STREAM, 0);
-	if (sfd == -1) {
+	if (sfd == -1)
 		return -1;
-	}
-	u_addr.sun_family = AF_UNIX;
-	strncpy(u_addr.sun_path, file_ce(pi->config_kset).u.string,
-		sizeof(u_addr.sun_path) - 1);
-	if (connect(sfd, (struct sockaddr *) &u_addr, sizeof(struct sockaddr_un)) == -1) {
+
+	if (connect(sfd, (struct sockaddr *) &u_addr, sizeof(u_addr)) == -1) {
 		close(sfd);
 		return -1;
 	}
-- 
2.33.0

