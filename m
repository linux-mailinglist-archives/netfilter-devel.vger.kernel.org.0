Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55AA463214
	for <lists+netfilter-devel@lfdr.de>; Tue, 30 Nov 2021 12:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237756AbhK3LSh (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 30 Nov 2021 06:18:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237685AbhK3LSh (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:18:37 -0500
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97659C061574
        for <netfilter-devel@vger.kernel.org>; Tue, 30 Nov 2021 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=uN5cwDuVwhDH8mtj9OGQ5nsS1wkDnpUOigqeSVCswgA=; b=ET1stEB6qfI6Br5xE23LhSvZMz
        a278HnbiqzaUQf7yubNrGYRLIIORFdQjc6uE/lBR3Kx17wEdPLuBo2IZm0VmQToePH+ZytQftEZfh
        aeyLWDyrNY7IPCLpfMp/nCpzucFY3FVGUxguO2tGqeFzjFUe37Mq+i1q+HCT3cUMLqhnYTe3Ve9hh
        gUcvYQePgvEP595wlMKavHf8AHHVvTNC2A/PS21Nuss9KMmVF/Zjv1THgUIGX4gnYY8GbfdNFr7cE
        6mhu3Jcv8sKCUNYYF30aNIPJiZZB2/mavlixwQFBb/g9wNp/azlxB3sd+/HgGJcztxrqlMqnLpTLe
        K2gFG6nA==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1ms0nt-00Awwr-GU
        for netfilter-devel@vger.kernel.org; Tue, 30 Nov 2021 10:56:05 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [ulogd2 PATCH v4 27/32] output: JSON: fix output of GMT offset
Date:   Tue, 30 Nov 2021 10:55:55 +0000
Message-Id: <20211130105600.3103609-28-jeremy@azazel.net>
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

The compiler has two sets of complaints.  Firstly, `t->tm_gmtoffset` is
a `long int`, but it is being passed to `abs`, which leads to warnings
such as:

  ulogd_output_JSON.c:308:34: warning: absolute value function `abs` given an argument of type `long int` but has parameter of type `int` which may cause truncation of value

Secondly, it can't verify that the hour value derived from the offset
will in fact fit into `%02d`, thus:

  ulogd_output_JSON.c:306:37: warning: `%02d` directive output may be truncated writing between 2 and 6 bytes into a region of size 5

To remedy these, we now mod the offset by 86,400 and assign it to an `int`
before deriving the hour and minute values.

We also change the format-specifier for the hour value to `%+03d` which
causes a sign to be printed even if the value is positive, thus allowing
us not to specify the sign explicitly and to drop the `abs` call for the
hour value.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 output/ulogd_output_JSON.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/output/ulogd_output_JSON.c b/output/ulogd_output_JSON.c
index 6edfa902efaf..f5c065dd062a 100644
--- a/output/ulogd_output_JSON.c
+++ b/output/ulogd_output_JSON.c
@@ -302,11 +302,12 @@ static int json_interp(struct ulogd_pluginstance *upi)
 			now = time(NULL);
 		t = localtime_r(&now, &result);
 		if (unlikely(*opi->cached_tz = '\0' || t->tm_gmtoff != opi->cached_gmtoff)) {
+			int gmtoff   = t->tm_gmtoff % 86400;
+			int gmtoff_h = gmtoff / 3600;
+			int gmtoff_m = abs(gmtoff) / 60 % 60;
+
 			snprintf(opi->cached_tz, sizeof(opi->cached_tz),
-				 "%c%02d%02d",
-				 t->tm_gmtoff > 0 ? '+' : '-',
-				 abs(t->tm_gmtoff) / 60 / 60,
-				 abs(t->tm_gmtoff) / 60 % 60);
+				 "%+03d%02d", gmtoff_h, gmtoff_m);
 		}
 
 		if (pp_is_valid(inp, opi->usec_idx)) {
-- 
2.33.0

