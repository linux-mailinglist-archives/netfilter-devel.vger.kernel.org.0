Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F33ABB3A83
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Sep 2019 14:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbfIPMmJ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Sep 2019 08:42:09 -0400
Received: from kadath.azazel.net ([81.187.231.250]:44756 "EHLO
        kadath.azazel.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfIPMmI (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Sep 2019 08:42:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0ZdSoA8UFr+WfhhhGa1gkBE2Um0kBBZCAd42jeQaOSA=; b=VJx4Ozw8Z5mpe1TnT/uVEqpbjL
        bpdEj9HD0Ezzz/bb9u/H3yUT9bXK8ioebTlpSn4YeImVfbRsiaJSrgMsTvWO/fQzCu7rBq7VfjQMo
        JOm+xOb0PevM5SXlomJRpJ3HqqcZ8P7tPUOlFVrd0I0ZzlPdp12ZAiVAX3gUZgnO7Tw2D+5zZRpvt
        QOpjilVndIfYN0fP3A0qpYMFq4Qy1//f0UEEFlPb6KHe8E249rS/80+7V60O1d6V0A1PxiYZlxGEX
        E31zxOEaDwUlp6sbrhZzFIWtEXnqP+7h3MbldCnh3PntmBepKAWZnYPRn24sn54ZT00OS71XGzOxM
        mDMdT1uQ==;
Received: from ulthar.dreamlands ([192.168.96.2])
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1i9qKS-0005OR-B6; Mon, 16 Sep 2019 13:42:04 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Cc:     Sebastian Priebe <sebastian.priebe@de.sii.group>
Subject: [PATCH RFC nftables 1/4] configure: remove unused AC_SUBST macros.
Date:   Mon, 16 Sep 2019 13:42:00 +0100
Message-Id: <20190916124203.31380-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190916124203.31380-1-jeremy@azazel.net>
References: <4df20614cd10434b9f91080d0862dd0c@de.sii.group>
 <20190916124203.31380-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

configure.ac contains a couple of AC_SUBST macros which serve no
purpose.  Remove them.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 2 --
 1 file changed, 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index f26514376fd0..68f97f090535 100644
--- a/configure.ac
+++ b/configure.ac
@@ -75,7 +75,6 @@ AC_CHECK_LIB([readline], [readline], ,
 	     AC_MSG_ERROR([No suitable version of libreadline found]))
 AC_DEFINE([HAVE_LIBREADLINE], [1], [])
 ])
-AC_SUBST(with_cli)
 AM_CONDITIONAL([BUILD_CLI], [test "x$with_cli" != xno])
 
 AC_ARG_WITH([xtables], [AS_HELP_STRING([--with-xtables],
@@ -95,7 +94,6 @@ AC_CHECK_LIB([jansson], [json_object], ,
 	AC_MSG_ERROR([No suitable version of libjansson found]))
 AC_DEFINE([HAVE_LIBJANSSON], [1], [Define if you have libjansson])
 ])
-AC_SUBST(with_json)
 AM_CONDITIONAL([BUILD_JSON], [test "x$with_json" != xno])
 
 AC_ARG_ENABLE(python,
-- 
2.23.0

