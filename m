Return-Path: <netfilter-devel+bounces-362-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A154A81369E
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Dec 2023 17:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A81FCB20CD4
	for <lists+netfilter-devel@lfdr.de>; Thu, 14 Dec 2023 16:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9AD60EE0;
	Thu, 14 Dec 2023 16:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=azazel.net header.i=@azazel.net header.b="IiaCjNyj"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from azazel.net (unknown [IPv6:2a05:d01c:431:aa03:b7e1:333d:ea2a:b14e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0800311D
	for <netfilter-devel@vger.kernel.org>; Thu, 14 Dec 2023 08:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
	s=20220717; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oe0K+IXE2u5A2ukTey1u7Ej/nhqidC0FnUGJxqr59Hs=; b=IiaCjNyjAWvA8hgR/nznNMfXEE
	JWqg0TNmi3fgN62Uq1AwHhCR3mdzO0P1eXI4DBvLbsX8wIQGmfSpliiB1+Moa+7PVl5GtmZYnwxXC
	NF+EyjyPMzL4unmQaMQ5vdpaGCJaJNxYIrZectaG6s9eMIkh6QfENo/q8GFAELvvZByJMQvOzmZ3x
	TgAgWZFu5zCaAa0ccpJKruVUH8f514qqLOIVFR1PGDegioyBa2ZxIGVTHzB7PIhTqs2KEQx54CTNd
	KPYDOPkDtB47HQg3qQOk6mLlT7WXqW7oGwy76TRow31U4HPdv8kWUqY0Rfy9JLdoHuXQEBb15TQ/g
	8lTwfK4A==;
Received: from [2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608] (helo=ulthar.dreamlands)
	by taras.nevrast.org with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <jeremy@azazel.net>)
	id 1rDoor-0038UN-2L
	for netfilter-devel@vger.kernel.org;
	Thu, 14 Dec 2023 16:44:17 +0000
From: Jeremy Sowden <jeremy@azazel.net>
To: Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH iptables v2 5/6] build: add an automake verbosity variable for `ln`
Date: Thu, 14 Dec 2023 16:44:04 +0000
Message-ID: <20231214164408.1001721-6-jeremy@azazel.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231214164408.1001721-1-jeremy@azazel.net>
References: <20231214164408.1001721-1-jeremy@azazel.net>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on taras.nevrast.org); SAEximRunCond expanded to false

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 extensions/GNUmakefile.in | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/extensions/GNUmakefile.in b/extensions/GNUmakefile.in
index f91ebf5e4e6e..dfa58c3b9e8b 100644
--- a/extensions/GNUmakefile.in
+++ b/extensions/GNUmakefile.in
@@ -39,14 +39,17 @@ am__v_AR_0           = @echo "  AR      " $@;
 am__v_CC_0           = @echo "  CC      " $@;
 am__v_CCLD_0         = @echo "  CCLD    " $@;
 am__v_GEN_0          = @echo "  GEN     " $@;
+am__v_LN_0           = @echo "  LN      " $@;
 am__v_AR_            = ${am__v_AR_@AM_DEFAULT_V@}
 am__v_CC_            = ${am__v_CC_@AM_DEFAULT_V@}
 am__v_CCLD_          = ${am__v_CCLD_@AM_DEFAULT_V@}
 am__v_GEN_           = ${am__v_GEN_@AM_DEFAULT_V@}
+am__v_LN_            = ${am__v_LN_@AM_DEFAULT_V@}
 AM_V_AR              = ${am__v_AR_@AM_V@}
 AM_V_CC              = ${am__v_CC_@AM_V@}
 AM_V_CCLD            = ${am__v_CCLD_@AM_V@}
 AM_V_GEN             = ${am__v_GEN_@AM_V@}
+AM_V_LN              = ${am__v_LN_@AM_V@}
 
 #
 #	Wildcard module list
@@ -140,17 +143,17 @@ lib%.oo: ${srcdir}/lib%.c
 	${AM_V_CC} ${CC} ${AM_CPPFLAGS} ${AM_DEPFLAGS} ${AM_CFLAGS} -D_INIT=lib$*_init -DPIC -fPIC ${CFLAGS} -o $@ -c $<;
 
 libxt_NOTRACK.so: libxt_CT.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 libxt_state.so: libxt_conntrack.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 libxt_REDIRECT.so: libxt_NAT.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 libxt_MASQUERADE.so: libxt_NAT.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 libxt_SNAT.so: libxt_NAT.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 libxt_DNAT.so: libxt_NAT.so
-	ln -fs $< $@
+	${AM_V_LN} ln -fs $< $@
 
 # Need the LIBADDs in iptables/Makefile.am too for libxtables_la_LIBADD
 xt_RATEEST_LIBADD   = -lm
-- 
2.43.0


