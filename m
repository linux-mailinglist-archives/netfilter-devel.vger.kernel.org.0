Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CE2C3FA75D
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 21:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbhH1Tlf (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 15:41:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbhH1Tle (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 15:41:34 -0400
Received: from kadath.azazel.net (kadath.azazel.net [IPv6:2001:8b0:135f:bcd1:e0cb:4eff:fedf:e608])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7C7C0613D9
        for <netfilter-devel@vger.kernel.org>; Sat, 28 Aug 2021 12:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=azazel.net;
        s=20190108; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Cf+xTkIYyI5H93QtwazoFQ+zepqhsotuoVP2bW1cRQc=; b=oGeF9W324CNoWONTjUdwPTRI3G
        k7uQ89i8QsPZYKs7WjgjoOdK2iB/OQuL/eyvNAgUk+Whygg3HtR2l5d92K3+GR1LoK4dHQ3QQZ4DM
        iJfQbwGQuUwPBzt9lI+SdTm4TLTUAAwnhStu8Xnm9URzUOsdgFmTSJpe6pITgq4j/Q55l6otjgn8U
        rzEYQW5nCaFLXEkES7+WBk5BJyfxTHNTi1eEa5pd6TS2OBqAKnqowAHFOzfsDlqyYdbPCwZP8gZNF
        01hlNSG/tfTIIYuoxLrn58ee/R60Yc8HrEmOOpYsEcB4IYQ4/h0xn4/aOy5N5prfj39VrgSZ06kum
        4rmRPA4A==;
Received: from ulthar.dreamlands.azazel.net ([2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae])
        by kadath.azazel.net with esmtp (Exim 4.94.2)
        (envelope-from <jeremy@azazel.net>)
        id 1mK4C1-00FeN7-El; Sat, 28 Aug 2021 20:40:41 +0100
From:   Jeremy Sowden <jeremy@azazel.net>
To:     Pablo Neira Ayuso <pablo@netfilter.org>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: [PATCH libnetfilter_log 1/6] Add doxygen directory to .gitignore.
Date:   Sat, 28 Aug 2021 20:38:19 +0100
Message-Id: <20210828193824.1288478-2-jeremy@azazel.net>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210828193824.1288478-1-jeremy@azazel.net>
References: <20210828193824.1288478-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:8b0:fb7d:d6d7:2e4d:54ff:fe4b:a9ae
X-SA-Exim-Mail-From: jeremy@azazel.net
X-SA-Exim-Scanned: No (on kadath.azazel.net); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Signed-off-by: Jeremy Sowden <jeremy@azazel.net>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index f4938e98d7e9..5eaabe38a514 100644
--- a/.gitignore
+++ b/.gitignore
@@ -13,5 +13,6 @@ Makefile.in
 /configure
 /libtool
 
+/doxygen/
 /doxygen.cfg
 /*.pc
-- 
2.33.0

