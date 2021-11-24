Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F1345D039
	for <lists+netfilter-devel@lfdr.de>; Wed, 24 Nov 2021 23:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbhKXWsG (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 24 Nov 2021 17:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244645AbhKXWsG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 24 Nov 2021 17:48:06 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409FDC061574
        for <netfilter-devel@vger.kernel.org>; Wed, 24 Nov 2021 14:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=sn0iRpgzZvU+CpjrzxUzsqmp/WocOoxP8tBjqd38NeI=; b=pmWc0Pc1kelllgSR6/vmtr6ktR
        x7wZFUOr6IUHGxj/4qj9bHxkgab/pH6LfyVLahWPsI2julwLJ3XWE1ztFn1ZBpTBev7TOg4Hg8YcP
        PmJhNorWVfEUg8ho/LzlS4RNFdyVEIhLc5sI65v+tePn9GIGDZ33PuNAZKHOFKwJKq21FHnEiwhv1
        0WJ5jjXPwhGGGpDf8d0w0JC4CGkHUdWgcHHuF34kKpRcjWDrBWivLT2nkFB5EINvRUoywQi9s1hE1
        9y+ScfTlubLf/AOpn3i8LL7ZTmXpufM5TEXxb9ND6skB10dhUwKJ7yAlb9Kx1UhRxFlF+W423QsCm
        UltT1xvw==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mq0hA-00563U-MO
        for netfilter-devel@vger.kernel.org; Wed, 24 Nov 2021 22:24:52 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v3 28/32] output: JSON: increase time-stamp buffer size
Date:   Wed, 24 Nov 2021 22:24:37 +0000
Message-Id: <20211124222444.2597311-43-jeremy@azazel.net>
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

The output buffer for date-times is of sufficient size provided that we
don't get oversized integer values for any of the fields, which is a
reasonable assumption.  However, the compiler complains about possible
truncation, e.g.:

  ulogd_output_JSON.c:314:65: warning: `%06u` directive output may be truncated writing between 6 and 10 bytes into a region of size between 0 and 18
  ulogd_output_JSON.c:313:25: note: `snprintf` output between 27 and 88 bytes into a destination of size 38

Fix the warnings by increasing the buffer size.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/ulogd_output_JSON.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/output/ulogd_output_JSON.c b/output/ulogd_output_JSON.c
index f5c065dd062a..d949df6bb530 100644
--- a/output/ulogd_output_JSON.c
+++ b/output/ulogd_output_JSON.c
@@ -269,7 +269,7 @@ static int json_interp_file(struct ulogd_pluginstance *upi, char *buf)
 	return ULOGD_IRET_OK;
 }
 
-#define MAX_LOCAL_TIME_STRING 38
+#define MAX_LOCAL_TIME_STRING 80
 
 static int json_interp(struct ulogd_pluginstance *upi)
 {
-- 
2.33.0

