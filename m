Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73F92C834A
	for <lists+netfilter-devel@lfdr.de>; Mon, 30 Nov 2020 12:32:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726991AbgK3LcI (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 30 Nov 2020 06:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbgK3LcI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 30 Nov 2020 06:32:08 -0500
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F1FFC0613D3
        for <netfilter-devel@vger.kernel.org>; Mon, 30 Nov 2020 03:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=dnI5g5DHWNd8h5eL+rPB79KpYBNtt6FKexnRs4EMC3M=; b=RpOZ0lEci5KSjN2QW1MvF6AczL
        K6QMI+uX53aM/hz8grCOR4YBNsYinOYrJZZXsAvurfA+P9tUGwROM1tN+0KfQ+J61uh6S+6g2Gq+z
        C+U/GDSyFqQUF0EI5MU8mYQ7t024hR5hVhj8tqivOppTZS5B/ot3H/M8lOP1Pl+ohpVi1G4whXAEY
        rAdxWfeIEp7Q6cF4YkFKntFcmjLRvD57CO5vdtce0SnvpjXBi1XQ/+hsRVt2mL7llKRM8G5/2bAr1
        ujXpVpofkWiOPzMmOGZTkFTPlwOa9maUVbss4VrG/7xTSbmY4+36CbYFknyGi4JaTjMOikPnyQWJx
        ytNIHLDg==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kjhOw-0002ji-Pm; Mon, 30 Nov 2020 11:31:26 +0000
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH libnetfilter_log 1/2] build: remove duplicate `-lnfnetlink` from LDFLAGS.
Date:   Mon, 30 Nov 2020 11:31:24 +0000
Message-Id: <20201130113125.1346744-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130113125.1346744-1-jeremy@azazel.net>
References: <20201130113125.1346744-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

`$(libnetfilter_log_la_LIBADD)` includes `$(LIBNFNETLINK_LIBS)`, so there's no
need to include `-lnfnetlink` in `$(libnetfilter_log_la_LDFLAGS)`.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 src/Makefile.am | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/Makefile.am b/src/Makefile.am
index aa561525585c..33be04828223 100644
--- a/src/Makefile.am
+++ b/src/Makefile.am
@@ -24,7 +24,7 @@ include ${top_srcdir}/Make_global.am
 
 lib_LTLIBRARIES = libnetfilter_log.la
 
-libnetfilter_log_la_LDFLAGS = -Wc,-nostartfiles -lnfnetlink	\
+libnetfilter_log_la_LDFLAGS = -Wc,-nostartfiles	\
 			      -version-info $(LIBVERSION)
 libnetfilter_log_la_SOURCES = libnetfilter_log.c nlmsg.c
 libnetfilter_log_la_LIBADD  = ${LIBNFNETLINK_LIBS} ${LIBMNL_LIBS}
-- 
2.29.2

