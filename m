Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20893257762
	for <lists+netfilter-devel@lfdr.de>; Mon, 31 Aug 2020 12:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgHaKgp (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 31 Aug 2020 06:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726204AbgHaKgo (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 31 Aug 2020 06:36:44 -0400
Received: from kadath.azazel.net (unknown [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271E5C061573
        for <netfilter-devel@vger.kernel.org>; Mon, 31 Aug 2020 03:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
         s=20190108; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=5xggnq6qBiB/iIsI/rhgljEDvE3aaPg691NcOmydijA=; b=PD49v47r/HZn2hCbQNjPtFgQPv
        Cmz+YyoYZijDkV3+yzQh0N12WAOwAV5CjXGbHNJB33X0w48wCcHbLX9n9hyeVUYr6xTfpvb101nRS
        7eEXokHmlGefZv6Fnks7VePm3hFjNhLRpifWaAbO8Mah2DGZsmysH2mxikDcyC22q5++M/Ggh+FAX
        MeC8KSTjMIk4dBuETcCOwZR8Uz3mJiVd5uiKXsxRb35O/6Nmm+B8pe+LFXujwRkKp8Y271JVdQReB
        uuHeEEzsrZy6I90APGq70PyY9bcptx1MQJ+ybkaFw4S+fU5DLhj2BdlslVcoGDwMzLbj3P7Xo5tkG
        AnGwpEyA==;
Received: from ulthar.dreamlands ([192.168.96.2] helo=ulthar.dreamlands.azazel.net)
        by kadath.azazel.net with esmtp (Exim 4.92)
        (envelope-from <jeremy@azazel.net>)
        id 1kChB0-0007Zt-38; Mon, 31 Aug 2020 11:36:38 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Jan Engelhardt <jengelh@inai.de>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>,
        Helmut Grohne <helmut@subdivi.de>
Subject: [PATCH xtables-addons] build: don't hard-code pkg-config.
Date:   Mon, 31 Aug 2020 11:36:35 +0100
Message-Id: <20200831103635.524666-1-jeremy@azazel.net>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 192.168.96.2
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

From: Helmut Grohne <helmut@subdivi.de>

Use $PKG_CONFIG in configure.ac in order to allow it to be overridden.
Fixes cross-compilation.

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 8f8a13b9d4b7..7d779964f77d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -27,7 +27,7 @@ fi
 AC_CHECK_HEADERS([linux/netfilter/x_tables.h], [],
 	[AC_MSG_ERROR([You need to have linux/netfilter/x_tables.h, see INSTALL file for details])])
 PKG_CHECK_MODULES([libxtables], [xtables >= 1.6.0])
-xtlibdir="$(pkg-config --variable=xtlibdir xtables)"
+xtlibdir="$($PKG_CONFIG --variable=xtlibdir xtables)"
 
 AC_ARG_WITH([xtlibdir],
 	AS_HELP_STRING([--with-xtlibdir=PATH],
-- 
2.28.0

